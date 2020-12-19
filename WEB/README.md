# 다다익선 웹 서비스

## 📌 소개

TOTP를 이용한 인증 및 세션관리 웹 서비스 '다다익선'입니다.

https://dadaikseon.com/

<br>

## 📌 프로젝트 구성원

| [J008 강진구](https://github.com/xortm854) | [J068 문석암](https://github.com/mon823) | [J135 이도경](https://github.com/dogyeong) |
|-----|----|-----|

<br>

## 📌 서비스 기능 목록

- 인증 기능
  - 회원가입
  - 로그인(TOTP 2차 인증)
  - 로그아웃
- 편의 기능
  - 아이디 찾기
  - 비밀번호 찾기(변경)
  - QR코드 재발급(TOTP 비밀키 재발급)
  - 개인정보 수정
- 접속 기록 관리(세션 관리)
  - 접속 기록 조회
  - 로그인 상태 만료기능(다른 디바이스의 세션 만료)

<br>

## 📌 기술 스택

| FE | BE | Infra & etc |
|:----:|:-----:|:---------------:|
|<img src="https://user-images.githubusercontent.com/40662323/102689054-9fb86700-423e-11eb-95dd-ccae4ca9a4e7.png" width="130" /><img src="https://user-images.githubusercontent.com/40662323/102689035-86171f80-423e-11eb-900f-ba1401d47a02.png" width="250" /><img src="https://user-images.githubusercontent.com/40662323/102689070-bf4f8f80-423e-11eb-831d-e57b0a022867.png" width="300" />|<img src="https://user-images.githubusercontent.com/40662323/102689088-dbebc780-423e-11eb-936f-0cb710b12446.png" width="250" /><img src="https://user-images.githubusercontent.com/40662323/102689138-37b65080-423f-11eb-8c76-c003e07542d7.png" width="250" /><img src="https://user-images.githubusercontent.com/40662323/102689193-88c64480-423f-11eb-9fff-4cc0a6b2f216.png" width="250" /><img src="https://user-images.githubusercontent.com/40662323/102690083-4e13da80-4246-11eb-924f-7353d1eb795c.png" width="250" />|<img src="https://user-images.githubusercontent.com/40662323/102689118-0b9acf80-423f-11eb-86c2-677b3e27fa39.png" width="250" /><img src="https://user-images.githubusercontent.com/40662323/102689231-cb881c80-423f-11eb-907c-01eaacb6afc9.png" width="250"/>|

<br>

## 📌 아키텍쳐

![diagram](https://user-images.githubusercontent.com/40662323/102689973-954d9b80-4245-11eb-8d6d-d881dc4ae677.png)
    
<br>

## 📌 개발 일지

저희는 개발 과정을 매일 적기로 했습니다. 개발일지에는 개인 회고도 포함되어 있습니다.

| 월 | 화 | 수 | 목 | 금 | 토 | 일 | 주차 |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| [1](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-01-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | [2](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-02-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web)  | [3](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-03-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web)  | [4](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-04-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web)  | [5](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-05-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web)  | 6  | 7  | `1주차` |
| [8](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-08-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web)  | [9](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-09-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web)  | [10](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-10-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | [11](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-11-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | [12](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-12-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | 13 | 14 | `2주차` |
| [15](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-15-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | [16](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-16-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | [17](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-17-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | [18](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-18-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | [19](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-19-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | 20 | 21 | `3주차` |
| [22](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-22-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | [23](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-23-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | [24](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-24-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | [25](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-25-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | [26](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-26-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | 27 | 28 | `4주차` |
| [29]() | [30](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-30-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | [31](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-31-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | [32](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-32-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | [33](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Day-33-%EA%B0%9C%EB%B0%9C%EC%9D%BC%EC%A7%80-Web) | 34 | 35 | `5주차` |

<br>

## 📌 더 궁금한게 있다면?

- [Wiki](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki)
- [백로그](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/Backlog)
- [DB 명세](https://github.com/boostcamp-2020/Project03-A-TTP/wiki/DB)
- [폴더 구조](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/WEB-%ED%8F%B4%EB%8D%94%EA%B5%AC%EC%A1%B0)
- [FlowChart](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki/FlowChart)
