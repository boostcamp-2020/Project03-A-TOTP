# iOS TOTP 앱 서비스

## 소개

- 앱 소개

- 구성원
    - [S030 양어진](https://github.com/eojine)
    - [S050 정재명](https://github.com/jjm159)

## 이 문서는 무엇? 

이 문서는 일종의 일기장입니다. 우리의 개발 진행 과정, 겪었던 문제들, 해결과정, 소감등을 매일 매순간 기록할 것입니다. 


## 개발 일지

저희는 개발 과정을 매일 적기로 했습니다. 개발일지에는 개인 회고도 포함되어 있습니다.

||월|화|수|목|
|---|---|---|---|---|
|Week1|[Day 01](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-01-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80---iOS)|[Day 02](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-02-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-iOS)|[Day 03](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-03-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-iOS)|[Day 04](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-04-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-iOS)|
|Week2|[Day 08](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-08-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-iOS)|[Day 09](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-09-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-iOS)|[Day 10](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-10-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-iOS)|[Day 11](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-11-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-iOS)|
|Week3|||||
|Week4|||||
|Week5|||||



## 요구 사항

- swift UI사용 IOS 14이상 프로젝트 세팅
- 앱 기동시 face id, touch id등 바이오 인증 없을 경우 pincode입력
- app인증은 http basic
[RFC 7617 - The 'Basic' HTTP Authentication Scheme](https://tools.ietf.org/html/rfc7617)
- AVFoundation -> qr code read
- totp 정보의 서버 백업 가능하도록 필요 api 설계
- totp 정보는 서버 또는 기타 어떠한 상황에서도 풀리지 않게 설계되어야 함
- 앱의 상태 보존 및 처리는 아래 내용에 기반하여 작성
[Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/state-and-data-flow)

## 목표
지난 프로젝트에서 아쉬웠던 점을 공유하고 이번 프로젝트에서 도전해 볼 사항들에 대해 이야기해 보았습니다. 이를 바탕으로 이번 프로젝트에서 도전사항도 생각해보았습니다.

### 지난 프로젝트에서 아쉬웠던 점
- 백엔드와의 협업 아쉬웠다.
- 리팩토링할 시간 부족했다.
- 테스트 코드를 거의 작성하지 못했다.

### 이번 프로젝트에서 도전!
- Alamofire 없이 URLSession으로 네트워크 계층 설계(선택)
- 유스 케이스를 바탕으로 테스트 케이스를 꼼꼼하게 작성하여 TDD 적용
- Web 팀원들과 함께 작성하여 협력 관계 향상 도모
- CI 적용 - 자동 빌드
- 꼼꼼한 문서화

