/* 
 PureMVC AS2 Unit Tests Ported by James Knight <james.knight@puremvc.org>  
 PureMVC - Copyright(c) 2006, 2007 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
import org.puremvc.as2.core.*;
import org.puremvc.as2.interfaces.IController;
import org.puremvc.as2.patterns.command.MockSimpleCommand;
import org.puremvc.as2.patterns.observer.Notification;
import org.puremvc.as2.patterns.proxy.MockVO;

class org.puremvc.as2.core.ControllerTest extends com.asunit.framework.TestCase {

	private var className:String = "org.puremvc.as2.core.ControllerTest";

	/**
	 * Tests the Controller Singleton Factory Method 
	 */
	public function testGetInstance():Void {
		
		// Test Factory Method
		var controller:IController = Controller.getInstance();
		
		// test assertions
		assertTrue( "Expecting instance not null", controller != null );
		assertTrue( "Expecting instance implements IController", controller instanceof IController);
		
		var secondController:IController = Controller.getInstance();
		assertSame("two controller variable should point to the same object", controller, secondController);
	}

	/**
	 * Tests Command registration and execution.
	 * 
	 * This test gets the Singleton Controller instance 
	 * and registers the MockCommand class 
	 * to handle 'ControllerTest' Notifications.<P>
	 * 
	 * It then constructs such a Notification and tells the 
	 * Controller to execute the associated Command.
	 * Success is determined by evaluating a property
	 * on an object passed to the Command, which will
	 * be modified when the Command executes.</P>
	 * 
	 */
	public function testRegisterAndExecuteCommand():Void {
		
		// Create the controller, register the MockCommand to handle 'ControllerTest' notes
		var controller:IController = Controller.getInstance();
		controller.registerCommand('ControllerTest', MockSimpleCommand);
		
		// Create a 'ControllerTest' note
		var vo:Object = new MockVO( 12 );
		var note:Notification = new Notification( 'ControllerTest', vo );

		// Tell the controller to execute the Command associated with the note
		// the ControllerTestCommand invoked will multiply the vo.input value
		// by 2 and set the result on vo.result
		controller.executeCommand(note);
		
		// test assertions 
		assertTrue( "Expecting vo.result == 24", vo.result == 24 );
	}
	
	/**
	 * Tests Command registration and removal.
	 * 
	 * <P>
	 * Tests that once a Command is registered and verified
	 * working, it can be removed from the Controller.</P>
	 */
	public function testRegisterAndRemoveCommand():Void {
		
		// Create the controller, register the MockCommand to handle 'ControllerTest' notes
		var controller:IController = Controller.getInstance();
		controller.registerCommand('ControllerRemoveTest', MockSimpleCommand);
		
		// Create a 'ControllerTest' note
		var vo:Object = new MockVO( 12 );
		var note:Notification = new Notification( 'ControllerRemoveTest', vo );

		// Tell the controller to execute the Command associated with the note
		// the ControllerTestCommand invoked will multiply the vo.input value
		// by 2 and set the result on vo.result
		controller.executeCommand(note);
		
		// test assertions 
		assertTrue( "Expecting vo.result == 24", vo.result == 24 );
		
		// Reset result
		vo.result = 0;
		
		// Remove the Command from the Controller
		controller.removeCommand('ControllerRemoveTest');
		
		// Tell the controller to execute the Command associated with the
		// note. This time, it should not be registered, and our vo result
		// will not change   			
		controller.executeCommand(note);
		
		// test assertions 
		assertTrue( "Expecting vo.result == 0", vo.result == 0 );
	}
  		
	/**
	 * Test hasCommand method.
	 */
	public function testHasCommand():Void {
		
		// register the MockCommand to handle 'hasCommandTest' notes
		var controller:IController = Controller.getInstance();
		controller.registerCommand('hasCommandTest', MockSimpleCommand);
		
		// test that hasCommand returns true for hasCommandTest notifications 
		assertTrue( "Expecting controller.hasCommand('hasCommandTest') == true", controller.hasCommand('hasCommandTest') == true );
		
		// Remove the Command from the Controller
		controller.removeCommand('hasCommandTest');
		
		// test that hasCommand returns false for hasCommandTest notifications 
		assertTrue( "Expecting controller.hasCommand('hasCommandTest') == false", controller.hasCommand('hasCommandTest') == false );
	}
	
}
