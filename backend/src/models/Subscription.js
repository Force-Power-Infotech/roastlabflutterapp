import mongoose from 'mongoose';

const subscriptionSchema = new mongoose.Schema(
  {
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    plan: { type: String, required: true },
    provider: { type: String, default: 'manual' },
    status: { type: String, enum: ['active', 'past_due', 'cancelled'], default: 'active' },
    renewsAt: Date,
  },
  { timestamps: true }
);

export const Subscription = mongoose.model('Subscription', subscriptionSchema);
