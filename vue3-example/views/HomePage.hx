package views;

import vue3.VueComponent;

@:t("html/homepage.html")
class HomePage extends VueComponent {
	override function data():Dynamic {
		return {
			timelines: [
				{
					time: "2023",
					type: "primary",
					title: "旅程继续",
					content: "ZYGameUI提供了稳健的跨平台开发流程，简化各个渠道的生成流程。",
					link: [
						{
							name: "Github开源库",
							url: "https://github.com/zygameui/zygameui"
						},
						{
							name: "OpenFL分支开源库",
							url: "https://github.com/zygameui/openfl"
						},
						{
							name: "Lime分支开源库",
							url: "https://github.com/zygameui/lime"
						}
					]
				},
				{
					time: "2018",
					title: "初始",
					content: "由Haxe+OpenFL+Lime支持的跨平台2D游戏引擎。于2018年创建，并投入开发项目使用。经过多个版本的维护，当前版本已满足绝大部分游戏开发需求，拥有核心组件以及小游戏驱动良好支持。"
				}
			]
		}
	}
}
