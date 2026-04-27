import { Recipe } from '../models/Recipe.js';
import { ensureUserFromAuth } from '../services/userService.js';

export async function listRecipes(req, res) {
  const user = await ensureUserFromAuth(req.user);
  const recipes = await Recipe.find({ userId: user?._id }).sort({ createdAt: -1 }).lean();
  res.json(recipes);
}

export async function createRecipe(req, res) {
  const user = await ensureUserFromAuth(req.user);
  const recipe = await Recipe.create({
    userId: user?._id,
    name: req.body.name,
    method: req.body.method,
    dose: req.body.dose,
    water: req.body.water,
    notes: req.body.notes,
  });
  res.status(201).json(recipe);
}
