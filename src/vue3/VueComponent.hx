package vue3;

using Reflect;

/**
 * Vue组件基础实现，实现一个新组件时，可继承`VueComponent`进行实现；
 */
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

	/**
	 * 注册组件，一般`VueBuilder`宏会自动将组件注册
	 * @param type 
	 */
	public function component(type:Class<Dynamic>):Void {
		var name = Type.getClassName(type);
		var list = name.split(".");
		this.components.setProperty(list[list.length - 1], Type.createInstance(type, []));
	}
}
