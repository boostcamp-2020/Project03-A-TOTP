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
    func designateMain() {
        for index in tokens.indices where tokens[index].isMain == true { return }
        if self.tokens.count == 0 { return }
        tokens[0].isMain = true
    }
    
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
    
    // completion 받아와야
    func refreshTokens(updateView: @escaping (MainNetworkResult) -> Void) {
        // (토큰 정보 바뀔 때마다 우리 디바이스에 있는 시간 update 해야된다.)
        
        // 받아온 데이터 어떤게 더 최신인지 확인,
        // case 로컬이 최신 - 그냥 로컬 데이터로(이미 로컬에 데이터가 존재함) show
        // 또한 로컬에 있는 데이터를 서버에 쏴서 싱크를 맞춰줘야 함. - 이거 좀ㅁ만 나중에 하자
        // case server - 서버 데이터로 로컬 데이터를 수정해주고, service에 있는 tokens도 변경해주고 show 하게 함
        // case error -> alert 띄우게
        
        TokenNetworkManager.shared.load { [self] result in
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
                                    if let decryptedTokens = decryptedResult.tokens {
                                        _ = storageManager.storeTokens(decryptedTokens)
                                        DispatchQueue.main.async {
                                            self.tokens = decryptedTokens // service에 있는 tokens 업데이트
                                            designateMain()
                                            updateView(.successLoad(decryptedResult))
                                        }
                                    } else {
                                        print("여기")
                                    }
                                case .failedDecryption:
                                    print("failedDecryption")
                                    tokens.isEmpty
                                        ? updateView(.noTokens)
                                        : updateView(.failedDecryption(tokens))
                                case .noBackupPassword:
                                    print("noBackupPassword")
                                    updateView(.noBackupPassword)
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
    
    func saveResult() {
        // last 시간을 디바이스에 저장 - 서버가 최신인 경우
        // service에 있는 토큰 update
    }
    
    func add(token: Token) {
        var token = token
        if tokens.count == 0 {
            token.isMain = true
        }
        tokens.append(token)
        _ = storageManager.storeTokens(tokens)
    }
    
    func update(token: Token) {
        guard let index = tokens.firstIndex(where: { $0.id == token.id }) else { return }
        tokens[index] = token
        _ = storageManager.storeTokens(tokens)
    }
    
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
    
    func excludeMainCell() -> [Token] {
        tokens.filter {
            guard let isMain = $0.isMain else { return true }
            return !isMain
        }
    }
    
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
    
    func removeTokens(_ idList: [String]) {
        idList.forEach { id in
            tokens.removeAll(where: { $0.id == id })
        }
        _ = storageManager.storeTokens(tokens)
        if tokens.count == 0 { return }
        updateMainWithFirstToken()
    }
    
    func removeToken(_ id: String) {
        tokens.removeAll(where: { $0.id == id })
        _ = storageManager.storeTokens(tokens)
    }
    
    func updateTokenPosition(from: Int, target: Int) {
        tokens.move(fromOffsets: IndexSet(integer: from),
                    toOffset: target > from ? target + 1 : target)
        _ = storageManager.storeTokens(tokens)
    }
    
}

extension TokenService {
    
    func updateMainWithFirstToken() {
        if nil !=  mainToken() {
            return
        } else {
            tokens[0].isMain = true
        }
    }
    
   //
    
    // 시간 비교 후, 뭐가 최신인지 아는 게 이 함수의 목적
    func isRecentLocal(time: String) throws -> Bool {
        if let user = DDISUserCache.get() {
            guard let deviceTime = user.device?.lastUpdate?.timeFormatToDate() else {
                throw TimeError.localTime
            }
            guard let serverTime = time.timeFormatToDate() else {
                throw TimeError.serverTime
            }
            
            if deviceTime <= serverTime { // 서버가 최신
                return false
            } else {
                return true
            }
        } else {
            // 불러오기 실패
            return true
        }
    }
    
    func decryptTokenKeys(tokens: [Token], password: String? = nil) -> MainNetworkResult {
        
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
                        // main queue { 만약 복호화 실패시 ->  hasBackupPassword = true }
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
                            // main queue { 만약 복호화 실패시 ->  hasBackupPassword = true }
                        }
                    }
                } else {
                    result = .noBackupPassword
                    return
                }
            }
            decryptedTokens.append(token)
            result = .successLoad(TokenNetworkType(lastUpdate: nil, tokens: decryptedTokens))
        }
        return result
    }
    
    func syncToServer(lastupdateTime: String, _ updateView: @escaping (MainNetworkResult) -> Void) {
        // 암호화
        var encryptedTokens = [Token]()
        tokens.forEach {
            var token = $0
            if let password = BackupPasswordManager().loadPassword() {
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
                updateView(.noBackupPassword)
                // main queue { 만약 복호화 실패시 ->  hasBackupPassword = true }
            }
            encryptedTokens.append(token)
        }
        
        //let device = DDISUserCache.get()
        
        TokenNetworkManager.shared.syncTokens(
            lastUpdate: lastupdateTime, tokens: encryptedTokens) { result in
            switch result {
            case .successLoad:
                print("성공")
            default: break
            }
        }
    }
}

enum TimeError: Error {
    case localTime
    case serverTime
}
