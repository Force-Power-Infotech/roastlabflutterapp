import mongoose from 'mongoose';

const videoSchema = new mongoose.Schema(
  {
    title: { type: String, required: true },
    category: { type: String, required: true },
    youtubeId: { type: String, required: true },
    duration: String,
    description: String,
    isPublished: { type: Boolean, default: true },
  },
  { timestamps: true }
);

export const Video = mongoose.model('Video', videoSchema);
