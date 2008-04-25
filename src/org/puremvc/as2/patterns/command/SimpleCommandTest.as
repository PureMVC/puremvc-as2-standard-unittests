/* 
 PureMVC AS2 Unit Tests Ported by James Knight <james.knight@puremvc.org>  
 PureMVC - Copyright(c) 2006, 2007 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
import org.puremvc.as2.patterns.command.MockSimpleCommand;
import org.puremvc.as2.patterns.command.SimpleCommand;
import org.puremvc.as2.patterns.observer.*;
import org.puremvc.as2.patterns.proxy.MockVO;

class org.puremvc.as2.patterns.command.SimpleCommandTest extends asunit.framework.TestCase {

	private var className:String = "org.puremvc.as2.patterns.command.SimpleCommandTest";
	private var instance:SimpleCommand;

	public function SimpleCommandTest(testMethod:String) {
		super(testMethod);
	}

	public function setUp():Void {
		instance = new SimpleCommand();
	}

	public function tearDown():Void {
		delete instance;
 	}

 	public function testInstantiated():Void {
		assertTrue("SimpleCommand instantiated", instance instanceof SimpleCommand);
	}
  		
	/**
	 * Tests the {@code execute} method of a {@link SimpleCommand}.
	 * 
	 * This test creates a new {@link Notification}, adding a 
	 * {@link MockVO} as the body. 
	 * It then creates a {@link SimpleMockCommand} and invokes
	 * its {@code execute} method, passing in the note.
	 * 
	 * Success is determined by evaluating a property on the 
	 * object that was passed on the Notification body, which will
	 * be modified by the SimpleCommand.
	 * 
	 */
	public function testSimpleCommandExecute():Void {
		
		var vo:MockVO = new MockVO(5);
		var note:Notification = new Notification('SimpleCommandTestNote', vo);
		var command:MockSimpleCommand = new MockSimpleCommand();
		command.execute(note);
		
		// test assertions
		assertTrue( "Expecting vo.result == 10", vo.result == 10 );		
	}
	
}
