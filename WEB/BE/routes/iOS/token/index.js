const express = require('express');

const router = express.Router();

const userController = require('@controllers/iOS/user');
const tokenController = require('@controllers/iOS/token');

const { catchErrors } = require('@utils/util');

// router.use(catchErrors(userController.getUserFromJWT));
router.get('/', tokenController.getTokenList);
router.post('/', tokenController.addTokenList);

router.patch('/:id', tokenController.updateToken);
router.delete('/:id', tokenController.delToken);

module.exports = router;
