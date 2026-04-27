import mongoose from 'mongoose';

const userSchema = new mongoose.Schema(
  {
    firebaseUid: { type: String, required: true, unique: true, index: true },
    name: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    avatarUrl: String,
    role: { type: String, enum: ['user', 'admin'], default: 'user' },
    subscriptionTier: { type: String, enum: ['free', 'pro'], default: 'free' },
    followingCount: { type: Number, default: 0 },
    followerCount: { type: Number, default: 0 },
  },
  { timestamps: true }
);

export const User = mongoose.model('User', userSchema);
