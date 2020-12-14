const express = require('express');

const router = express.Router();
const authController = require('@/controllers/web/auth');
const { validator, reCAPTCHA, verifyJWT, sessionAuthentication } = require('@middlewares');
const { catchErrors } = require('@utils/util');
/**
 * @swagger
 * tags:
 *  name: WEB auth (/auth)
 *  description: auth 관리
 */

/**
 * @swagger
 * /auth/dup-id:
 *  post:
 *    tags: [WEB auth (/auth)]
 *    summary: 아이디 중복체크
 *    description: 아이디 중복체크를 한 후 결과를 반환한다
 *    consumes:
 *    - "application/json"
 *    produces:
 *    - "application/json"
 *    parameters:
 *    - name: id
 *      in: body
 *      description: 중복체크할 아이디
 *      type: string
 *      required: true
 *    responses:
 *      200:
 *        description: 중복체크 결과
 *        schema:
 *          type: object
 *          properties:
 *            result:
 *              type: boolean
 *      401:
 *        description: csrf에러
 *      500:
 *        description: 기타 에러
 */
router.post('/dup-id', catchErrors(authController.dupId));

/**
 * @swagger
 * /auth:
 *  post:
 *    tags: [WEB auth (/auth)]
 *    summary: 아이디,비밀번호 로그인 인증
 *    description: 아이디,비밀번호를 체크한 후 성공하면 authToken을 반환
 *    consumes:
 *    - "application/json"
 *    produces:
 *    - "application/json"
 *    parameters:
 *    - name: id
 *      in: body
 *      description: 아이디
 *      type: string
 *      required: true
 *    - name: password
 *      in: body
 *      description: 비밀번호
 *      type: string
 *      required: true
 *    responses:
 *      200:
 *        description: 아이디, 비밀번호 확인 성공
 *        schema:
 *          type: object
 *          properties:
 *            id:
 *              type: string
 *            authToken:
 *              type: string
 *      400:
 *        description: 아이디 또는 비밀번호가 틀림
 *      401:
 *        description: csrf 에러
 *      500:
 *        description: 기타 에러
 *  put:
 *    tags: [WEB auth (/auth)]
 *    summary: TOTP 로그인 인증
 *    description: TOTP와 authToken을 받아서 값을 확인한 후 성공하면 세션 쿠키를 전달
 *    consumes:
 *    - "application/json"
 *    produces:
 *    - "application/json"
 *    parameters:
 *    - name: totp
 *      in: body
 *      description: TOTP 값
 *      type: string
 *      required: true
 *    - name: authToken
 *      in: body
 *      description: 아이디,비밀번호를 입력하고 받은 authToken값
 *      type: string
 *      required: true
 *    responses:
 *      200:
 *        description: 아이디, 비밀번호 확인 성공
 *        schema:
 *          type: object
 *          properties:
 *            id:
 *              type: string
 *            authToken:
 *              type: string
 *      400:
 *        description: totp가 틀림
 *      401:
 *        description: 잘못된 authToken 또는 csrf 에러
 *      500:
 *        description: 기타 에러
 */
router
  .route('/')
  .post(reCAPTCHA.verify, validator(['id', 'password']), catchErrors(authController.logIn))
  .put(verifyJWT.verifyTOTP, catchErrors(authController.logInSuccess));

