import cors from 'cors';
import express from 'express';
import morgan from 'morgan';

import { requireAdmin, requireAuth } from './middleware/auth.js';
import adminRoutes from './routes/adminRoutes.js';
import authRoutes from './routes/authRoutes.js';
import contentRoutes from './routes/contentRoutes.js';
import feedRoutes from './routes/feedRoutes.js';
import recipeRoutes from './routes/recipeRoutes.js';
import scanRoutes from './routes/scanRoutes.js';

export function createApp() {
  const app = express();

  app.use(cors());
  app.use(express.json({ limit: '2mb' }));
  app.use(morgan('dev'));

  app.get('/health', (_req, res) => {
    res.json({ ok: true, service: 'roastlab-backend' });
  });

  app.use('/api/auth', requireAuth, authRoutes);
  app.use('/api/feed', requireAuth, feedRoutes);
  app.use('/api/scans', requireAuth, scanRoutes);
  app.use('/api/recipes', requireAuth, recipeRoutes);
  app.use('/api/content', requireAuth, contentRoutes);
  app.use('/api/admin', requireAuth, requireAdmin, adminRoutes);

  app.use((error, _req, res, _next) => {
    console.error(error);
    res.status(500).json({ message: error.message ?? 'Unexpected server error' });
  });

  return app;
}
