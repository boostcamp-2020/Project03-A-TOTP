//
//  TokenService.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/29.
//

import Foundation

final class TokenService: TokenServiceable {
    
    // MARK: Property
    
    private var storageManager: StorageManager
    private var tokens: [Token] = []
    
    var tokenCount: Int {
        tokens.count
    }
    
    // MARK: Init
    
    init(_ storageManager: StorageManager) {
        self.storageManager = storageManager
        self.tokens = storageManager.loadTokens() ?? []
        designateMain()
    }
    
    // MARK: Methods
    
    func token(id: String) -> Token? {
        tokens.first(where: { $0.id == id })
    }
    
    func tokenList() -> [Token] {
        return tokens
    }
    
    /// 메인뷰 메인 토큰 지정
    func designateMain() {
        for index in tokens.indices where tokens[index].isMain == true { return }
        if self.tokens.count == 0 { return }
        tokens[0].isMain = true
    }
    
    // completion 받아와야
    func refreshTokens(updateView: @escaping (MainNetworkResult) -> Void) {
        // (토큰 정보 바뀔 때마다 우리 디바이스에 있는 시간 update 해야된다.)
        
        // 받아온 데이터 어떤게 더 최신인지 확인,
        // case 로컬이 최신 - 그냥 로컬 데이터로(이미 로컬에 데이터가 존재함) show
        // 또한 로컬에 있는 데이터를 서버에 쏴서 싱크를 맞춰줘야 함. - 이거 좀ㅁ만 나중에 하자
        // case server - 서버 데이터로 로컬 데이터를 수정해주고, service에 있는 tokens도 변경해주고 show 하게 함
        // case error -> alert 띄우게
        
        TokenNetworkManager.shared.load {
            
            [self] result in
            switch result {
            case .successLoad(let serverData): // 시간 비교.
                if let time = serverData.lastUpdate {
                    do {
                        if try self.isRecentLocal(time: time) { // 로컬이 최신
                            designateMain()
                            updateView(result) // showMain 실행
                            syncToServer(lastupdateTime: time, updateView)
                        } else { // 서버가 최신
                            // 서버 데이터를 로컬에 저장 - 복호화 시도 - 성공 or 실패
                            if let tokens = serverData.tokens {
                                if tokens.count == 0 {
                                    updateView(.noTokens)
                                    return
                                }
                                switch self.decryptTokenKeys(tokens: tokens) {
                                case .successLoad(let decryptedResult): // 복호화 성공
                                    //TODO: 서버 시간으로 업데이트 해야함
                                    if let decryptedTokens = decryptedResult.tokens {
                                        self.tokens = decryptedTokens // service에 있는 tokens 업데이트
                                        designateMain()
                                        updateView(.successLoad(decryptedResult))
                                        print("디크립트 성공")
                                        if var user = DDISUserCache.get() {
                                            user.device?.lastUpdate = time
                                            DDISUserCache.save(user)
                                        }
                                    } else {
                                        print("디크립트 실패")
                                    }
                                case .failedDecryption:
                                    print("failedDecryption")
                                    tokens.isEmpty
                                        ? updateView(.noTokens)
                                        : updateView(.failedDecryption(tokens))
                                    
                                case .noBackupPassword:
                                    print("noBackupPassword 리프레시")
                                    updateView(.noBackupPassword(tokens))
                                default: break
                                }
                                // 복호화 - 토큰이랑 비밀 번호 주면 시도. - 성공 of 실패
                                // 성공하면 그대로 로컬 데이터 업데이트 - success - showMain 어쩌구 실행
                                // 실패하면 비밀 번호 설정하도록 유도 - failDecrption - (비번 다시 설정, 비번설정)
                            } else { // 토큰이 없음 -> 모두 삭제한 게 최신이라는 의미 - 데이터 없음!
                                tokens.removeAll()
                                _ = storageManager.deleteTokens()
                                updateView(.noTokens)
                            }
                        }
                    } catch {
                        print(error)
                    }
                } else {
                    print("시간값이 없다.")
                }
            default: break
            }
        }
    }
    
    func syncToServer(lastupdateTime: String,
                      _ updateView: @escaping (MainNetworkResult) -> Void) {
        // 암호화
        var encryptedTokens = [Token]()
        tokens.forEach {
            var token = $0
            if let password = getPassword() {
                if let key = token.key {
                    do {
                        token.key = try TokenCryptoManager(password).encrypt(with: key)
                    } catch {
                        updateView(.failedEncryption)
                        print("치명적(fatal)error", error)
                    }
                }
            } else {
                print("백업 비밀번호가 없다!")
                updateView(.noBackupPassword([]))
            }
            encryptedTokens.append(token)
        }
        
        TokenNetworkManager.shared.syncTokens(
            lastUpdate: lastupdateTime, tokens: encryptedTokens) { result in
            switch result {
            case .successLoad:
                print("성공")
            default: break
            }
        }
    }
    
    func saveResult() {
        // last 시간을 디바이스에 저장 - 서버가 최신인 경우
        // service에 있는 토큰 update
    }
    
