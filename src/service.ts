import { ExtraContext } from '@geeebe/api';
import { Logger } from '@geeebe/logging';
import { KoaService, ServiceOptions } from '@geeebe/service';
import { resolve } from 'path';
import { ScriptApi } from './api/script.api';
import { WebhookApi } from './api/webhook.api';
import { env } from './util/env';

import Router = require('koa-router');

export class Service extends KoaService<ServiceOptions> {
  public static for(logger: Logger): Service {
    return new Service({
      logger,
      omitMonitoringEndpoints: true,
      port: env.SERVICE_PORT,
    });
  }

  constructor(options: ServiceOptions) {
    super(options);

    this.proxy = true;
  }

  protected mountApi(router: Router): void {
    new ScriptApi({ scriptDirectory: resolve(__dirname, '../scripts') }).mount(router as unknown as Router<any, ExtraContext>);
    new WebhookApi().mount(router as unknown as Router<any, ExtraContext>);
  }
}
