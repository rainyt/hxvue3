package vue3.macro.utils;

#if (macro || sys)
import sys.io.Process;
#end
import haxe.io.Path;

using StringTools;

class Project {
	/**
	 * 应用名称，一般指的是JS输出名字
	 */
	public var appName:String = "main";

	/**
	 * 输出目录
	 */
	public var outputDir:String = "";

	/**
	 * 输出的lib目录
	 */
	public var outputLibDir:String = "";

	/**
	 * 储存css的主要文件
	 */
	public var mainCssFile:String = "";

	/**
	 * hxvue3目录
	 */
	public var hxvue3Dir:String = "";

	/**
	 * 当前编译的原始路径
	 */
	public var compilerCwd:String = "";

	/**
	 * electron引用模块
	 */
	public var require:Array<{url:String}> = [];

	public function new() {
		#if macro
		compilerCwd = Sys.getCwd();
		var obj = Args.parser();
		var js = new Path(obj.js);
		appName = js.file.replace(".js", "");
		trace("Compiler params:", obj);
		outputDir = new Path(obj.js).dir;
		outputLibDir = Path.join([outputDir, "lib"]);
		mainCssFile = Path.join([outputLibDir, "main.css"]);
		var p:Process = new Process("haxelib", ["libpath", "hxvue3"]);
		var path:String = p.stdout.readAll().toString();
		path = StringTools.replace(path, "\n", "");
		path = StringTools.replace(path, "\r", "");
		p.close();
		hxvue3Dir = path;
		for (item in VueBuilder.requires) {
			require.push(item);
		}
		#end
	}

	/**
	 * 获得hxvue3目录下的路径
	 * @param file 
	 * @return String
	 */
	public function getHxvue3DirPath(file:String):String {
		return Path.join([hxvue3Dir, file]);
	}

	/**
	 * 获取输出的临时目录的路径
	 * @return String
	 */
	public function getOutputTempDir():String {
		return Path.join([outputDir, ".temp"]);
	}
}
