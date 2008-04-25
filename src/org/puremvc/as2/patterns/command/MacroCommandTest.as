/* 
 PureMVC AS2 Unit Tests Ported by James Knight <james.knight@puremvc.org>  
 PureMVC - Copyright(c) 2006, 2007 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
import org.puremvc.as2.interfaces.*;
import org.puremvc.as2.patterns.command.MacroCommand;
import org.puremvc.as2.patterns.command.MockMacroCommand;
import org.puremvc.as2.patterns.observer.Notification;
import org.puremvc.as2.patterns.proxy.MockVO;

class org.puremvc.as2.patterns.command.MacroCommandTest extends asunit.framework.TestCase {
	
	private var className:String = "org.puremvc.as2.patterns.command.MacroCommandTest";
	private var instance:MacroCommand;

	public function MacroCommandTest(testMethod:String) {
		super(testMethod);
	}

	public function setUp():Void {
		instance = new MacroCommand();
	}

	public function tearDown():Void {
		delete instance;
 	}

 	public function testInstantiated():Void {
		assertTrue("MacroCommand instantiated", instance instanceof MacroCommand);
	}
	
/**
 * Tests operation of a {@code MacroCommand}.
	 * 
	 * This test creates a new {@link Notification}, adding a 
	 * {@link MacroCommandTestVO} as the body. 
	 * It then creates a {@link MockMacroCommand} and invokes
	 * its {@link #execute} method, passing in the 
	 * {@link Notification}.
	 * 
	 * The {@code MockMacroCommand} has defined an
	 * {@link MockMacroCommand#initializeMacroCommand} method, which is 
	 * called automatically by its constructor. In this method
	 * the {@code MockMacroCommand} adds 2 {@link MockSimpleCommand} objects
	 * to itself.
	 * 
	 * The {@code MacroCommandTestVO} has 2 result properties,
	 * one is set by one {@code MockSimpleCommand} multiplying 
	 * the input property by 2, and the other is set
	 * by the other {@code MockSimpleCommand} multiplying
	 * the input property by itself. 
	 * 
	 * Success is determined by evaluating the 2 result properties
	 * on the {@code MacroCommandTestVO} that was passed to 
	 * the {@code MockMacroCommand} on the Notification 
	 * body.
	 * 
	 */
	public function testMacroCommandExecute():Void {
		
		// Create the VO
		var vo:MockVO = new MockVO(5);
		
		// Create the Notification (note)
		var note:INotification = new Notification('MacroCommandTest', vo);

		// Create the SimpleCommand  			
		var command:MockMacroCommand = new MockMacroCommand();
		
		// Execute the SimpleCommand
		command.execute(note);
		
		// test assertions
		assertTrue( "Expecting vo.result1 == 10", vo.result1 == 10 );
		assertTrue( "Expecting vo.result2 == 25", vo.result2 == 25 );
		
	}

}
