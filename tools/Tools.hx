package;

import hxp.PlatformTools;

class Tools {
	static function main() {
		var args = Sys.args();
		var path = args[args.length - 1];
		PlatformTools.launchWebServer(path + "bin", 5555);
	}
}
