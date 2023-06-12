package views;

import element.plus.ElementPlus;
import vue3.Vue;
import vue3.VueComponent;

/**
 * 一个App组件
 */
@:template("html/app.html")
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
			btn_label: "测试文案",
			currentPageName: null
		};
	}

	public function onClick():Void {
		this.btn_label = "点击成功";
	}

	private var _currentApp:Vue;

	public function onMenuSelect(index:String):Void {
		currentPageName = switch index {
			case "engine_doc":
				"引擎文档";
			case "haxe":
				"Haxe手册";
			case "hxwz":
				"幻想纹章";
			case "open_source":
				"开源项目";
			case "projects":
				"项目经验";
			default:
				null;
		};
		if (_currentApp != null) {
			_currentApp.unmount();
		}
		switch index {
			case "":
				_currentApp = Vue.createApp(new HomePage());
			default:
				_currentApp = Vue.createApp(new NotFound());
		}
		_currentApp.use(ElementPlus);
		_currentApp.mount("#content");
	}

	override function onMounted() {
		super.onMounted();
		// 发生了挂载
		this.onMenuSelect("");
	}

	/**
	 * 返回首页
	 */
	public function onGoHome():Void {
		var main = this.get("headmenu", MainPage);
		main.activeIndex = "";
	}
}
