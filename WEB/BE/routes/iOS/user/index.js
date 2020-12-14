const express = require('express');

const router = express.Router();
const userController = require('@controllers/iOS/user');
const deviceController = require('@controllers/iOS/device');
const { catchErrors } = require('@utils/util');

/**
 * @swagger
 * /app/user/email:
 *  post:
 *    tags:
 *    - app/user
 *    summary: 이메일 인증 코드 발송
 *    description: 입력받은 이메일로 인증 코드를 발송한다
 *    parameters:
 *      - name: email
 *        in: body
 *        required: true
 *        type: string
 *    responses:
 *      200:
 *        description: 성공
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *      400:
 *        description: 멀티 디바이스 off
 *      500:
 *        description: 기타 에러
 */
router.post('/email', catchErrors(userController.sendEmail));

/**
 * @swagger
 * /app/user/confirm-email:
 *  post:
 *    tags:
 *    - app/user
 *    summary: 이메일 인증 코드 확인
 *    description: 입력받은 이메일로 인증 코드를 확인하하고 유저 정보를 저장한다
 *    parameters:
 *    - name: email
 *      in: body
 *      required: true
 *      type: string
 *    - name: code
 *      in: body
 *      required: true
 *      type: string
 *    - name: device
 *      in: body
 *      required: true
 *      tyle: object
 *      properties:
 *        name:
 *          type: string
 *        udid:
 *          type: string
 *        modelName:
 *          type: string
 *        backup:
 *          type: boolean
 *    responses:
 *      200:
 *        description: 성공
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *            data:
 *              type: object
 *              properties:
 *                jwt:
 *                  type: string
 *      400:
 *        description: 잘못된 이메일이거나 잘못된 인증코드를 전달한 경우
 *      500:
 *        description: 기타 에러
 */
router.post('/confirm-email', catchErrors(userController.verifyEmailCode));

router.use(catchErrors(userController.getUserFromJWT));

/**
 * @swagger
 * /app/user/email:
 *  patch:
 *    tags: [app/user]
 *    summary: 이메일 수정
 *    description: 입력받은 이메일 유저의 이메일 정보를 수정한다
 *    parameters:
 *    - name: email
 *      in: body
 *      required: true
 *      type: string
 *    responses:
 *      200:
 *        description: 이메일 수정 성공
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *      500:
 *        description: 기타 에러
 */
router.patch('/email', catchErrors(userController.updateEmail));

/**
 * @swagger
 * /app/user/multi:
 *  patch:
 *    tags: [app/user]
 *    summary: 멀티디바이스 수정
 *    description: 유저의 멀티디바이스 정보를 수정한다
 *    parameters:
 *    - name: multiDevice
 *      in: body
 *      required: true
 *      type: boolean
 *    responses:
 *      200:
 *        description: 멀티디바이스 수정 성공
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *      500:
 *        description: 기타 에러
 */
router.patch('/multi', catchErrors(userController.updateMulti));

router.param('udid', deviceController.getDevice);

/**
 * @swagger
 * /app/user/backup/{udid}:
 *  patch:
 *    tags: [app/user]
 *    summary: 백업 수정
 *    description: 디바이스의 백업 정보를 수정한다
 *    parameters:
 *    - name: backup
 *      in: body
 *      required: true
 *      type: boolean
 *    responses:
 *      200:
 *        description: 백업 수정 성공
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *      500:
 *        description: 기타 에러
 */
router.patch('/backup/:udid', catchErrors(deviceController.updateBackup));

/**
 * @swagger
 * /app/user/device/{udid}:
 *  patch:
 *    tags: [app/user]
 *    summary: 디바이스 이름 수정
 *    parameters:
 *    - name: name
 *      in: body
 *      required: true
 *      type: string
 *    responses:
 *      200:
 *        description: 디바이스 이름 수정 성공
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *      500:
 *        description: 기타 에러
 */
router.patch('/device/:udid', catchErrors(deviceController.updateName));

/**
 * @swagger
 * /app/user/device/{udid}:
 *  delete:
 *    tags: [app/user]
 *    summary: 디바이스 삭제
 *    description: 유저의 디바이스를 목록에서 삭제한다
 *    responses:
 *      200:
 *        description: 디바이스 삭제 성공
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *      500:
 *        description: 기타 에러
 */
router.delete('/device/:udid', catchErrors(deviceController.deleteDevice));

module.exports = router;
