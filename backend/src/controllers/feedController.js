import { Comment } from '../models/Comment.js';
import { Like } from '../models/Like.js';
import { Post } from '../models/Post.js';
import { ensureUserFromAuth } from '../services/userService.js';

export async function listPosts(req, res) {
  const posts = await Post.find().sort({ createdAt: -1 }).limit(50).lean();
  res.json(posts);
}

export async function createPost(req, res) {
  const user = await ensureUserFromAuth(req.user);
  const post = await Post.create({
    userId: user?._id,
    caption: req.body.caption,
    brewMethod: req.body.brewMethod,
    roastTag: req.body.roastTag,
    imageUrl: req.body.imageUrl,
  });
  res.status(201).json(post);
}

export async function addComment(req, res) {
  const user = await ensureUserFromAuth(req.user);
  const comment = await Comment.create({
    postId: req.params.postId,
    userId: user?._id,
    message: req.body.message,
  });
  await Post.findByIdAndUpdate(req.params.postId, { $inc: { commentCount: 1 } });
  res.status(201).json(comment);
}

export async function toggleLike(req, res) {
  const user = await ensureUserFromAuth(req.user);
  const existing = await Like.findOne({ postId: req.params.postId, userId: user?._id });
  if (existing) {
    await existing.deleteOne();
    await Post.findByIdAndUpdate(req.params.postId, { $inc: { likeCount: -1 } });
    return res.json({ liked: false });
  }

  await Like.create({ postId: req.params.postId, userId: user?._id });
  await Post.findByIdAndUpdate(req.params.postId, { $inc: { likeCount: 1 } });
  return res.json({ liked: true });
}
