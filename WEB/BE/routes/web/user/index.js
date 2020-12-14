const express = require('express');

const router = express.Router();
const userController = require('@/controllers/web/user');
const { validator, reCAPTCHA, sessionAuthentication } = require('@middlewares');
const { catchErrors } = require('@utils/util');

/**
 * @swagger
 * tags:
 *  name: WEB User (/user)
 *  description: 유저 관리
 */

/**
 * @swagger
 * /user:
 *  post:
 *    tags: [WEB User (/user)]
 *    summary: 회원가입
 *    description: 회원가입
 *    produces:
 *    - "application/json"
 *    parameters:
 *    - name: email
 *      in: body
 *      description: 이메일
 *      type: string
 *      required: true
 *    - name: name
 *      in: body
 *      description: 이름
 *      type: string
 *      required: true
 *    - name: birth
 *      in: body
 *      description: 생일
 *      type: string
 *      required: true
 *    - name: phone
 *      in: body
 *      description: 핸드폰번호
 *      type: string
 *      required: true
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
 *        description: 인증 이메일 전송 성공, QR Code URL
 *        schema:
 *          type: object
 *          properties:
 *            result:
 *              type: Object
 *            url:
 *              type: string
 *      400:
 *        description: Validation 에러
 *      401:
 *        description: csrf 에러
 *      500:
 *        description: 기타 에러
 */
router.post(
  '/',
  reCAPTCHA.verify,
  validator(['id', 'password', 'email', 'name', 'phone', 'birth']),
  catchErrors(userController.signUp)
);

/**
 * @swagger
 * /user/dup-email:
 *  post:
 *    tags: [WEB User (/user)]
 *    summary: 이메일 중복 체크
 *    description: 이메일 중복 체크
 *    produces:
 *    - "application/json"
 *    parameters:
 *    - name: email
 *      in: body
 *      description: 이메일
 *      type: string
 *      required: true
 *    responses:
 *      200:
 *        description: 이메일 중복 체크 성공(유무 전달)
 *        schema:
 *          type: object
 *          properties:
 *            result:
 *              type: boolean
 *      401:
 *        description: csrf 에러
 *      500:
 *        description: 기타 에러
 */
router.post('/dup-email', catchErrors(userController.dupEmail));

/**
 * @swagger
 * /user/confirm-email:
 *  post:
 *    tags: [WEB User (/user)]
 *    summary: 이메일 인증
 *    description: 회원가입 이메일 인증
 *    produces:
 *    - "application/json"
 *    parameters:
 *    - name: user
 *      in: query
 *      description: 암호화된 유저정보
 *      type: string
 *      required: true
 *    responses:
 *      200:
 *        description: 이메일 인증 성공
 *        schema:
 *          type: object
 *          properties:
 *            result:
 *              type: boolean
 *      400:
 *        description: 이메일 인증 URL Timeout
 *      401:
 *        description: csrf 에러
 *      500:
 *        description: 기타 에러
 */
router.get('/confirm-email', catchErrors(userController.confirmEmail));

/**
 * @swagger
 * /user/find-id:
 *  post:
 *    tags: [WEB User (/user)]
 *    summary: 회원가입 ( 이거 이상합니다 수정 필요)
 *    description: 회원가입
 *    produces:
 *    - "application/json"
 *    parameters:
 *    - name: email
 *      in: body
 *      description: 이메일
 *      type: string
 *      required: true
 *    - name: name
 *      in: body
 *      description: 이름
 *      type: string
 *      required: true
 *    - name: birth
 *      in: body
 *      description: 생일
 *      type: string
 *      required: true
 *    - name: phone
 *      in: body
 *    - name: reCaptchaToken
 *      in: body
 *      description: reCAPTCHA Token
 *      type: string
 *      required: true
 *    responses:
 *      200:
 *        description: 아이디찾기 이메일 전송 성공
 *        schema:
 *          type: object
 *          properties:
 *            true:
 *              type: boolean
 *      400:
 *        description: Validation 에러 또는 없는 사용자
 *      401:
 *        description: csrf 에러
 *      500:
 *        description: 기타 에러
 */
router.post(
  '/find-id',
  reCAPTCHA.verify,
  validator(['email', 'name', 'birth']),
  catchErrors(userController.findID)
);

router.post('/reSend', catchErrors(userController.reSendEmail));

router.use(sessionAuthentication.sessionCheck);

/**
 * @swagger
 * /user:
 *  get:
 *    tags: [WEB User (/user)]
 *    summary: 내 정보 조회
 *    description: 내 이름, 이메일, 전화번호, 생일을 조회한다
 *    security:
 *      - session: []
 *      - CSRF: []
 *    produces:
 *    - "application/json"
 *    responses:
 *      200:
 *        description: 유저 조회 성공
 *        schema:
 *          type: object
 *          properties:
 *            user:
 *              type: object
 *              properties:
 *                name:
 *                  type: string
 *                email:
 *                  type: string
 *                phone:
 *                  type: string
 *                birth:
 *                  type: string
 *                  format: date
 *      401:
 *        description: csrf 에러 또는 세션 에러
 *      500:
 *        description: 기타 에러
 *  patch:
 *    tags: [WEB User (/user)]
 *    summary: 내 정보 수정
 *    description: 유저의 이름, 이메일, 전화번호, 생년월일을 수정한다
 *    security:
 *      - session: []
 *      - CSRF: []
 *    produces:
 *    - "application/json"
 *    parameters:
 *      - name: name
 *        in: body
 *        type: string
 *      - name: email
 *        in: body
 *        type: string
 *      - name: phone
 *        in: body
 *        type: string
 *      - name: birth
 *        in: body
 *        type: string
 *    responses:
 *      200:
 *        description: 수정 성공
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *      401:
 *        description: csrf 에러 또는 세션 에러
 *      500:
 *        description: 기타 에러
 */
router.get('/', catchErrors(userController.getUser));
router.patch('/', catchErrors(userController.updateUser));
module.exports = router;
