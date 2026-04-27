import { User } from '../models/User.js';

export async function upsertProfile(req, res) {
  const profile = await User.findOneAndUpdate(
    { firebaseUid: req.user.uid },
    {
      firebaseUid: req.user.uid,
      email: req.user.email,
      name: req.body.name ?? req.user.name ?? 'RoastLab User',
      avatarUrl: req.body.avatarUrl,
    },
    { new: true, upsert: true, setDefaultsOnInsert: true }
  );

  res.json(profile);
}
