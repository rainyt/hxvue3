package vue3.macro.utils;

import haxe.Template;
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

	/**
	 * 拷贝模板文件夹到指定为止
	 * @param dir 
	 * @param toDir 
	 */
	public static function copyTemplatesDir(dir:String, toDir:String, project:Project):Void {
		#if (macro || sys)
		var files = FileSystem.readDirectory(dir);
		for (key in files) {
			var path = Path.join([dir, key]);
			var toPath = Path.join([toDir, key]);
			if (FileSystem.isDirectory(path)) {
				copyTemplatesDir(path, toPath, project);
			} else {
				saveTemplateFile(toPath, File.getContent(path), project);
			}
		}
		#end
	}

	/**
	 * 储存模板
	 * @param savePath 
	 * @param html 
	 */
	public static function saveTemplateFile(savePath:String, text:String, ?defines:Project):Void {
		var t = new Template(text);
		var content = t.execute(defines ?? new Project());
		saveContent(savePath, content);
	}

	/**
	 * 删除文件夹
	 * @param dir 
	 */
	public static function removeDir(dir:String):Void {
		#if (macro || sys)
		for (key in FileSystem.readDirectory(dir)) {
			var path = Path.join([dir, key]);
			if (FileSystem.isDirectory(path)) {
				removeDir(path);
			} else {
				FileSystem.deleteFile(path);
			}
		}
		FileSystem.deleteDirectory(dir);
		#end
	}
}
