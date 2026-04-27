import mongoose from 'mongoose';

const roastHistorySchema = new mongoose.Schema(
  {
    scanId: { type: mongoose.Schema.Types.ObjectId, ref: 'Scan', required: true },
    roastScore: { type: Number, required: true },
    roastBand: { type: String, required: true },
  },
  { timestamps: true }
);

export const RoastHistory = mongoose.model('RoastHistory', roastHistorySchema);
