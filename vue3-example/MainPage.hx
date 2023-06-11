import vue3.VueComponent;
import element.plus.RouteResult;

@:t("html/main.html")
@:style("css/main.css")
class MainPage extends VueComponent {
	public function new() {
		super();
		trace("构造测试");
	}

	override function data():Dynamic {
		return {
			activeIndex: "/"
		}
	}

	public function onClick():Void {
		trace("点击到了");
	}

	public function onHeadMenuSelect(key:String, paths:Array<String>, routeResult:RouteResult):Void {
		activeIndex = key;
		this.emit("onMenuSelect", key);
	}
}
