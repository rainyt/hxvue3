import vue3.VueComponent;
import element.plus.RouteResult;

@:t("html/main.html")
@:style("css/main.css")
class MainPage extends VueComponent {
	public function new() {
		super();
		trace("构造测试");
	}

	public function onClick():Void {
		trace("点击到了");
	}

	public function onHeadMenuSelect(key:String, paths:Array<String>, routeResult:RouteResult):Void {
		trace("选择了对象", key, paths, routeResult);
		this.emit("onMenuSelect", key);
	}
}
