package element.plus;

typedef FormRule = {
	?validator:Dynamic->Dynamic->Dynamic->Void,
	?trigger:Dynamic,
	?required:Bool,
	?message:String,
}
