const express = require('express');

const router = express.Router();
const userController = require('@/controllers/web/user');
const { validator, reCAPTCHA, sessionAuthentication } = require('@middlewares');
const { catchErrors } = require('@utils/util');

router.post(
  '/',
  reCAPTCHA.verify,
  validator(['id', 'password', 'email', 'name', 'phone', 'birth']),
  catchErrors(userController.signUp)
);
router.post('/dup-email', catchErrors(userController.dupEmail));
router.get('/confirm-email', catchErrors(userController.confirmEmail));
router.post(
  '/find-id',
  reCAPTCHA.verify,
  validator(['email', 'name', 'birth']),
  catchErrors(userController.findID)
);

router.use(sessionAuthentication.sessionCheck);

/**
 * @swagger
 * /user:
 *  get:
 *    tags:
 *      - user
 *    summary: 내 정보 조회
 *    description: 내 이름, 이메일, 전화번호, 생일을 조회한다
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
 *    tags:
 *      - user
 *    summary: 내 정보 수정
 *    description: 유저의 이름, 이메일, 전화번호, 생년월일을 수정한다
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
