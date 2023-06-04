import vue3.VueComponent;

@:t("test/html/main.html")
class MainPage extends VueComponent {
	public function new() {
		super();
        trace("构造测试");
	}

    public function onClick():Void{
        trace("点击到了");
    }
}
