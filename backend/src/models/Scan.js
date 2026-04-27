import mongoose from 'mongoose';

const scanSchema = new mongoose.Schema(
  {
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    type: { type: String, enum: ['roast', 'grind'], required: true },
    label: { type: String, required: true },
    score: { type: Number, required: true },
    consistency: { type: Number, required: true },
    finesPercent: { type: Number, default: 0 },
    unevenWarning: { type: Boolean, default: false },
    suggestedBrewMethod: { type: String, required: true },
    imageUrl: String,
    notes: [String],
  },
  { timestamps: true }
);

export const Scan = mongoose.model('Scan', scanSchema);
