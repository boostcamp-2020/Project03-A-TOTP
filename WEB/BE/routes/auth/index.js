const express = require('express');

const router = express.Router();
const authController = require('@controllers/auth');
const { validator } = require('@middlewares/validator');
const reCAPTCHA = require('@middlewares/reCAPTCHA');
const { verifyJWT } = require('@middlewares/verifyJWT');

/**
 * @swagger
 * /auth/dup-id:
 *  post:
 *    tags:
 *    - auth
 *    description: 아이디 중복 체크를 한 후 결과를 반환한다
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
 *        description: 기타 오류
 */
router.post('/dup-id', authController.dupId);

router
  .route('/')
  .post(reCAPTCHA.verify, validator(['id', 'password']), authController.logIn)
  .put(verifyJWT.verifyTOTP, authController.logInSuccess);

router
  .route('/password/email')
  .post(reCAPTCHA.verify, validator(['id', 'name', 'birth']), authController.sendPasswordToken)
  .put(reCAPTCHA.verify, verifyJWT.verifyTOTP, authController.sendPasswordEmail)
  .patch(validator(['password']), authController.changePassword);

module.exports = router;
