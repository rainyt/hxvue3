package vue3;

@:native("ResizeObserver")
extern class ResizeObserver {
	public function new(entries:Array<Dynamic>->Void);

	public function observe(item:Dynamic):Void;
}
