import { Router } from 'express';

import { createRecipe, listRecipes } from '../controllers/recipeController.js';
import { asyncHandler } from '../utils/asyncHandler.js';

const router = Router();
router.get('/', asyncHandler(listRecipes));
router.post('/', asyncHandler(createRecipe));

export default router;
