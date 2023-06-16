package element.plus;

import js.lib.Promise;

@:native("ElementPlus.ElMessageBox")
extern class ElMessageBox {
	overload public static function confirm(content:String, ?title:String, ?option:ElMessageBoxOption):Promise<Dynamic>;
}

typedef ElMessageBoxOption = {
	?confirmButtonText:String,
	?cancelButtonText:String,
	?type:String
}
