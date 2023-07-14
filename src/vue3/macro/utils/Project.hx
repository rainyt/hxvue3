package vue3.macro.utils;

import haxe.io.Path;

using StringTools;

#if macro
class Project {
	/**
	 * 应用名称，一般指的是JS输出名字
	 */
	public var appName:String = "main";

	public function new() {
		var obj = Args.parser();
		var js = new Path(obj.js);
		appName = js.file.replace(".js", "");
	}
}
#end
