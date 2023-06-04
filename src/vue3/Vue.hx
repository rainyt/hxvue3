package vue3;

import js.Syntax;

/**
 * 更新属性，跟this.key = value同理
 * @param key 
 * @param value 
 */
inline function set(key:String, value:Dynamic):Void {
	Syntax.code("this[{0}] = {1}", key, value);
}

@:native("Vue")
extern class Vue {
	/**
	 * 创建一个config配置
	 * @param config 
	 * @return Vue
	 */
	public static function createApp(config:VueComponent):Vue;

	/**
	 * 装载Vue到指定的ID
	 * @param id 
	 */
	public function mount(id:String):Void;

	/**
	 * 卸载Vue
	 */
	public function unmount():Void;

    /**
     * 使用组件
     * @param type 
     */
    public function use(type:Dynamic):Void;

	/**
	 * 组件绑定
	 * @param type 
	 * @param bind 
	 */
	public function component(type:String, bind:Dynamic):Void;
}

/**
 * App配置
 */
typedef AppConfig = {
	?data:Void->Dynamic,
	?template:String,
	?methods:Dynamic
}
