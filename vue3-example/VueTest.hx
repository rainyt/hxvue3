package;

import element.plus.ElementPlus;
import element.plus.ElMessage;
import vue3.Vue;

class VueTest {
	static function main() {
		// 构造App组件
		var app = new App();
		var vue = Vue.createApp(app);
		vue.use(ElementPlus);
		vue.mount("#app");
	}
}
