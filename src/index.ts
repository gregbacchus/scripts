import { MonitoringService } from '@geeebe/api';
import { Time } from '@geeebe/common';
import { graceful } from '@geeebe/service';
import { Service } from './service';
import { env } from './util/env';
import { childLogger } from './util/logger';

const logger = childLogger('app');

const main = async (): Promise<void> => {
  let stopping = false;
  const service = Service.for(logger);

  const monitoring = new MonitoringService({
    isReady: () => Promise.resolve(!stopping),
    logger,
    port: env.MONITORING_PORT,
  });

  // prepare graceful, clean shutdown on SIGINT or SIGTERM
  graceful(
    Time.seconds(10),
    () => {
      stopping = true;
      return service.stop();
    },
    () => monitoring.stop()
  );

  // fire it up
  await service.start();
  await monitoring.start();
};

main().catch((err) => logger.error(err));
