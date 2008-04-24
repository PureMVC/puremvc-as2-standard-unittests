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
	 * Tests the Controller Singleton Factory Method, ensuring
	 * that all instantiated controller variables point to the same single Controller 
	 */
	public function testGetInstance():Void {
		
		// Test Factory Method
		var controller:IController = Controller.getInstance();
		
		// test assertions
		assertNotNull( "Expecting instance not null", controller);
		assertTrue( "Expecting instance implements IController", controller instanceof IController);
		
		var secondController:IController = Controller.getInstance();
		assertSame("two controller variables should point to the same object", controller, secondController);
	}

	/**
	 * Tests Command registration and execution.
	 * 
	 * This registers a MockCommand object with a Controller instance 
	 * to handle 'ControllerTest' Notifications.
	 * 
	 * It then constructs such a Notification and tells the Controller 
	 * to execute the associated Command. Success is determined by 
	 * evaluating a property on an object passed to the Command, which 
	 * will be modified when the Command executes.
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
		// which will multiply the vo.input value by 2 and store the result in vo.result
		controller.executeCommand(note);
		
		// test assertions 
		assertEquals( "Expecting vo.result == 24", 24, vo.result );
	}
	
	/**
	 * Tests Command registration and removal.
	 * 
	 * Tests that once a Command is registered and verified
	 * working, it can be removed from the Controller.
	 */
	public function testRegisterAndRemoveCommand():Void {
		
		// Create the controller, register the MockCommand to handle 'ControllerTest' notes
		var controller:IController = Controller.getInstance();
		controller.registerCommand('ControllerRemoveTest', MockSimpleCommand);
		
		// Create a 'ControllerTest' note
		var vo:Object = new MockVO( 12 );
		var note:Notification = new Notification( 'ControllerRemoveTest', vo );

		// Tell the controller to execute the Command associated with the note
		// which will multiply the vo.input value by 2 and set the result on vo.result
		controller.executeCommand(note);
		
		// test assertions 
		assertEquals( "Expecting vo.result == 24", 24, vo.result );
		
		// Reset result
		vo.result = 0;
		
		// Remove the Command from the Controller
		controller.removeCommand('ControllerRemoveTest');
		
		// Tell the controller to execute the Command associated with the
		// note. This time, it should not be registered, and our vo result
		// will not change   			
		controller.executeCommand(note);
		
		// test assertions 
		assertEquals( "Expecting vo.result == 24", 0, vo.result );
	}
  		
	/**
	 * Test hasCommand method.
	 */
	public function testHasCommand():Void {
		
		// test that hasCommand returns true for hasCommandTest notifications 
		assertFalse( "Before registering Command, expecting controller.hasCommand('hasCommandTest') == false", controller.hasCommand('hasCommandTest'));
		
		// register the MockCommand to handle 'hasCommandTest' notes
		var controller:IController = Controller.getInstance();
		controller.registerCommand('hasCommandTest', MockSimpleCommand);
		
		// test that hasCommand returns true for hasCommandTest notifications 
		assertTrue( "Expecting controller.hasCommand('hasCommandTest') == true", controller.hasCommand('hasCommandTest'));
		
		// Remove the Command from the Controller
		controller.removeCommand('hasCommandTest');
		
		// test that hasCommand returns false for hasCommandTest notifications 
		assertFalse( "Expecting controller.hasCommand('hasCommandTest') == false", controller.hasCommand('hasCommandTest'));
	}
	
}
