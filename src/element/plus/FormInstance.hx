package element.plus;

/**
 * 表单单例
 */
@:native("ElementPlus.FormInstance")
extern class FormInstance {
	/**
	 * 重置所有属性
	 */
	public function resetFields():Void;

	/**
	 * 校验结果
	 * @param cb 
	 */
	public function validate(cb:Bool->Void):Void;
}
