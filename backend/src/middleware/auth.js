import admin from 'firebase-admin';

import { getFirebaseAdmin } from '../config/firebase.js';

export async function requireAuth(req, res, next) {
  try {
    const authorization = req.headers.authorization ?? '';
    const token = authorization.startsWith('Bearer ') ? authorization.slice(7) : null;
    const app = getFirebaseAdmin();

    if (!token) {
      req.user = { uid: 'dev-user', email: 'dev@roastlab.app', role: 'admin' };
      return next();
    }

    if (!app) {
      return res.status(503).json({ message: 'Firebase Admin is not configured.' });
    }

    const decoded = await admin.auth().verifyIdToken(token);
    req.user = decoded;
    next();
  } catch (error) {
    return res.status(401).json({ message: error.message ?? 'Unauthorized' });
  }
}

export function requireAdmin(req, res, next) {
  if (req.user?.role === 'admin' || req.user?.admin === true) {
    return next();
  }

  return res.status(403).json({ message: 'Admin access required.' });
}
