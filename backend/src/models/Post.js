import mongoose from 'mongoose';

const postSchema = new mongoose.Schema(
  {
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    caption: { type: String, required: true },
    brewMethod: String,
    roastTag: String,
    imageUrl: String,
    likeCount: { type: Number, default: 0 },
    commentCount: { type: Number, default: 0 },
  },
  { timestamps: true }
);

export const Post = mongoose.model('Post', postSchema);
