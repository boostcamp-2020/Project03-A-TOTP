const express = require('express');

const router = express.Router();

const userController = require('@controllers/iOS/user');
const tokenController = require('@controllers/iOS/token');

const { catchErrors } = require('@utils/util');

// router.use(catchErrors(userController.getUserFromJWT));
router.get('/', catchErrors(tokenController.getTokenList));
router.post('/', catchErrors(tokenController.addTokenList));

router.patch('/:id', catchErrors(tokenController.updateToken));
router.delete('/:id', catchErrors(tokenController.delToken));

module.exports = router;
