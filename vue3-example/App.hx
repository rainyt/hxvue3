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
		trace("这是点击测试");
		this.btn_label = "点击成功";
	}

	public function onMenuSelect(index:String):Void {
		trace(index);
		var main = this.get("headmenu", MainPage);
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
		trace("当前状态：", main.activeIndex);
	}

	/**
	 * 返回首页
	 */
	public function onGoHome():Void {
		var main = this.get("headmenu", MainPage);
		main.activeIndex = "";
	}
}
