import { User } from '../models/User.js';

export async function ensureUserFromAuth(authUser) {
  return User.findOneAndUpdate(
    { firebaseUid: authUser.uid },
    {
      firebaseUid: authUser.uid,
      email: authUser.email ?? `user-${authUser.uid}@roastlab.local`,
      name: authUser.name ?? 'RoastLab User',
      role: authUser.role ?? (authUser.admin ? 'admin' : 'user'),
    },
    { new: true, upsert: true, setDefaultsOnInsert: true }
  );
}
