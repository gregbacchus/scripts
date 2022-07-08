import { ApiContext, ControllerApi } from '@geeebe/api';
import { Statuses } from '@geeebe/common';
import * as Router from '@koa/router';
import { env } from '../util/env';
import { childLogger } from '../util/logger';
import { WebhookController } from './webhook.controller';

const log = childLogger('webhook.api');

export class WebhookApi extends ControllerApi<WebhookController> {
  constructor(options?: Router.RouterOptions) {
    super('/.webhook/:webhook', options);
  }

  protected createController(_ctx: ApiContext): WebhookController {
    return new WebhookController();
  }

  protected mountRoutes(): void {
    this.post('/update', this.withController(this.updateScripts));
  }

  private updateScripts = async (controller: WebhookController, ctx: ApiContext): Promise<void> => {
    const { webhook } = ctx.params;
    if (webhook !== env.WEBHOOK_RANDOM) return;

    try {
      await controller.updateScripts();
      ctx.status = Statuses.OK;
    } catch (err) {
      log.error(err as Error);
      ctx.status = Statuses.SERVER_ERROR;
    }

    return Promise.resolve();
  }
}
