const express = require('express');

const router = express.Router();

const userController = require('@controllers/iOS/user');
const tokenController = require('@controllers/iOS/token');

const { catchErrors } = require('@utils/util');

router.use(catchErrors(userController.getUserFromJWT));

router.get('/', catchErrors(tokenController.getTokenList));
router.post('/', catchErrors(tokenController.addTokenList));
router.put('/', catchErrors(tokenController.replaceToken));
router.patch('/:id', catchErrors(tokenController.updateToken));
router.delete('/:id', catchErrors(tokenController.delToken));

module.exports = router;

/**
 * @swagger
 * tags:
 *   name: iOS Token (/app/token)
 *   description: 토큰 관리
 * definitions:
 *   tokens:
 *     type: array
 *     items:
 *       $ref: '#/definitions/token'

 *   token:
 *    type: object
 *    properties:
 *      id:
 *        type: string
 *        example: 1111-2222-3333-eeef
 *      key:
 *        type: string
 *        example: ASD2AS4DA3S2DSA
 *      name:
 *        type: string
 *        example: 네이버
 *      color:
 *        type: string
 *        example: navy
 *      icon:
 *        type: string
 *        example: mail
 *      is_main:
 *        type: boolean
 *        example: true
 */

/**
 * @swagger
 * /app/token:
 *  get:
 *    tags: [iOS Token (/app/token)]
 *    summary: 백업 서버 Key토큰 가져오기(JWT 필요)
 *    description: 백업 되어 있던 토큰을 전부 가져옴
 *    security:
 *      - jwt: []
 *    produces:
 *    - "application/json"
 *    responses:
 *      200:
 *        description: 전송 성공
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *              example: ok
 *            data:
 *              type: object
 *              properties:
 *                lastUpdate:
 *                  type: string
 *                  example: 2020-12-10T13:24:44.000Z
 *                tokens:
 *                  $ref: '#/definitions/tokens'
 *      401:
 *        description: csrf 에러 또는 세션 에러
 *      500:
 *        description: 기타 에러
 *
 */

/**
 * @swagger
 * /app/token:
 *  post:
 *    tags: [iOS Token (/app/token)]
 *    summary: Key 토큰 추가(JWT 필요)
 *    description: 백업 토큰을 추가함 요청을 보낸 서버 시간 기준으로 업데이트 시간도 업데이트 됨
 *    security:
 *      - jwt: []
 *    produces:
 *    - "application/json"
 *    parameters:
 *    - name: tokens
 *      in: body
 *      description: Key 토큰
 *      type: object
 *      properties:
 *        tokens:
 *          $ref: '#/definitions/tokens'
 *      required: true
 *    responses:
 *      200:
 *        description: 전송 성공
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *              example: ok
 *      401:
 *        description: csrf 에러 또는 세션 에러
 *      500:
 *        description: 기타 에러
 *
 */

/**
 * @swagger
 * /app/token:
 *  put:
 *    tags: [iOS Token (/app/token)]
 *    summary: Key 토큰 전부 바꾸기(JWT 필요)
 *    description: Key 토큰을 전부 새로운걸로 교환함
 *    security:
 *      - jwt: []
 *    produces:
 *    - "application/json"
 *    parameters:
 *    - name: tokens
 *      in: body
 *      description: Key 토큰
 *      type: object
 *      properties:
 *        data:
 *          type: object
 *          properties:
 *            lastUpdate:
 *              type: string
 *              example: 2020-12-10T13:24:44.000Z
 *            tokens:
 *              $ref: '#/definitions/tokens'
 *      required: true
 *    responses:
 *      200:
 *        description: 전송 성공
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *              example: ok
 *      401:
 *        description: csrf 에러 또는 세션 에러
 *      500:
 *        description: 기타 에러
 *
 */

/**
 * @swagger
 * /app/token/:id:
 *  patch:
 *    tags: [iOS Token (/app/token)]
 *    summary: Key 토큰 업데이트(JWT 필요)
 *    description: 넘어온 id 기준으로 기존 Key token 데이터를 업데이트함
 *    security:
 *      - jwt: []
 *    produces:
 *    - "application/json"
 *    parameters:
 *    - name: tokens
 *      in: body
 *      description: Key 토큰
 *      type: object
 *      properties:
 *        tokens:
 *          $ref: '#/definitions/token'
 *      required: true
 *    responses:
 *      200:
 *        description: 업데이트 성공
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *              example: ok
 *      400:
 *        description: 업데이트 실패( 토큰 없음 )
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *              example: There is no token
 *      401:
 *        description: csrf 에러 또는 세션 에러
 *      500:
 *        description: 기타 에러
 *
 */

/**
 * @swagger
 * /app/token/:id:
 *  delete:
 *    tags: [iOS Token (/app/token)]
 *    summary: Key 토큰 삭제(JWT 필요)
 *    description: 넘어온 id 값을 삭제함
 *    security:
 *      - jwt: []
 *    produces:
 *    - "application/json"
 *    responses:
 *      200:
 *        description: 삭제 성공
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *              example: ok
 *      400:
 *        description: 삭제 실패( 토큰 없음 )
 *        schema:
 *          type: object
 *          properties:
 *            message:
 *              type: string
 *              example: There is no token
 *      401:
 *        description: csrf 에러 또는 세션 에러
 *      500:
 *        description: 기타 에러
 *
 */
