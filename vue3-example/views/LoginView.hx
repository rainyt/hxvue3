package views;

import element.plus.ElMessage;
import vue3.VueComponent;

/**
 * 登陆界面
 */
@:t("html/loginview.html")
class LoginView extends VueComponent {
	override function data():Dynamic {
		return {
			formLabelAlign: {},
			lockme: false
		}
	}

	public function onLogin():Void {
		ElMessage.error("功能未开放");
	}
}
