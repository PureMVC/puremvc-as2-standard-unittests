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

class org.puremvc.as2.patterns.command.MacroCommandTest extends com.asunit.framework.TestCase {
	
	private var className:String = "org.puremvc.as2.patterns.command.MacroCommandTest";
	private var instance:MacroCommand;

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
 * Tests operation of a <code>MacroCommand</code>.
	 * 
	 * <P>
	 * This test creates a new <code>Notification</code>, adding a 
	 * <code>MacroCommandTestVO</code> as the body. 
	 * It then creates a <code>MockMacroCommand</code> and invokes
	 * its <code>execute</code> method, passing in the 
	 * <code>Notification</code>.<P>
	 * 
	 * <P>
	 * The <code>MockMacroCommand</code> has defined an
	 * <code>initializeMacroCommand</code> method, which is 
	 * called automatically by its constructor. In this method
	 * the <code>MockMacroCommand</code> adds 2 SubCommands
	 * to itself, <code>MacroCommandTestSub1Command</code> and
	 * <code>MacroCommandTestSub2Command</code>.
	 * 
	 * <P>
	 * The <code>MacroCommandTestVO</code> has 2 result properties,
	 * one is set by <code>MacroCommandTestSub1Command</code> by
	 * multiplying the input property by 2, and the other is set
	 * by <code>MacroCommandTestSub2Command</code> by multiplying
	 * the input property by itself. 
	 * 
	 * <P>
	 * Success is determined by evaluating the 2 result properties
	 * on the <code>MacroCommandTestVO</code> that was passed to 
	 * the <code>MockMacroCommand</code> on the Notification 
	 * body.</P>
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
