//
//  TOTPGenerationTests.swift
//  DaDaIkSeonTests
//
//  Created by 정재명 on 2020/11/28.
//

import XCTest
import SwiftOTP

class TOTPGenerationTests: XCTestCase {
    
    var extractKey: (String) -> String? {
        TOTPGenerator.extractKey(from: )
    }
    
    let github = "otpauth://totp/GitHub:jjm159?secret=WEJ3NLTTYHF4XVXG&issuer=GitHub"
    let google = "otpauth://totp/Google%3Awjdwoaud15%40gmail.com?secret=fn3gdedtxfsluaz4qlcv7ndhowimn4h2&issuer=Google"
    
    func test_qrcode로부터읽어온_url에서_키값추출이_되어야한다() {
        XCTAssertEqual(extractKey(github), "WEJ3NLTTYHF4XVXG")
        XCTAssertEqual(extractKey(google), "fn3gdedtxfsluaz4qlcv7ndhowimn4h2")
    }
    
    func test_잘못된urlstring을주면_nil이_반환되어야한다() {
        let wrongString = "otpauth://totp/GitHub:jjm159?secr=WEJ3NLTTYHF4XVXG&issuer=GitHub"
        XCTAssertNil(extractKey(wrongString))
    }
    
    
}

extension TOTPGenerationTests {
    
}
