import { Router } from 'express';

import { upsertProfile } from '../controllers/authController.js';
import { asyncHandler } from '../utils/asyncHandler.js';

const router = Router();
router.post('/profile', asyncHandler(upsertProfile));

export default router;
