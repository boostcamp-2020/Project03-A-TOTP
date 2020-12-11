const express = require('express');

const router = express.Router();

const userController = require('@controllers/iOS/user');
const tokenController = require('@controllers/iOS/token');

const { catchErrors } = require('@utils/util');

router.use(catchErrors(userController.getUserFromJWT));

/**
 * @swagger
 * /app/token:
 *  get:
 *    tags:
 *      - app/token
 *    summary: 서버 토큰 가져오기
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
 *                  type: array
 *                  items:
 *                    type: object
 *                    properties:
 *                      idx:
 *                        type: integer
 *                      id:
 *                        type: string
 *                      key:
 *                        type: string
 *                      name:
 *                        type: string
 *                      color:
 *                        type: string
 *                      icon:
 *                        type: string
 *                      is_main:
 *                        type: boolean
 *                      user_idx:
 *                        type: integer
 *      401:
 *        description: csrf 에러 또는 세션 에러
 *      500:
 *        description: 기타 에러
 *
 */

router.get('/', catchErrors(tokenController.getTokenList));
router.post('/', catchErrors(tokenController.addTokenList));
router.put('/', catchErrors(tokenController.replaceToken));
router.patch('/:id', catchErrors(tokenController.updateToken));
router.delete('/:id', catchErrors(tokenController.delToken));

module.exports = router;
