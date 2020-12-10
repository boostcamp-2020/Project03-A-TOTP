const express = require('express');

const router = express.Router();
const userController = require('@controllers/iOS/user');
const deviceController = require('@controllers/iOS/device');
const { catchErrors } = require('@utils/util');

router.post('/email', catchErrors(userController.sendEmail));
router.post('/confirm-email', catchErrors(userController.verifyEmailCode));

router.use(catchErrors(userController.getUserFromJWT));

router.patch('/email', catchErrors(userController.updateEmail));
router.patch('/multi', catchErrors(userController.updateMulti));

router.param('udid', deviceController.getDevice);

router.patch('/backup/:udid', catchErrors(deviceController.updateBackup));
router.patch('/device/:udid', catchErrors(deviceController.updateName));
router.delete('/device/:udid', catchErrors(deviceController.deleteDevice));

module.exports = router;
