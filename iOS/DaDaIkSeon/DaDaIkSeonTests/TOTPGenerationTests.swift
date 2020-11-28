//
//  TOTPGenerationTests.swift
//  DaDaIkSeonTests
//
//  Created by 정재명 on 2020/11/28.
//

import XCTest
import SwiftOTP

class TOTPGenerationTests: XCTestCase {
    
    // MARK: function
    var extractKey: (String) -> String? {
        TOTPGenerator.extractKey(from:)
    }
    
    var generateTOTP: (String) -> String? {
        TOTPGenerator.generate(from:)
    }
    
    // MARK: URL
    let github = "otpauth://totp/GitHub:jjm159?secret=WEJ3NLTTYHF4XVXG&issuer=GitHub"
    let google = "otpauth://totp/Google%3Awjdwoaud15%40gmail.com?secret=fn3gdedtxfsluaz4qlcv7ndhowimn4h2&issuer=Google"
    
    // MARK: Test Code
    func test_qrcode로부터읽어온_url에서_키값추출이_되어야한다() {
        XCTAssertEqual(extractKey(github), "WEJ3NLTTYHF4XVXG")
        XCTAssertEqual(extractKey(google), "fn3gdedtxfsluaz4qlcv7ndhowimn4h2")
    }
    
    func test_잘못된urlstring을주면_nil이_반환되어야한다() {
        let wrongString = "otpauth://totp/GitHub:jjm159?secr=WEJ3NLTTYHF4XVXG&issuer=GitHub"
        XCTAssertNil(extractKey(wrongString))
    }
    
    func test_추출한_키값으로부터_base32기반_디코딩이_되어야한다() {
        guard let keyString = extractKey(github) else {
            XCTFail("키 값 생성 실패")
            return
        }
        XCTAssertNotNil(base32DecodeToData(keyString))
    }
    
    func test_추출한_키값이_base32기반으로_인코딩된데이터가_아닌경우_nil을반환해야한다() {
        // TODO: 추출한 키값이 base32기반 인코딩된 데이터가 아닌 경우 test해야 한다.
    }
    
    func test_키값으로부터_TOTP객체가_생성되어야한다() {
        guard let keyData = keyData(from: github) else {
            XCTFail("키 데이터 생성 실패")
            return
        }
        XCTAssertNotNil(
            TOTP(secret: keyData,
                 digits: 6,
                 timeInterval: 30,
                 algorithm: .sha1)
        )
        
    }
    
}

extension TOTPGenerationTests {
    func keyData(from urlOfQrcode: String) -> Data? {
        guard let keyString = extractKey(urlOfQrcode) else {
            return nil
        }
        if let keyData = base32DecodeToData(keyString) {
            return keyData
        }
        return nil
    }
}
