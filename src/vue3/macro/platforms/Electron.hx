package vue3.macro.platforms;

import vue3.macro.utils.FileTools;
import vue3.macro.utils.Project;

/**
 * Electron目标编译流程
 */
class Electron extends BasePlatform {
	override public function build(project:Project) {
		// 开始编译处理
		trace("Electron target compiler...");
		FileTools.copyTemplatesDir(project.getHxvue3DirPath("templates/electron"), project.getOutputTempDir(), project);
		// 编译Electron目标
		Sys.setCwd(project.getOutputTempDir());
		Sys.command("haxe build.hxml");
		Sys.setCwd(project.compilerCwd);
		// 拷贝makefile
		FileTools.saveTemplateFile(project.getHxvue3DirPath("templates/electron/makefile"), project.outputDir, project);
		// 清空缓存文件
		FileTools.removeDir(project.getOutputTempDir());
	}
}
