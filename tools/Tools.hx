package;

import hxargs.Args;
import hxp.PlatformTools;

class Tools {
	static function main() {
		var port = 5555;
		var args = Args.generate([
			@doc("Set the document root path")
			["--port"] => function(v) {
				trace("地址：", v);
				port = v;
			},
			_ => function(v) {}
		]);
		var cmdArgs = Sys.args();
		args.parse(cmdArgs);
		var path = cmdArgs[cmdArgs.length - 1];
		PlatformTools.launchWebServer(path + "bin", port);
	}
}
