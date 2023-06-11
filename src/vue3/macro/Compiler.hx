package vue3.macro;

#if macro
import sys.FileSystem;
import sys.io.Process;
import sys.io.File;
import haxe.macro.Context;

class Compiler {
	macro public static function use():Void {
		Context.onAfterGenerate(() -> {
			FileSystem.createDirectory("./bin/lib");
			// 生成CSS文件
			var csslist:Array<String> = [];
			for (v in VueBuilder.css) {
				csslist.push(v);
			}
			File.saveContent("./bin/lib/main.css", csslist.join("\n"));
			var p:Process = new Process("haxelib", ["libpath", "hxvue3"]);
			var path:String = p.stdout.readAll().toString();
			path = StringTools.replace(path, "\n", "");
			path = StringTools.replace(path, "\r", "");
			p.close();
			copyFile(path + "dist", "./bin/lib/dist");
			File.saveContent("./bin/index.html", File.getContent(path + "index.html"));
		});
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
