package views;

import element.plus.ElMessage;
import element.plus.ElementPlus;
import vue3.Vue;
import vue3.VueComponent;
import element.plus.RouteResult;

@:t("html/mainpage.html")
@:style("css/main.css")
class MainPage extends VueComponent {
	public function new() {
		super();
		trace("构造测试");
	}

	override function data():Dynamic {
		return {
			activeIndex: ""
		}
	}

	public function onClick():Void {
		trace("点击到了");
	}

	public function onHeadMenuSelect(key:String, paths:Array<String>, routeResult:RouteResult):Void {
		activeIndex = key;
		this.emit("onMenuSelect", key);
	}

	/**
	 * 登陆界面展示
	 */
	public function onOpenLogin():Void {
		var app = Vue.createApp(new LoginView());
		app.use(ElementPlus);
		app.mount("#box");
	}

	/**
	 * 打开注册界面
	 */
	public function onOpenUserAdd():Void {
		ElMessage.error("功能未开放");
	}
}
