
# TOTP가 뭐 조
### 안녕하세요👨‍👨‍👦 TOTP가 무척 궁금한 'TOTP가 뭐 조' 입니다. 

---

<div align="center">  
  
![](https://img.shields.io/badge/Swift-v5.3-%23e67e22?logo=Swift) ![](https://img.shields.io/badge/XCode-v12.1-%231575F9?logo=XCode)<br>
![](https://img.shields.io/badge/Node.js-v14.15.01-%23339933?logo=node.js) ![](https://img.shields.io/badge/React-Vanila-%2361DAFB?logo=React) ![](https://img.shields.io/badge/JavaScript-ES6-%23F7DF1E?logo=JavaScript) ![](https://img.shields.io/badge/Webpack-Node-%238DD6F9?logo=Webpack) ![](https://img.shields.io/badge/Babel-v7.10.5-%23F9DC3E?logo=Babel) ![](https://img.shields.io/badge/ESLint-v7.10.10-%234B32C3?logo=ESLint) ![](https://img.shields.io/badge/Nodemon-v2.0.4-%2376D04B?logo=Nodemon) ![](https://img.shields.io/badge/Prettier-v2.1.2-%23F7B93E?logo=Prettier) ![](https://img.shields.io/badge/Mysql-Database-%234479A1?logo=mysql)

</div>
  
---

## 바로가기
저희 팀에 대해 알고싶으시다면 👉  [[ Home ]](https://github.com/boostcamp-2020/Project03-A-TOTP/wiki)<br>
저희 개발 과정이 궁금하시다면 👉  [[ Web 저장소 ]](https://github.com/boostcamp-2020/Project03-A-TOTP/tree/master/WEB), [[ iOS 저장소 ]](https://github.com/boostcamp-2020/Project03-A-TOTP/tree/master/iOS)

<br>

## 프로젝트 소개

저희 조 이름에서 알 수 있듯 저희 조원 중 TOTP에 대해 정확히 이해하고 있는 분이 아무도 없었습니다. 아마 TOTP에 대해 정확히 알고 계신 분이 많지는 않을 것입니다. 그래서 먼저 TOTP에 대해 간단히 설명해 드리고자 합니다.

<br>

### Two Factor Authentication(2FA)

TOTP를 이해하기에 앞서 먼저 2FA에 대해 이해할 필요가 있습니다. Two-Factor 인증 또는 Multi-Factor 인증이라고도 하는 2FA는 말 그대로 2번 이상 인증을 받는 것입니다. 쉽게 말해 TOTP는 두 번째 인증을 위한 두 번째 비밀번호라고 할 수 있습니다. 

<br>

### 2FA를 해야하는 이유

인증 수단(Factor)에는 **세 가지 요소**가 있습니다. 

1. 정보 - 비밀 번호, 핀 번호
2. 소유물 - 인증 카드, 스마트폰
3. 생체 - 지문, 얼굴

대부분의 사람들은 1번 수단인 **비밀번호**로 한 번만 인증하고 로그인을 하게 됩니다. 물론 네이버 카카오 처럼 훌륭한 보안 직원들이 보호해주는 사이트에서는 비밀번호가 유출될 일이 없을 것입니다. 하지만 혹시 네이버 카카오에서 사용하는 아이디 비밀번호를 다른 사이트에서도 똑같이 사용하고 계시진 않으신가요? 

약 [39%](https://assets.pewresearch.org/wp-content/uploads/sites/14/2017/01/26102016/Americans-and-Cyber-Security-final.pdf)의 사람들은 다른 온라인 계정에도 같은 비밀번호를 사용한다고 합니다. 가입 되어 있는 온라인 계정들 중 어딘가는 안전하지 않은 사이트가 있을 수 있습니다. 네이버 카카오에서 아무리 보안을 두텁게 하고 있다고 한들 올바른 아이디 비밀번호를 입력한 해커를 막을 수는 없을 것입니다.

그래서 2FA는 필요합니다. 만약 비밀번호가 유출된다고 하더라도 내가 가지고 있는 **디바이스**가 없다면, 또는 나의 **지문과 얼굴**이 없다면 로그인할 수 없도록 막는 것입니다.


<br>

### TOTP (Time-based One-Time Password)

TOTP는 현재 시간과 Secret Key 값을 사용하여 생성한 임시 비밀번호를 의미합니다. 사용자와 웹사이트는 똑같은 Secret Key 값을 가지고 있고, 사용자와 웹사이트는 일정 시간마다 현재 시간을 사용하여 새로운 임시 비밀번호를 생성합니다. 사용자는 이 비밀번호를 입력했을 때 인증에 성공하게 됩니다. 

이 때 사용자는 Secret Key 값을 저장해 놓을 수단이 필요합니다. 과거에는 OTP용 기기를 사용했지만 요즘 같은 시대에는 그럴 필요가 없습니다. 스마트폰이 있기 때문입니다. TOTP 앱에서는 Secret Key 값을 보관해주고 일정 시간마다 이 값과 현재 시간으로 비밀번호를 생성해줍니다.

TOTP를 사용한다면 1차 비밀번호가 유출되더라도 Secret Key 값을 저장한 스마트 폰을 가지고 있지 않다면 로그인할 수 없습니다. 또한 2차 비밀번호가 유출되더라도 일정 시간이 지나면 해당 비밀번호는 효력을 상실하기 때문에 유출된 2차 비밀번호로는 로그인할 수 없습니다. 바로 이것이 TOTP를 사용하는 이유입니다.



<br>

### 우리가 만들 것 

최종적으로 우리 프로젝트에서는 **TOTP 인증 앱**, 그리고 **TOTP 로그인 기능을 제공해 주는 웹 사이트** 이렇게 두 가지를 만들게 됩니다.


<br>

## 우린 TOTP에 진심이다

우리 팀의 최종 목표는 보안, 편의성, 아름다움까지 기존에 존재하는 앱([Google Authenticator](https://apps.apple.com/us/app/google-authenticator/id388497605), [Twilio Authy](https://apps.apple.com/us/app/twilio-authy/id494168017))들 못지 않는 완성도 높은 TOTP 앱 서비스를 만들어 내는 것입니다. 

### 보안
- 기존 앱 못지 않는 보안을 제공하기 위해 최선을 다할 것입니다.
- 기존 앱들이 제공해 주지 않는 추가 적인 보안 옵션도 추가해 보려고 합니다.

### 편의성
- 기존 앱이 주지 못했던 우리만의 편리한 사용자 경험을 제공할 것입니다. 

### 디자인
- 기존에 있던 앱들이 생각나지 않는 우리만의 개성이 묻어나는 새로운 UI를 구성해보려고 합니다.

![스크린샷 2020-11-20 오전 1 46 29](https://user-images.githubusercontent.com/44443949/99696607-370c8c00-2ad2-11eb-8893-be2f214e7709.png)


### 학습

이런 목표를 달성하기 위해 많은 지식이 필요할 것입니다. 따라서 저희는 구현에만 집중하지 않고 함께 학습하고 이야기를 나누고 문서화하는 시간들을 많이 가지려고 합니다. 


