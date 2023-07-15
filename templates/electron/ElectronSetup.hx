package;

import electron.main.BrowserWindow;

class ElectronSetup {
	static function main() {
		ElectronApp.on("ready", () -> {
			var window = new BrowserWindow({
				width: ::if width::::width::::else::1000::end::,
				height: ::if height::::height::::else::800::end::,
				webPreferences: {
					nodeIntegration: true
				}
			});
			window.loadFile("./index.html");
		});
	}
}

@:jsRequire("electron", "app") extern class ElectronApp {
	public static var commandLine:Dynamic;
	public static function on(type:Dynamic, callback:Dynamic):Dynamic;
	public static function quit():Void;
}