    /// 토큰추가
    func add(token: Token) {
        var token = token
        if tokens.count == 0 {
            token.isMain = true
        }
        tokens.append(token)
        _ = storageManager.storeTokens(tokens)
        DDISUserCache.updateDate()
        if isBackUp() {
            do {
                if let key = token.key,
                   let password = getPassword() {
                    token.key = try TokenCryptoManager(password).encrypt(with: key)
                    TokenNetworkManager.shared.create(token: token) {
                        print("저장 성공...")
                    }
                }
            } catch {
                print("저장 실패..")
            }
        }
    }
    
    /// 토큰 수정
    func update(token: Token) {
        guard let index = tokens.firstIndex(where: { $0.id == token.id }) else { return }
        tokens[index] = token
        _ = storageManager.storeTokens(tokens)
        DDISUserCache.updateDate()
        if isBackUp() {
            TokenNetworkManager.shared.modify(token: token) {
                print("수정 성공")
            }
        }
    }
    
    /// 메인 토큰 찾아 리턴
    func mainToken() -> Token? {
        var token: Token?
        tokens.forEach {
            if $0.isMain == true {
                token = $0
                return
            }
        }
        return token
    }
    
    /// 메인토큰 뺀 나머지 토큰 리턴
    func excludeMainCell() -> [Token] {
        tokens.filter {
            guard let isMain = $0.isMain else { return true }
            return !isMain
        }
    }
    
    /// 메인 토큰 상태 업데이트
    func updateMainToken(id: String) {
        guard let oldMainTokenIndex = tokens.firstIndex(where: {
            guard let isMain = $0.isMain else { return false }
            return isMain
        }) else { return }
        tokens[oldMainTokenIndex].isMain = false
        tokens.move(fromOffsets: IndexSet(integer: oldMainTokenIndex), toOffset: 0)
        if let index = tokens.firstIndex(where: { $0.id == id }) {
            tokens[index].isMain = true
        }
        _ = storageManager.storeTokens(tokens)
    }
    
    /// 토큰 삭제
    func removeTokens(_ idList: [String]) {
        idList.forEach { id in
            tokens.removeAll(where: { $0.id == id })
        }
        _ = storageManager.storeTokens(tokens)
        if tokens.count == 0 { return }
        updateMainWithFirstToken()
        DDISUserCache.updateDate()
        if isBackUp() {
            for id in idList {
                TokenNetworkManager.shared.delete(id: id) {
                    print("삭제 성공")
                }
            }
        }
    }
    
    /// 토큰 위치 수정
    func updateTokenPosition(from: Int, target: Int) {
        tokens.move(fromOffsets: IndexSet(integer: from),
                    toOffset: target > from ? target + 1 : target)
        _ = storageManager.storeTokens(tokens)
    }
    
}

extension TokenService {
    
    func isBackUp() -> Bool {
        return DDISUserCache.get()?.device?.backup != nil
    }
    
    func getPassword() -> String? {
        return BackupPasswordManager().loadPassword()
    }
    
    func updateMainWithFirstToken() {
        if nil !=  mainToken() {
            return
        } else {
            tokens[0].isMain = true
        }
    }
    
    /// 로컬시간 최신 여부 판별해서 리턴
    func isRecentLocal(time: String) throws -> Bool {
        if let user = DDISUserCache.get() {
            guard let deviceTime = user.device?.lastUpdate?.timeFormatToDate() else {
                throw TimeError.localTime
            }
            guard var serverTime = time.timeFormatToDate() else {
                throw TimeError.serverTime
            }
            
            serverTime = Calendar.current.date(byAdding: .hour, value: 9, to: serverTime)!
            if deviceTime <= serverTime { // 서버가 최신
                print("서버가 최신이다.. 로컬: \(deviceTime), 서버: \(serverTime)")
                return false
            } else {
                print("지금 로컬이 최신이다.. 로컬: \(deviceTime), 서버: \(serverTime)")
                return true
            }
        } else {
            // 불러오기 실패
            return true
        }
    }
    
    /// 토큰배열에 들어있는 키 Decrypt하고 상태 리턴
    func decryptTokenKeys(tokens: [Token],
                          password: String? = nil) -> MainNetworkResult {
        
        var decryptedTokens = [Token]()
        var result: MainNetworkResult = .failedDecryption(tokens)
        tokens.forEach {
            var token = $0
            if let password = password {
                if let key = token.key {
                    do {
                        token.key = try TokenCryptoManager(password).decrypt(from: key)
                    } catch {
                        result = .failedDecryption(tokens)
                        return
                    }
                }
            } else {
                if let password = BackupPasswordManager().loadPassword() {
                    if let key = token.key {
                        do {
                            token.key = try TokenCryptoManager(password).decrypt(from: key)
                        } catch {
                            result = .failedDecryption(tokens)
                            return
                        }
                    }
                } else {
                    result = .noBackupPassword([])
                    return
                }
            }
            decryptedTokens.append(token)
            result = .successLoad(TokenNetworkType(lastUpdate: nil, tokens: decryptedTokens))
        }
        
        self.tokens = decryptedTokens
        _ = storageManager.storeTokens(decryptedTokens)
        return result
    }
    
    
}

enum TimeError: Error {
    case localTime
    case serverTime
}
