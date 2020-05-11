import { exec } from 'child_process';
import { childLogger } from '../util/logger';

const log = childLogger('webhook.controller');

export class WebhookController {
  public async updateScripts(): Promise<void> {
    exec('git pull', (err, stdout, stderr) => {
      if (err) {
        log.error(err, { stdout, stderr });
        return;
      }
      log('git pull', { stdout, stderr });
    });
    return Promise.resolve();
  }
}
