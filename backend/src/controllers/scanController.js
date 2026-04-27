import { GrindHistory } from '../models/GrindHistory.js';
import { RoastHistory } from '../models/RoastHistory.js';
import { Scan } from '../models/Scan.js';
import { ensureUserFromAuth } from '../services/userService.js';

export async function listScans(req, res) {
  const user = await ensureUserFromAuth(req.user);
  const scans = await Scan.find({ userId: user?._id }).sort({ createdAt: -1 }).lean();
  res.json(scans);
}

export async function createScan(req, res) {
  const user = await ensureUserFromAuth(req.user);
  const scan = await Scan.create({
    userId: user?._id,
    type: req.body.type,
    label: req.body.label,
    score: req.body.score,
    consistency: req.body.consistency,
    finesPercent: req.body.finesPercent,
    unevenWarning: req.body.unevenWarning,
    suggestedBrewMethod: req.body.suggestedBrewMethod,
    imageUrl: req.body.imageUrl,
    notes: req.body.notes ?? [],
  });

  if (scan.type === 'roast') {
    await RoastHistory.create({
      scanId: scan._id,
      roastScore: scan.score,
      roastBand: scan.label,
    });
  } else {
    await GrindHistory.create({
      scanId: scan._id,
      grindBand: scan.label,
      finesPercent: scan.finesPercent,
    });
  }

  res.status(201).json(scan);
}
