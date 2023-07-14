package vue3.macro;

import vue3.macro.utils.Args;
import vue3.macro.utils.Project;
import haxe.Template;
import haxe.io.Path;
#if macro
import sys.FileSystem;
import sys.io.Process;
import sys.io.File;
import haxe.macro.Context;

class Compiler {
	macro public static function use():Void {
		Context.onAfterGenerate(() -> {
			// 获得JS输出位置
			var args = vue3.macro.utils.Args.parser();
			trace("Compiler params:", args);
			var dir = new Path(args.js).dir;
			var libDir = Path.join([dir, "lib"]);
			FileSystem.createDirectory(libDir);
			// 生成CSS文件
			var csslist:Array<String> = [];
			for (v in VueBuilder.css) {
				csslist.push(v);
			}
			File.saveContent(Path.join([libDir, "main.css"]), csslist.join("\n"));
			var p:Process = new Process("haxelib", ["libpath", "hxvue3"]);
			var path:String = p.stdout.readAll().toString();
			path = StringTools.replace(path, "\n", "");
			path = StringTools.replace(path, "\r", "");
			p.close();
			copyFile(Path.join([path, "dist"]), Path.join([libDir, "dist"]));
			// 模板写入
			if (VueBuilder.mainHtmlFile != null) {
				saveTemplateFile(Path.join([dir, "index.html"]), File.getContent(VueBuilder.mainHtmlFile));
			} else
				saveTemplateFile(Path.join([dir, "index.html"]), File.getContent(Path.join([path, "index.html"])));
		});
	}

	/**
	 * 储存模板
	 * @param savePath 
	 * @param html 
	 */
	private static function saveTemplateFile(savePath:String, text:String, ?defines:Project):Void {
		var t = new Template(text);
		var content = t.execute(defines ?? new Project());
		File.saveContent(savePath, content);
	}

	public static function copyFile(copy:String, to:String):Void {
		if (!FileSystem.exists(copy)) {
			return;
		}
		if (FileSystem.isDirectory(copy)) {
			for (file in FileSystem.readDirectory(copy)) {
				copyFile(copy + "/" + file, to + "/" + file);
			}
		} else {
			var dir = to.substr(0, to.lastIndexOf("/"));
			FileSystem.createDirectory(dir);
			File.copy(copy, to);
		}
	}
}
#end
