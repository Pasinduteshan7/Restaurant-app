const express = require('express');
const foodController = require('../controllers/foodController');

const router = express.Router();

router.get('/', foodController.getAllFoods);
router.get('/categories', foodController.getCategories);
router.get('/search', foodController.searchFoods);
router.get('/:id', foodController.getFoodById);

module.exports = router;
