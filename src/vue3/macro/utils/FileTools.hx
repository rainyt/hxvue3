package vue3.macro.utils;

import haxe.Template;
import sys.io.File;
import sys.FileSystem;
import haxe.io.Path;

class FileTools {
	/**
	 * 拷贝资源目录到指定位置
	 * @param dir 
	 * @param toDir 
	 */
	public static function copyAssetsDir(dir:String, toDir:String):Void {
		#if (macro || sys)
		var files = FileSystem.readDirectory(dir);
		for (key in files) {
			var path = Path.join([dir, key]);
			var toPath = Path.join([toDir, key]);
			if (FileSystem.isDirectory(path)) {
				copyAssetsDir(path, toPath);
			} else {
				copyTo(path, toPath);
			}
		}
		#end
	}

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
	 * 通用的储存文件接口
	 * @param path 
	 * @param content 
	 */
	public static function copyTo(path:String, toFile:String):Void {
		#if (macro || sys)
		var file = new Path(toFile);
		if (!FileSystem.exists(file.dir)) {
			FileSystem.createDirectory(file.dir);
		}
		File.copy(path, toFile);
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
		var content = t.execute(defines);
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
