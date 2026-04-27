import { Router } from 'express';

import { listNotifications, listVideos, upsertSubscription } from '../controllers/contentController.js';
import { asyncHandler } from '../utils/asyncHandler.js';

const router = Router();
router.get('/videos', asyncHandler(listVideos));
router.get('/notifications', asyncHandler(listNotifications));
router.post('/subscriptions', asyncHandler(upsertSubscription));

export default router;
