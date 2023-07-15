package vue3.macro.utils;

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

	public function new() {
		#if macro
		var obj = Args.parser();
		var js = new Path(obj.js);
		appName = js.file.replace(".js", "");
		trace("Compiler params:", obj);
		outputDir = new Path(obj.js).dir;
		outputLibDir = Path.join([outputDir, "lib"]);
		mainCssFile = Path.join([outputLibDir, "main.css"]);
		#end
	}
}
