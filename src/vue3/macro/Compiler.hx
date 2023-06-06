package vue3.macro;

#if macro
import sys.io.File;
import haxe.macro.Context;

class Compiler {
	macro public static function use():Void {
		Context.onAfterGenerate(() -> {
			File.saveContent("./bin/dist.css", VueBuilder.css.join("\n"));
		});
	}
}
#end
