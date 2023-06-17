package vue3;

import js.Syntax;

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

	/**
	 * 组件参数
	 */
	public var props:Dynamic = null;

	public function new() {
		// 绑定数据源
		untyped this.data = data;
		// 初始化方法
		if (this.field("methodsKeys") != null) {
			var array:Array<String> = this.getProperty("methodsKeys");
			array.push("unmount");
			array.push("emit");
			array.push("get");
			array.push("onCreated");
			array.push("onMounted");
			array.push("onBeforeCreate");
			for (key in array) {
				this.methods.setField(key, this.getProperty(key));
			}
		}
		untyped this.mounted = this.methods.onMounted;
		untyped this.created = this.methods.onCreated;
		untyped this.beforeCreate = this.methods.onBeforeCreate;
		untyped this.beforeMount = this.methods.onBeforeMount;
		untyped this.beforeCreate = this.methods.onBeforeCreate;
		untyped this.updated = this.methods.onUpdated;
		untyped this.beforeUnmount = this.methods.onBeforeUnmount;
		untyped this.unmounted = this.methods.onUnmounted;
		untyped this.errorCaptured = this.methods.onErrorCaptured;
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
	 * 
	 */
	public function component(type:Class<Dynamic>):Void {
		var name = Type.getClassName(type);
		var list = name.split(".");
		this.components.setProperty(list[list.length - 1], Type.createInstance(type, []));
	}

	/**
	 * 发送事件
	 * @param ...args 
	 */
	public function emit(...args):Void {
		var list = args.toArray();
		var call = Syntax.code("this.$emit");
		Reflect.callMethod(this, call, list);
	}

	/**
	 * 获得对象
	 * @param id 
	 * @param t 
	 * @return T
	 */
	public function get<T>(id:String, t:Class<T>):T {
		return cast Syntax.code("this.$refs[{0}]", id);
	}

	/**
	 * 实例挂载到 DOM 上后被调用，此时可以操作 DOM 元素。
	 */
	public function onMounted():Void {}

	/**
	 * 在实例创建完成后被立即调用。在这一步，实例已完成以下的配置：数据观测(data observer)，属性和方法的运算，watch/event 事件回调。然而，挂载阶段还没开始，$el 属性目前尚不可用。
	 */
	public function onCreated():Void {}

	/**
	 * 在实例初始化之后、响应式数据观测 (data observer) 和 event/watcher 事件配置之前被调用。
	 */
	public function onBeforeCreate():Void {}

	/**
	 * 在挂载开始之前被调用。相关的 render 函数首次被调用。
	 */
	public function onBeforeMount():Void {}

	/**
	 * 在数据更新之前被调用，发生在虚拟 DOM 重新渲染和打补丁之前。可以在该钩子函数中进一步地更改数据，但注意不要触发更新无限循环。
	 */
	public function onBeforeUpdate():Void {}

	/**
	 * 在由于数据更改导致的虚拟 DOM 重新渲染和打补丁之后调用。当该钩子函数被调用时，组件 DOM 已经更新完毕。
	 */
	public function onUpdated():Void {}

	/**
	 * 在实例销毁之前调用。在这一步，实例仍然完全可用。
	 */
	public function onBeforeUnmount():Void {}

	/**
	 * 在实例销毁之后调用。此时，所有的指令已被解绑，所有的事件监听器已被移除，所有子实例也都被销毁。
	 */
	public function onUnmounted():Void {}

	/**
	 * 当捕获一个来自子孙组件的异常时被调用。此钩子函数可以返回 false 以阻止该异常继续向上传播。
	 */
	public function onErrorCaptured(res:Dynamic):Bool {
		return true;
	}
}

// 1. 创建阶段
// beforeCreate()：在实例初始化之后、响应式数据观测 (data observer) 和 event/watcher 事件配置之前被调用。
// created()：在实例创建完成后被立即调用。在这一步，实例已完成以下的配置：数据观测(data observer)，属性和方法的运算，watch/event 事件回调。然而，挂载阶段还没开始，$el 属性目前尚不可用。
// beforeMount()：在挂载开始之前被调用。相关的 render 函数首次被调用。
// mounted()：实例挂载到 DOM 上后被调用，此时可以操作 DOM 元素。
// 2. 更新阶段
// beforeUpdate()：在数据更新之前被调用，发生在虚拟 DOM 重新渲染和打补丁之前。可以在该钩子函数中进一步地更改数据，但注意不要触发更新无限循环。
// updated()：在由于数据更改导致的虚拟 DOM 重新渲染和打补丁之后调用。当该钩子函数被调用时，组件 DOM 已经更新完毕。
// 3. 卸载阶段
// beforeUnmount()：在实例销毁之前调用。在这一步，实例仍然完全可用。
// unmounted()：在实例销毁之后调用。此时，所有的指令已被解绑，所有的事件监听器已被移除，所有子实例也都被销毁。
// 4. 错误处理
// errorCaptured()：当捕获一个来自子孙组件的异常时被调用。此钩子函数可以返回 false 以阻止该异常继续向上传播。
