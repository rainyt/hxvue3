package vue3;

using Reflect;

@:autoBuild(vue3.macro.VueBuilder.build())
class VueComponent {
	/**
	 * 方法绑定
	 */
	public var methods:Dynamic = {};

	/**
	 * 组件名称
	 */
	public var name:String;

	/**
	 * 组件属性
	 */
	public var components:Dynamic = {};

	public function new() {
		// 绑定数据源
		untyped this.data = data;
		// 初始化方法
		if (this.field("methodsKeys") != null) {
			var array:Array<String> = this.getProperty("methodsKeys");
			for (key in array) {
				this.methods.setField(key, this.getProperty(key));
			}
		}
	}

	/**
	 * 数据源
	 * @return Dynamic
	 */
	private function data():Dynamic {
		return {};
	}

	public function component(type:Class<Dynamic>):Void {
		var name = Type.getClassName(type);
		var list = name.split(".");
		this.components.setProperty(list[list.length - 1], Type.createInstance(type, []));
	}
}
