import { Router } from 'express';

import { addComment, createPost, listPosts, toggleLike } from '../controllers/feedController.js';
import { asyncHandler } from '../utils/asyncHandler.js';

const router = Router();

router.get('/', asyncHandler(listPosts));
router.post('/', asyncHandler(createPost));
router.post('/:postId/comments', asyncHandler(addComment));
router.post('/:postId/likes/toggle', asyncHandler(toggleLike));

export default router;
