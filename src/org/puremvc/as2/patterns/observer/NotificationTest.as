/* 
 PureMVC AS2 Unit Tests Ported by James Knight <james.knight@puremvc.org>  
 PureMVC - Copyright(c) 2006, 2007 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
import org.puremvc.as2.interfaces.*;
import org.puremvc.as2.patterns.observer.Notification;

class org.puremvc.as2.patterns.observer.NotificationTest extends asunit.framework.TestCase {
	
	private var className:String = "org.puremvc.as2.patterns.observer.NotificationTest";
	private var instance:Notification;

	
	public function NotificationTest(testMethod:String) {
		super(testMethod);
	}

	/**
	 * Tests setting and getting the name using Notification class accessor methods.
	 */
	public function testNameAccessors():Void {

		// Create a new Notification and use accessors to set the note name 
		var note:INotification = new Notification('TestNote');
		
		// test assertions
		assertTrue("Expecting note.getName() == 'TestNote'", note.getName() == 'TestNote');
	}
	
	/**
	 * Tests setting and getting the body using Notification class accessor methods.
	 */
	public function testBodyAccessors():Void {

		// Create a new Notification and use accessors to set the body
		var note:INotification = new Notification(null);
		note.setBody(5);
		
		// test assertions
		assertTrue("Expecting note.getBody()as Number == 5", Number(note.getBody()) == 5);
	}
	
	
	/**
	 * Tests setting and getting the type using Notification class accessor methods.
	 */
	public function testTypeAccessors():Void {
		
		var type:String = "testType";
		
		// Create a new Notification and use accessors to set the body
		var note:INotification = new Notification(null);
		note.setType(type);
		
		// test assertions
		assertTrue("Expecting note.getType()as 'testType'", note.getType() == type);
	}

	/**
	 * Tests setting the name and body using the Notification class Constructor.
	 */
	public function testConstructor():Void {

		// Create a new Notification using the Constructor to set the note name and body
		var note:INotification = new Notification('TestNote', 5, 'TestNoteType');
		
		// test assertions
		assertTrue("Expecting note.getName() == 'TestNote'", note.getName() == 'TestNote');
		assertTrue("Expecting note.getBody()as Number == 5", Number(note.getBody()) == 5);
		assertTrue("Expecting note.getType() == 'TestNoteType'", note.getType() == 'TestNoteType');
	}

}
