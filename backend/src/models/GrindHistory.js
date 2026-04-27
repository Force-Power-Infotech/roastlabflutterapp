import mongoose from 'mongoose';

const grindHistorySchema = new mongoose.Schema(
  {
    scanId: { type: mongoose.Schema.Types.ObjectId, ref: 'Scan', required: true },
    grindBand: { type: String, required: true },
    finesPercent: { type: Number, required: true },
  },
  { timestamps: true }
);

export const GrindHistory = mongoose.model('GrindHistory', grindHistorySchema);
