import dotenv from 'dotenv';

dotenv.config();

function parseList(value) {
  return value
    .split(',')
    .map((entry) => entry.trim())
    .filter(Boolean);
}

export const env = {
  port: Number(process.env.PORT ?? 8080),
  mongoUri: process.env.MONGODB_URI ?? '',
  firebaseProjectId: process.env.FIREBASE_PROJECT_ID ?? '',
  firebaseClientEmail: process.env.FIREBASE_CLIENT_EMAIL ?? '',
  firebasePrivateKey: process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g, '\n') ?? '',
  adminApiToken: process.env.ADMIN_API_TOKEN ?? '',
  adminEmails: parseList(process.env.ADMIN_EMAILS ?? ''),
  adminUids: parseList(process.env.ADMIN_UIDS ?? ''),
};
