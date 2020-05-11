import { ApiContext, ControllerApi } from '@geeebe/api';
import { Statuses } from '@geeebe/common';
import { ScriptController } from './script.controller';

import Router = require('koa-router');

export interface Options extends Router.IRouterOptions {
  scriptDirectory: string;
}

const VALID_NAME = /^[-a-zA-Z0-9_]+$/;

const acceptHtml = (ctx: ApiContext): boolean => {
  return ctx.accepts('text/plain', 'html') === 'html';
};

export class ScriptApi extends ControllerApi<ScriptController> {
  private readonly scriptDirectory: string;

  constructor(options: Options) {
    super('', options);
    this.scriptDirectory = options.scriptDirectory;
  }

  protected createController(_ctx: ApiContext): ScriptController {
    return new ScriptController(this.scriptDirectory);
  }

  protected mountRoutes(): void {
    this.get('/:section/:script', this.withController(this.getDevice));
  }

  private getDevice = async (controller: ScriptController, ctx: ApiContext): Promise<void> => {
    const { section, script } = ctx.params;
    const html = acceptHtml(ctx);

    if (!VALID_NAME.test(section) || !VALID_NAME.test(script)) {
      // invalid
      if (!html) {
        ctx.body = 'echo "Invalid script name" && exit 127';
      }
      ctx.status = Statuses.BAD_REQUEST;
      return;
    }

    const rendered = html
      ? await controller.renderHtml(section, script)
      : await controller.renderScript(section, script);
    if (!rendered) {
      if (!html) {
        ctx.body = 'echo "Script not found" && exit 127';
        ctx.status = Statuses.BAD_REQUEST;
      }
      return;
    }

    ctx.body = rendered.toString();
    ctx.type = html ? 'text/html' : 'text/plain';
    ctx.status = Statuses.OK;
    return Promise.resolve();
  }
}
