package vue3.macro.utils;

import haxe.DynamicAccess;

using StringTools;

#if macro
class Args {
	public static function parser():Dynamic {
		var args = Sys.args();
		var lastKey = "";
		var lastValue = "";
		var obj:DynamicAccess<Dynamic> = {};
		for (key in args) {
			if (key.indexOf("-") != -1) {
				lastKey = key.replace("-", "");
			} else {
				lastValue = key;
				// 写入
				obj[lastKey] = lastValue;
			}
		}
		return obj;
	}
}
#end
