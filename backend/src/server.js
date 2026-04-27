import { createApp } from './app.js';
import { connectDatabase } from './config/db.js';
import { env } from './config/env.js';

async function start() {
  await connectDatabase();
  const app = createApp();
  app.listen(env.port, () => {
    console.log(`RoastLab backend listening on http://localhost:${env.port}`);
  });
}

start().catch((error) => {
  console.error('Failed to start RoastLab backend', error);
  process.exit(1);
});
