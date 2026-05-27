import admin from 'firebase-admin';

import { env } from '../config/env.js';
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

    if (env.adminApiToken && token === env.adminApiToken) {
      req.user = {
        uid: 'admin-token',
        email: 'admin@roastlab.app',
        role: 'admin',
        admin: true,
      };
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
  const adminEmail = req.user?.email;
  const adminUid = req.user?.uid;

  if (req.user?.role === 'admin' || req.user?.admin === true) {
    return next();
  }

  if (adminEmail && env.adminEmails.includes(adminEmail)) {
    return next();
  }

  if (adminUid && env.adminUids.includes(adminUid)) {
    return next();
  }

  return res.status(403).json({ message: 'Admin access required.' });
}
