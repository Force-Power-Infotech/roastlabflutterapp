import { Router } from 'express';

import { createScan, listScans } from '../controllers/scanController.js';
import { asyncHandler } from '../utils/asyncHandler.js';

const router = Router();
router.get('/', asyncHandler(listScans));
router.post('/', asyncHandler(createScan));

export default router;
