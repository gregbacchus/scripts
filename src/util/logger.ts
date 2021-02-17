import { ConsoleWriter, logger, Logger, loggerOptions, OMIT_PRETTY } from '@geeebe/logging';
import { env } from './env';
export { logger } from '@geeebe/logging';

loggerOptions.writer = new ConsoleWriter({ pretty: !env.LOG_JSON, prettyOmit: OMIT_PRETTY });

export const childLogger = (module: string, meta?: Record<string, unknown>): Logger => {
  return logger.child({ ...meta, module });
};
