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