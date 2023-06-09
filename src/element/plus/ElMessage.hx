package element.plus;

@:native("ElementPlus.ElMessage")
extern class ElMessage {
	/**
	 * 发送错误消息
	 * @param msg 
	 */
	public static function error(msg:String):Void;

	/**
	 * 发送成功消息
	 * @param msg 
	 */
	public static function success(msg:String):Void;
}
