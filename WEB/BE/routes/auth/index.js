const express = require('express');

const router = express.Router();
const authController = require('@controllers/auth');
const { validator, reCAPTCHA, verifyJWT, sessionAuthentication } = require('@middlewares');
const { catchErrors } = require('@utils/util');

/**
 * @swagger
 * /auth/dup-id:
 *  post:
 *    tags:
 *    - auth
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
 *    tags:
 *    - auth
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
 *    tags:
 *    - auth
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

router
  .route('/password/email')
  .post(reCAPTCHA.verify, validator(['id', 'name', 'birth']), catchErrors(authController.sendPasswordToken))
  .put(reCAPTCHA.verify, verifyJWT.verifyTOTP, catchErrors(authController.sendPasswordEmail))
  .patch(validator(['password']), catchErrors(authController.changePassword));

router.put('/secret-key/email', reCAPTCHA.verify, authController.sendSecretKeyEmail);

router.use(sessionAuthentication.sessionCheck);

module.exports = router;
