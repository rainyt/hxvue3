package;

import electron.main.BrowserWindow;

class ElectronSetup {
	static function main() {
		var window = new BrowserWindow({
			width: ::if width::::width::::else::800::end::,
			height: ::if height::::height::::else::480::end::,
			webPreferences: {
				nodeIntegration: true
			}
		});
		window.loadFile("./index.html");
	}
}
