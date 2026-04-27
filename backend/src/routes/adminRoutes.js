import { Router } from 'express';

import { createVideo, getAnalytics, listUsers, listVideosAdmin } from '../controllers/adminController.js';
import { asyncHandler } from '../utils/asyncHandler.js';

const router = Router();

router.get('/analytics', asyncHandler(getAnalytics));
router.get('/users', asyncHandler(listUsers));
router.get('/videos', asyncHandler(listVideosAdmin));
router.post('/videos', asyncHandler(createVideo));

export default router;
