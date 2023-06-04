package vue3.macro;

import haxe.macro.TypedExprTools;
import haxe.macro.TypeTools;
#if macro
import sys.io.File;
import haxe.macro.ExprTools;
import haxe.macro.Context;
import haxe.macro.Expr.Field;

/**
 * Vue构造器
 */
class VueBuilder {
	macro public static function build():Array<Field> {
		trace("Vue building");
		var list = Context.getBuildFields();
		var classType = Context.getLocalClass();
		var classFunc = classType.get().meta.get();
		var templateContext:String = null;
		for (item in classFunc) {
			if (item.name == ":template" || item.name == ":t") {
				// Vue模板数据
				var templateFile = ExprTools.getValue(item.params[0]);
				templateContext = File.getContent(templateFile);
				trace("模版内容：", templateContext);
			}
		}
		if (templateContext != null) {
			// 模板存在的时候下，需要定义模板参数
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
					if (func.name != "new" && func.access.contains(APublic)) {
						methods.push(func.name);
					} else if (func.name == "data") {
						switch f.expr.expr {
							case EBlock(exprs):
								var ret = exprs[exprs.length - 1];
								switch ret.expr {
									case EReturn(e):
										trace(e.expr);
										switch e.expr {
											case EObjectDecl(fields):
												// 这里必须是一个Object
												for (field in fields) {
													var methodsField:Field = {
														name: field.field,
														access: [APrivate],
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

		// 需要有一个静态的来访问app
		// var appField:Field = {
		// 	name: "app",
		// 	access: [APublic],
		// 	kind: FVar(macro :vue3.Vue),
		// 	pos: Context.currentPos()
		// };
		// list.push(appField);
		// 需要一个构造方法进行创建实例
		// var createFunc = function() {}
		// var createField:Field = {
		// 	name: "create",
		// 	access: [APublic],
		// 	kind: FFun({
		// 		args: [
		// 			{
		// 				name: "moundId",
		// 				type: macro :String
		// 			}
		// 		],
		// 		expr: macro {}
		// 	}),
		// 	pos: Context.currentPos()
		// }
		// list.push(createField);
		return list;
	}
}
#end
