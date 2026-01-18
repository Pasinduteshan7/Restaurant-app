const express = require('express');
const authController = require('../controllers/authController');
const auth = require('../middleware/auth');

const router = express.Router();

router.post('/register', authController.register);
router.post('/login', authController.login);

router.get('/profile', auth, authController.getProfile);
router.post('/address', auth, authController.addAddress);

module.exports = router;
