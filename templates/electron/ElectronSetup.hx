package;

import electron.main.BrowserWindow;

class ElectronSetup {
	static function main() {
		var window = new BrowserWindow({
			width: 800,
			height: 600,
			webPreferences: {
				nodeIntegration: true
			}
		});
		window.loadFile("./index.html");
	}
}
