package vue3.macro.utils;

import sys.io.File;
import sys.FileSystem;
import haxe.io.Path;

class FileTools {
	/**
	 * 通用的储存文件接口
	 * @param path 
	 * @param content 
	 */
	public static function saveContent(path:String, content:String):Void {
		#if (macro || sys)
		var file = new Path(path);
		if (!FileSystem.exists(file.dir)) {
			FileSystem.createDirectory(file.dir);
		}
		File.saveContent(path, content);
		#end
	}
}
