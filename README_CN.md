# HxVue3
可以使用Haxe编写vue3的API，并且自带了elementui的组件。

## 使用
我们可以使用**Vue3**的原始API，创建一个app，并挂载到**app**身上：
```haxe
var app = new App();
var vue = Vue.createApp(app);
vue.use(ElementPlus);
vue.mount("#app");
```
> 可参考**test**目录下的实例

## 组件
使用`VueComponent`来构造组件，`VueComponent`会自动处理所有方法的映射关系、以及会将data()中的定义返回，允许在Haxe中直接访问，在这里，也不需要关心`methods`和`components`的定义，由宏自动处理：
```haxe
import vue3.VueComponent;
/**
 * 一个App组件
 */
@:template("test/html/app.html")
class App extends VueComponent {
	public function new() {
		super();
		this.component(MainPage);
	}

	/**
	 * 通过宏，该data，会变成变量返回
	 */
	override function data() {
		return {
			btn_label: "测试文案"
		};
	}

	public function onClick():Void {
		trace("这是点击测试");
		this.btn_label = "点击成功";
	}
}
```

## 模板
通过元数据`@:template`来定义模板路径，指定到外部的html文件，它不需要完整的html格式，只需要vue能解析的html格式即可。
> 可以使用`@:t`简写来代替`@:template`

## 样式
通过元数据`@:style`来定义CSS。
> 可以使用`@:s`简写来代替`@:style`

## 调试
通过`haxelib run hxvue3 --port 5555`命令指定端口进行调试。

# Electron目标
如果需要编译`Electron`目标时，请使用`electron`库，例如在hxml中引入：
```hxml
-lib electron
```
需要启动`electron`程序时，则需要确保安装了`npm install -g electron`，最后命令运行启动：
```shell
electron ./ElectronSetup.js
```