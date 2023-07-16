package;

import js.Browser;
import electron.renderer.IpcRenderer;
import electron.FileFilter;
import electron.main.Dialog;
import haxe.Json;
import electron.main.IpcMain;
import electron.main.BrowserWindow;

class ElectronSetup {
	static function main() {
		ElectronApp.on("ready", () -> {
			var config = Json.parse('{
				"width": ::if width::::width::::else::1000::end::,
				"height": ::if height::::height::::else::800::end::,
				"webPreferences": {
					"nodeIntegration": true,
					"contextIsolation": false
				}
			}');
			var window = new BrowserWindow(config);
			window.loadFile("./index.html");
			ElectronFileSystem.init(window);
			// 扩展实现
			#if templates
			::foreach require::untyped require("::url::");
			::end::
			#end
		});
	}
}

@:jsRequire("electron", "app") extern class ElectronApp {
	public static var commandLine:Dynamic;
	public static function on(type:Dynamic, callback:Dynamic):Dynamic;
	public static function quit():Void;
}

class ElectronFileSystem {
	public static function init(window:BrowserWindow):Void {
		IpcMain.on("open-file", (event, data) -> {
			Dialog.showOpenDialog(window, data).then((data) -> {
				untyped window.send("open-file", data);
			});
		});
	}
}
