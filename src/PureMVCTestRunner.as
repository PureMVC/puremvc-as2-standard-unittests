import asunit.textui.TestRunner;

class PureMVCTestRunner extends TestRunner {

	public function PureMVCTestRunner() {
		fscommand("fullscreen", "true");
		start(AllTests);
	}

	public static function main():Void {
		var runner = new PureMVCTestRunner();
	}
}
