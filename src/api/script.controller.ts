import { existsSync, readFileSync } from 'fs';
import { join } from 'path';

export class ScriptController {
  constructor(private readonly scriptDirectory: string) { }

  public async renderHtml(section: string, script: string): Promise<Buffer | null> {
    const path = join(this.scriptDirectory, section, `${script}.sh`);
    console.log('HTML', this.scriptDirectory, path);
    if (!existsSync(path)) return Promise.resolve(null);

    const buffer = readFileSync(path);

    return Promise.resolve(buffer ?? null);
  }

  public async renderScript(section: string, script: string): Promise<Buffer | null> {
    const path = join(this.scriptDirectory, section, `${script}.sh`);
    console.log('RAW', this.scriptDirectory, path);
    if (!existsSync(path)) return Promise.resolve(null);

    const buffer = readFileSync(path);

    return Promise.resolve(buffer ?? null);
  }
}
