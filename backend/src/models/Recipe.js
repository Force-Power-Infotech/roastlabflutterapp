import mongoose from 'mongoose';

const recipeSchema = new mongoose.Schema(
  {
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    name: { type: String, required: true },
    method: { type: String, required: true },
    dose: { type: Number, required: true },
    water: { type: Number, required: true },
    notes: String,
  },
  { timestamps: true }
);

export const Recipe = mongoose.model('Recipe', recipeSchema);
