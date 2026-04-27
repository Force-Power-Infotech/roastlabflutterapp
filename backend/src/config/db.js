import mongoose from 'mongoose';

import { env } from './env.js';

export async function connectDatabase() {
  if (!env.mongoUri) {
    console.warn('MONGODB_URI is missing. API will start without a database connection.');
    return;
  }

  await mongoose.connect(env.mongoUri, {
    autoIndex: true,
  });
}
