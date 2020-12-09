const express = require('express');

const router = express.Router();
const logController = require('@controllers/log');
const { sessionAuthentication } = require('@middlewares');
const { catchErrors } = require('@utils/util');

router.use(sessionAuthentication.sessionCheck);

router.get('/:num', catchErrors(logController.get));

/**
 * @swagger
 * /log/session:
 *  patch:
 *    tags:
 *      - log
 *    summary: 원격 세션 제거
 *    description: sid 기반 세션을 제거
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
router.patch('/session', catchErrors(logController.delSession));

module.exports = router;