/**
 * @swagger
 * /auth/password/email:
 *  post:
 *    tags: [WEB auth (/auth)]
 *    summary: 아이디, 이름, 생년월일 인증
 *    description: 아이디, 이름, 생년월일을 체크한 후 성공하면 authToken을 반환
 *    consumes:
 *    - "application/json"
 *    produces:
 *    - "application/json"
 *    parameters:
 *    - name: id
 *      in: body
 *      description: 아이디
 *      type: string
 *      required: true
 *    - name: name
 *      in: body
 *      description: 이름
 *      type: string
 *      required: true
 *    - name: birth
 *      in: body
 *      description: 생년월일
 *      type: string
 *      required: true
 *    - name: reCaptchaToken
 *      in: body
 *      description: reCAPTCHA 토큰
 *      type: string
 *      required: true
 *    responses:
 *      200:
 *        description: 아이디, 이름, 생년월일 확인 성공
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *            authToken:
 *              type: string
 *      400:
 *        description: 존재하지않는 아이디
 *      401:
 *        description: 입력한 정보가 일치하지않음
 *      500:
 *        description: 유저정보가 존재하지않음
 *  put:
 *    tags: [WEB auth (/auth)]
 *    summary: 비밀번호 찾기 TOTP 인증
 *    description: TOTP와 authToken을 받아서 값을 확인한 후 성공하면 이메일로 비밀번호변경 URL 발송
 *    consumes:
 *    - "application/json"
 *    produces:
 *    - "application/json"
 *    parameters:
 *    - name: totp
 *      in: body
 *      description: TOTP 값
 *      type: string
 *      required: true
 *    - name: authToken
 *      in: body
 *      description: 아이디, 이름, 생년월일을 입력하고 받은 authToken값
 *      type: string
 *      required: true
 *    - name: reCaptchaToken
 *      in: body
 *      description: reCAPTCHA Token
 *      type: string
 *      required: true
 *    responses:
 *      200:
 *        description: totp 확인 성공, 이메일로 비밀번호 변경 URL 전송
 *        schema:
 *          type: object
 *          properties:
 *            result:
 *              type: string
 *      401:
 *        description: 잘못된 authToken 또는 csrf 에러
 *  patch:
 *    tags: [WEB auth (/auth)]
 *    summary: 비밀번호 변경
 *    description: 변경된 비밀번호를 전달하여 비밀번호 변경
 *    consumes:
 *    - "application/json"
 *    produces:
 *    - "application/json"
 *    parameters:
 *    - name: user
 *      in: body
 *      description: 비밀번호를 변경하는 사용자
 *      type: string
 *      required: true
 *    - name: password
 *      in: body
 *      description: 변경할 비밀번호
 *      type: string
 *      required: true
 *    responses:
 *      200:
 *        description: 비밀번호 변경 성공
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *      400:
 *        description: 요청이 만료되었다.
 */
router
  .route('/password/email')
  .post(reCAPTCHA.verify, validator(['id', 'name', 'birth']), catchErrors(authController.sendPasswordToken))
  .put(reCAPTCHA.verify, verifyJWT.verifyTOTP, catchErrors(authController.sendPasswordEmail))
  .patch(validator(['password']), catchErrors(authController.changePassword));

/**
 * @swagger
 * /auth/secret-key/email:
 *  put:
 *    tags: [WEB auth (/auth)]
 *    summary: QR Code 재발급
 *    description: 아이디를 받아 이메일로 QR Code 재발급 주소 전달
 *    consumes:
 *    - "application/json"
 *    produces:
 *    - "application/json"
 *    parameters:
 *    - name: id
 *      in: body
 *      description: 중복체크할 아이디
 *      type: string
 *      required: true
 *    - name: authToken
 *      in: body
 *      description: 아이디, 비밀번호를 입력하고 받은 authToken값
 *      type: string
 *      required: true
 *    - name: reCaptchaToken
 *      in: body
 *      description: reCAPTCHA Token
 *      type: string
 *      required: true
 *    responses:
 *      200:
 *        description: 이메일로 QR Code 등록 URL 전송
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *      400:
 *        description: reCAPTCHA token is missing
 *      401:
 *        description: csrf에러
 *      500:
 *        description: 기타 에러
 */
router.put('/secret-key/email', reCAPTCHA.verify, authController.sendSecretKeyEmail);

router.use(sessionAuthentication.sessionCheck);

/**
 * @swagger
 * /auth/logout:
 *  get:
 *    tags: [WEB auth (/auth)]
 *    summary: Logout
 *    description: 세션을 삭제하여 Logout
 *    consumes:
 *    - "application/json"
 *    produces:
 *    - "application/json"
 *    responses:
 *      200:
 *        description: 이메일로 QR Code 등록 URL 전송
 *        schema:
 *          type: object
 *          properties:
 *            result:
 *              type: boolean
 *      401:
 *        description: csrf 에러 또는 세션 에러
 *      500:
 *        description: 기타 에러
 */
router.get('/logout', authController.logout);

/**
 * @swagger
 * /auth/check-pw:
 *  post:
 *    tags: [WEB auth (/auth)]
 *    summary: 비밀번호 체크
 *    description: 개인정보 수정을 위한 비밀번호 체크
 *    consumes:
 *    - "application/json"
 *    produces:
 *    - "application/json"
 *    parameters:
 *    - name: password
 *      in: body
 *      description: 변경할 비밀번호
 *      type: string
 *      required: true
 *    responses:
 *      200:
 *        description: 이메일로 QR Code 등록 URL 전송
 *        schema:
 *          type: object
 *          properties:
 *            result:
 *              type: boolean
 *      401:
 *        description: csrf 에러 또는 세션 에러
 *      500:
 *        description: 기타 에러
 */
router.post('/check-pw', authController.checkPassword);

module.exports = router;
