const express = require('express');

const router = express.Router();
const logController = require('@/controllers/web/log');
const { sessionAuthentication } = require('@middlewares');
const { catchErrors } = require('@utils/util');
const authController = require('@/controllers/web/auth');

router.use(sessionAuthentication.sessionCheck);
/**
 * @swagger
 * tags:
 *  name: WEB Log (/log)
 *  description: 접속 로그 관리
 */

/**
 * @swagger
 * /log/:num:
 *  put:
 *    tags: [WEB Log (/log)]
 *    summary: 선택페이지 로그가져오기
 *    description: 페이지네이션을 적용한 개수만큼 로그가져오기
 *    security:
 *      - session: []
 *      - CSRF: []
 *    produces:
 *    - "application/json"
 *    parameters:
 *    - name: num
 *      in: params
 *      description: 로그페이지 숫자
 *      type: string
 *      required: true
 *    responses:
 *      200:
 *        description: 로그 가져오기 성공
 *        schema:
 *          type: object
 *          properties:
 *            result:
 *              type: Object Array
 *      401:
 *        description: csrf 에러 또는 세션 에러
 *      500:
 *        description: 기타 에러
 */
router.get('/:num', catchErrors(logController.get));

/**
 * @swagger
 * /log/session:
 *  patch:
 *    tags: [WEB Log (/log)]
 *    summary: 원격 세션 제거
 *    description: sid 기반 세션을 제거
 *    security:
 *      - session: []
 *      - CSRF: []
 *    produces:
 *    - "application/json"
 *    parameters:
 *    - name: sid
 *      in: body
 *      description: Session Id
 *      type: string
 *      required: true
 *    responses:
 *      200:
 *        description: 세션 제거 성공
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
router.patch('/session', catchErrors(logController.delSession), catchErrors(authController.logout));

module.exports = router;
