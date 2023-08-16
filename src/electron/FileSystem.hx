package electron;

import electron.FileFilter;
import electron.renderer.IpcRenderer;
#if electron
import electron.main.IpcMain;

class FileSystem {
	/**
	 * 回调事件处理
	 */
	private static var events:Map<String, Dynamic> = [];

	/**
	 * 如果需要使用electron的文件选择器功能，需要先调用`electron.FileSystem.init()`
	 */
	public static function init():Void {
		IpcRenderer.on("open-file", (event, data) -> {
			callEvent("open-file", data);
		});
		IpcRenderer.on("save-file", (event, data) -> {
			callEvent("save-file", data);
		});
	}

	private static function callEvent(event:String, data:Dynamic):Void {
		if (events.exists(event)) {
			var cb = events.get(event);
			if (cb != null)
				cb(data);
		}
	}

	/**
	 * 选择文件
	 * @param option 可选参数
	 * @param cb 回调
	 */
	public static function openFile(?option:FileSystemOpenOption, ?cb:FileEvent->Void):Void {
		events.set("open-file", cb);
		IpcRenderer.send("open-file", option);
	}

	/**
	 * 保存文件
	 * @param option 可选参数
	 * @param cb 回调
	 */
	public static function saveFile(?option:FileSystemOpenOption, ?cb:SaveFileEvent->Void):Void {
		events.set("save-file", cb);
		IpcRenderer.send("save-file", option);
	}
}

typedef SaveFileEvent = {
	canceled:Bool,
	filePath:String
}

typedef FileEvent = {
	canceled:Bool,
	filePaths:Array<String>
};

typedef FileSystemOpenOption = {
	?title:String,
	?defaultPath:String,
	?filters:Array<FileFilter>
}
#end
