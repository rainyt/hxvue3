package vue3.macro;

import haxe.io.Path;
#if macro
import sys.FileSystem;
import haxe.macro.Expr.TypePath;
import haxe.Json;
import haxe.macro.TypedExprTools;
import haxe.macro.TypeTools;
import sys.io.File;
import haxe.macro.ExprTools;
import haxe.macro.Context;
import haxe.macro.Expr.Field;

/**
 * Vue构造器
 */
class VueBuilder {
	/**
	 * CSS列表
	 */
	@:persistent public static var css:Map<String, String> = [];

	/**
	 * 是否指定目标HTML文件，指定后，则不使用haxelib中的html文件
	 */
	@:persistent public static var mainHtmlFile:String;

	/**
	 * 待拷贝的资源
	 */
	@:persistent public static var assets:Array<{
		assets:String,
		rename:String
	}> = [];

	@:persistent public static var requires:Array<{
		url:String
	}> = [];

	macro public static function build():Array<Field> {
		var list = Context.getBuildFields();
		var classType = Context.getLocalClass();
		var classFunc = classType.get().meta.get();
		var templateContext:String = null;
		var styleContext:String = null;
		for (item in classFunc) {
			switch (item.name) {
				case ":require":
					requires.push({
						url: ExprTools.getValue(item.params[0])
					});
				case ":assets", ":a":
					// 资源拷贝
					var copyFile:String = ExprTools.getValue(item.params[0]);
					var copyToFile:String = ExprTools.getValue(item.params[1]);
					assets.push({
						assets: copyFile,
						rename: copyToFile
					});
				case ":includeFile":
					var copyFile:String = ExprTools.getValue(item.params[0]);
					var files = copyFile.split("/");
					if (FileSystem.isDirectory(copyFile)) {
						Compiler.copyFile(copyFile, "./bin/" + copyFile.substr(copyFile.lastIndexOf("/") + 1));
					} else {
						Compiler.copyFile(copyFile, "./bin");
					}
				case ":mainHtml":
					// 指定HTML入口文件
					if (mainHtmlFile == null) {
						mainHtmlFile = ExprTools.getValue(item.params[0]);
					}
				case ":template", ":t":
					// Vue模板数据
					var templateFile = ExprTools.getValue(item.params[0]);
					templateContext = File.getContent(templateFile);
				// 这里需要解析引入关系
				// trace(html);
				case ":style", ":s":
					// Css样式绑定
					var styleFile = ExprTools.getValue(item.params[0]);
					styleContext = File.getContent(styleFile);
					styleContext = StringTools.replace(styleContext, "\n", "");
					styleContext = StringTools.replace(styleContext, "\r", "");
					css.set(styleFile, styleContext);
			}
		}
		// 模板存在的时候下，需要定义模板参数
		if (templateContext != null) {
			var templateField:Field = {
				name: "template",
				access: [APublic],
				kind: FVar(macro :String, macro $v{templateContext}),
				pos: Context.currentPos()
			};
			list.push(templateField);
		}
		// 将所有公开的方法，添加到methods中
		var methods:Array<String> = [];
		for (func in list) {
			switch func.kind {
				case FFun(f):
					// 方法指向
					if (func.name != "new" && func.access.contains(APublic) && !func.access.contains(AStatic)) {
						methods.push(func.name);
					} else if (func.name == "data") {
						switch f.expr.expr {
							case EBlock(exprs):
								var ret = exprs[exprs.length - 1];
								switch ret.expr {
									case EReturn(e):
										switch e.expr {
											case EObjectDecl(fields):
												// 这里必须是一个Object
												for (field in fields) {
													var methodsField:Field = {
														name: field.field,
														access: [APublic],
														kind: FVar(macro :Dynamic),
														pos: Context.currentPos()
													};
													list.push(methodsField);
												}
											default:
												throw "暂不支持" + f.expr.expr + "结构";
										}
									default:
										throw "暂不支持" + f.expr.expr + "结构";
								}
							default:
								throw "暂不支持" + f.expr.expr + "结构";
						}
					}
				default:
					// 忽略
			}
		}
		var methodsField:Field = {
			name: "methodsKeys",
			access: [APublic],
			kind: FVar(macro :Dynamic, macro $v{methods}),
			pos: Context.currentPos()
		};
		list.push(methodsField);

		// 新增一个静态的create方法，这个方法会自动返回Vue对象
		var carray = Context.getLocalClass().toString().split(".");
		var c:TypePath = {
			pack: carray.splice(0, carray.length - 1),
			name: carray[carray.length - 1]
		}
		var createField:Field = {
			name: "createApp",
			access: [APublic, AStatic],
			kind: FFun({
				args: [],
				expr: macro {
					var selfApp = vue3.Vue.createApp(new $c());
					app = selfApp;
					return selfApp;
				},
				ret: macro :vue3.Vue
			}),
			pos: Context.currentPos()
		};
		list.push(createField);
		// 并可以通过单例app访问
		var appField:Field = {
			name: "app",
			access: [APublic, AStatic],
			kind: FVar(macro :vue3.Vue),
			pos: Context.currentPos()
		};
		list.push(appField);

		// 允许自身带一个unmount的接口，来释放自已
		var unmountField:Field = {
			name: "unmount",
			access: [APublic],
			kind: FFun({
				args: [],
				expr: macro {
					if (app != null) {
						app.unmount();
						app = null;
					}
				}
			}),
			pos: Context.currentPos()
		};
		list.push(unmountField);
		return list;
	}
}
#end
