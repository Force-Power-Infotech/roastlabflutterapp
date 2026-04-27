import { Comment } from '../models/Comment.js';
import { Post } from '../models/Post.js';
import { Subscription } from '../models/Subscription.js';
import { User } from '../models/User.js';
import { Video } from '../models/Video.js';

export async function getAnalytics(req, res) {
  const [users, premiumUsers, posts, comments, videos] = await Promise.all([
    User.countDocuments(),
    Subscription.countDocuments({ status: 'active' }),
    Post.countDocuments(),
    Comment.countDocuments(),
    Video.countDocuments(),
  ]);

  res.json({
    users,
    premiumUsers,
    posts,
    comments,
    videos,
    moderationQueue: Math.max(0, Math.floor(posts * 0.08)),
  });
}

export async function listUsers(req, res) {
  const users = await User.find().sort({ createdAt: -1 }).limit(100).lean();
  res.json(users);
}

export async function listVideosAdmin(req, res) {
  const videos = await Video.find().sort({ createdAt: -1 }).lean();
  res.json(videos);
}

export async function createVideo(req, res) {
  const video = await Video.create(req.body);
  res.status(201).json(video);
}
