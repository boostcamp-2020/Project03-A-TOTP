# WEB TOTP 서비스

## 소개

- 웹 소개

- 구성원
    - [J008 강진구](https://github.com/xortm854)
    - [J068 문석암](https://github.com/mon823)
    - [J135 이도경](https://github.com/dogyeong)

## 이 문서는 무엇? 

이 문서는 일종의 일기장입니다. 우리의 개발 진행 과정, 겪었던 문제들, 해결과정, 소감등을 매일 매순간 기록할 것입니다. 


## 개발 일지

저희는 개발 과정을 매일 적기로 했습니다. 개발일지에는 개인 회고도 포함되어 있습니다.


| 월 | 화 | 수 | 목 | 금 | 토 | 일 | 주차 |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| [1](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-01-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | [2](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-02-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web)  | [3](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-03-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web)  | [4](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-04-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web)  | [5](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-05-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web)  | 6  | 7  | `1주차` |
| 8  | 9  | 10 | 11 | 12 | 13 | 14 | `2주차` |
| 15 | 16 | 17 | 18 | 19 | 20 | 21 | `3주차` |
| 22 | 23 | 24 | 25 | 26 | 27 | 28 | `4주차` |
| 29 | 30 | 31 | 32 | 33 | 34 | 35 | `5주차` |

## 요구 사항

### 회원 가입
``` markdown
- step 1
    - id(중복가입 확인)
    - password(8자 이상, 숫자, 특수문자 포함 구현)
    - email(중복가입 확인, 무료 메일 발송 서비스 이용)
        ex : [NCP CloudOutboundMailer](https://www.ncloud.com/product/applicationService/cloudOutboundMailer) 1000건까지 무료
    - 이름, 생년월일, 전화번호, reCAPTCHA v3 적용
- step 2
    - 가입완료 후 totp등록 페이지로 전환 qr code를 이용하여 totp등록
         (개발한 프로젝트 앱, [‎Twilio Authy](https://apps.apple.com/kr/app/twilio-authy/id494168017), [‎Google Authenticator](https://apps.apple.com/us/app/google-authenticator/id388497605) 사용가능해야함)
- step 3
    - email 검증 후 사용자 등록 완료 처리

- bcrypt를 이용 password 처리 및 개인정보(이름, 전화번호, 주소 등) aes-256-cbc 적용하여 db에 입력
```

### 로그인 
``` markdown
- step 1
     -  1차 로그인 완료
- step 2
    - totp 입력 페이지로 전환 유효한 값이 입력되면 내 정보 페이지로 리다이렉트
- 유효한 email과, 이름, 생년월일이 입력될 경우 메일로 id 전송, reCAPTCHA 적용
- 유효한 id, 이름, 생년월일, totp정보가 입력될 경우 메일로 비밀번호 변경 링크 제공, reCAPTCHA 적용
- 메일로 전송된 비밀번호 변경 페이지
    - 새로운 비밀번호(비밀번호 입력폼, 검증폼) 과 유효한 totp정보가 입력될 경우 변경 처리
```
### 내정보
``` markdown
- 내 개인정보 출력
- 내가 접속했던 브라우저/디바이스 이력 표시
- 내가 접속했던 브라우저/디바이스 유효한 로그인 정보 무력화 기능 (질문 사항)
- 내 개인정보 수정 => 비밀번호만 물어보고 유효하면 진입
```

## 목표
지난 프로젝트에서 아쉬웠던 점을 공유하고 이번 프로젝트에서 도전해 볼 사항들에 대해 이야기해 보았다.

### 지난 프로젝트에서 아쉬웠던 점
- 협업의 기회를 많이 살리지 못했다.
- 테스트 코드를 사용하지 못했다.
- 설계면에서 놓치고 가는 부분이 있었다.
- 배포 자동화를 진행하지 않아서 불편했다.
### 이번 프로젝트에서 도전!

## 관련 문서 정리
- ### [백로그](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Backlog)
- ### [DB 명세](https://github.com/boostcamp-2020/Project03-A-TTP/wiki/DB)
- ### [폴더 구조](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/WEB-%ED%8F%B4%EB%8D%94%EA%B5%AC%EC%A1%B0)
- ### [FlowChart](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/FlowChart)
