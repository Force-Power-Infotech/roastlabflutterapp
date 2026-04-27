import { Notification } from '../models/Notification.js';
import { Subscription } from '../models/Subscription.js';
import { Video } from '../models/Video.js';
import { ensureUserFromAuth } from '../services/userService.js';

export async function listVideos(req, res) {
  const videos = await Video.find({ isPublished: true }).sort({ createdAt: -1 }).lean();
  res.json(videos);
}

export async function listNotifications(req, res) {
  const user = await ensureUserFromAuth(req.user);
  const notifications = await Notification.find({ userId: user?._id }).sort({ createdAt: -1 }).lean();
  res.json(notifications);
}

export async function upsertSubscription(req, res) {
  const user = await ensureUserFromAuth(req.user);
  const subscription = await Subscription.findOneAndUpdate(
    { userId: user?._id },
    {
      userId: user?._id,
      plan: req.body.plan,
      provider: req.body.provider ?? 'manual',
      status: req.body.status ?? 'active',
      renewsAt: req.body.renewsAt,
    },
    { new: true, upsert: true, setDefaultsOnInsert: true }
  );
  res.json(subscription);
}
