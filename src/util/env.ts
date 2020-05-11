import { bool, cleanEnv, port, str } from 'envalid';

// make sure all required env vars are present
export const env = cleanEnv(process.env, {
  LOG_JSON: bool({ default: false, desc: 'Write logs formatted as JSON' }),
  MONITORING_PORT: port({ default: 55892 }),
  SERVICE_PORT: port({ default: 55891 }),
  WEBHOOK_RANDOM: str({ desc: 'Long random string to be used to obscure webhook requests' }),
});
