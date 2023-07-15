package vue3.macro.platforms;

import vue3.macro.utils.Project;

interface IPlatform {
	public function build(project:Project):Void;
}
