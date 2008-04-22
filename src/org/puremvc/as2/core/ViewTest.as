/* 
 PureMVC AS2 Unit Tests Ported by James Knight <james.knight@puremvc.org>  
 PureMVC - Copyright(c) 2006, 2007 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
import org.puremvc.as2.core.View;
import org.puremvc.as2.interfaces.IMediator;
import org.puremvc.as2.interfaces.INotification;
import org.puremvc.as2.interfaces.IView;
import org.puremvc.as2.patterns.mediator.Mediator;
import org.puremvc.as2.patterns.mediator.MockMediator;
import org.puremvc.as2.patterns.observer.MockNotification;
import org.puremvc.as2.patterns.observer.Notification;
import org.puremvc.as2.patterns.observer.Observer;

class org.puremvc.as2.core.ViewTest extends com.asunit.framework.TestCase {

	private var className:String = "org.puremvc.as2.core.ViewTest";

	public var lastNotification:String;	
	public var onRegisterCalled:Boolean;
	public var onRemoveCalled:Boolean;

	public static var NOTE1:String = "Notification1";
	public static var NOTE2:String = "Notification2";
	public static var NOTE3:String = "Notification3";

	public function setUp():Void {
		onRegisterCalled = false;
		onRemoveCalled = false;
	}

	public function tearDown():Void {
		View.getInstance().removeMediator(MockMediator.NAME);
		View.getInstance().removeMediator("note3Mediator");
		onRegisterCalled = false;
		onRemoveCalled = false;
	}

	/**
	 * Tests the View Singleton Factory Method 
	 */
	public function testGetInstance():Void {
		
		// Test Factory Method
		var view:IView = View.getInstance();
		
		// test assertions
		assertTrue("Expecting instance not null", view != null);
		assertTrue("Expecting instance implements IView", view instanceof IView);
		
		assertSame("2 variables for View point to the same object in memory", view, View.getInstance());
	}
	
	/**
	 * Tests registration and notification of Observers.
	 * 
	 * An Observer is created to callback the viewTestMethod of
	 * this ViewTest instance. This Observer is registered with
	 * the View to be notified of 'ViewTestEvent' events. Such
	 * an event is created, and a value set on its payload. Then
	 * the View is told to notify interested observers of this
	 * Event. 
	 * 
	 * The View calls the Observer's notifyObserver method
	 * which calls the viewTestMethod on this instance
	 * of the ViewTest class. The viewTestMethod method will set 
	 * an instance variable to the value passed in on the Event
	 * payload. We evaluate the instance variable to be sure
	 * it is the same as that passed out as the payload of the 
	 * original 'ViewTestEvent'.
	 * 
	 */
	public function testRegisterAndNotifyObserver():Void {
		
		// Get the Singleton View instance
		var view:IView = View.getInstance();
		
		// Create observer, passing in notification method and context
		var observer:Observer = new Observer(viewTestMethod, this);
		
		// Register Observer's interest in a particular Notification with the View 
		view.registerObserver(MockNotification.NAME, observer);
		
		// Create a MockNotification, setting 
		// a body value, and tell the View to notify 
		// Observers. Since the Observer is this class 
		// and the notification method is viewTestMethod,
		// successful notification will result in our local 
		// viewTestVar being set to the value we pass in 
		// on the note body.
		var note:INotification = MockNotification.create(10);
		view.notifyObservers(note);
	}

	/**
	 * A utility method to test the notification of Observers by the view
	 */
	private function viewTestMethod( note:INotification ):Void {
		// set the local viewTestVar to the number on the event payload
		// test assertions  			
		assertTrue("Expecting viewTestVar = 10", Number(note.getBody()) == 10);
	}	
	
	/**
	 * Tests registering and retrieving a mediator with
	 * the View.
	 */
	public function testRegisterAndRetrieveMediator():Void {
		
		// Get the Singleton View instance
		var view:IView = View.getInstance();

		// Create and register the test mediator
		var mock:IMediator = IMediator(new MockMediator(this));
		view.registerMediator(mock);
		
		// Retrieve the component
		var mediator:IMediator = IMediator(view.retrieveMediator(MockMediator.NAME));
		
		// test assertions  			
		assertTrue("Expecting retrieved Mediator is MockMediator", mediator == mock);
	}

	/**
	 * Tests the hasMediator Method
	 */
	public function testHasMediator():Void {
  			
		// register a Mediator
		var view:IView = View.getInstance();
			
		// Create and register the test mediator
		var mediator:Mediator = new Mediator('hasMediatorTest', this);
		view.registerMediator(mediator);
			
		// assert that the view.hasMediator method returns true
		// for that mediator name
		assertTrue("Expecting view.hasMediator('hasMediatorTest') == true", view.hasMediator('hasMediatorTest') == true);

		view.removeMediator('hasMediatorTest');
			
		// assert that the view.hasMediator method returns false
		// for that mediator name
		assertTrue("Expecting view.hasMediator('hasMediatorTest') == false", view.hasMediator('hasMediatorTest') == false);
	}

	/**
	 * Tests registering and removing a mediator 
	 */
	public function testRegisterAndRemoveMediator():Void {
			
		// Get the Singleton View instance
		var view:IView = View.getInstance();

		// Create and register the test mediator
		var mediator:IMediator = new Mediator('testing', this);
		view.registerMediator(mediator);
			
		// Remove the component
		var removedMediator:IMediator = IMediator(view.removeMediator('testing'));
			
		// assert that we have removed the appropriate mediator
		assertTrue("Expecting removedMediator.getMediatorName() == 'testing'", removedMediator.getMediatorName() == 'testing');
				
		// assert that the mediator is no longer retrievable
		assertTrue("Expecting view.retrieveMediator( 'testing' ) == null )", view.retrieveMediator('testing') == null);
	}

	/**
	 * Test that the View calls the onRegister and onRemove methods
	 */
	public function testOnRegisterAndOnRemove():Void {
			
		// Get the Singleton View instance
		var view:IView = View.getInstance();
			
		// just check that our variables are set correctly before starting
		assertFalse("prior to testing, onRegisterCalled should be false", onRegisterCalled);
		assertFalse("prior to testing, onRemoveCalled should be false", onRemoveCalled);
			
		// Create and register the test mediator
		var mediator:IMediator = new MockMediator(this);
		view.registerMediator(mediator);

		// assert that onRegister was called, and the mediator responded by setting our boolean
		assertTrue("Expecting onRegisterCalled == true", onRegisterCalled);
			
		// Remove the component
		IMediator(view.removeMediator(MockMediator.NAME));
			
		// assert that the mediator is no longer retrievable
		assertTrue("Expecting onRemoveCalled == true", onRemoveCalled);
	}

	/**
	 * Tests successive register and remove of same mediator.
	 */
	public function testSuccessiveRegisterAndRemoveMediator():Void {
		
		// Get the Singleton View instance
		var view:IView = View.getInstance();

		// Create and register the test mediator, 
		// but not so we have a reference to it
		view.registerMediator(new MockMediator(this));
		
		// test that we can retrieve it
		assertTrue("Expecting view.retrieveMediator( MockMediator.NAME ) is MockMediator", view.retrieveMediator(MockMediator.NAME) instanceof MockMediator);

		// Remove the Mediator
		view.removeMediator(MockMediator.NAME);

		// test that retrieving it now returns null			
		assertTrue("Expecting view.retrieveMediator( MockMediator.NAME ) == null", view.retrieveMediator(MockMediator.NAME) == null);

		// test that removing the mediator again once its gone doesn't cause crash 		
		assertTrue("Expecting view.removeMediator( MockMediator.NAME ) doesn't crash", view.removeMediator(MockMediator.NAME) == null);

		// Create and register another instance of the test mediator, 
		view.registerMediator(new MockMediator(this));
		
		assertTrue("Expecting view.retrieveMediator( MockMediator.NAME ) is MockMediator", view.retrieveMediator(MockMediator.NAME) instanceof MockMediator);

		// Remove the Mediator
		view.removeMediator(MockMediator.NAME);
		
		// test that retrieving it now returns null			
		assertTrue("Expecting view.retrieveMediator( MockMediator.NAME ) == null", view.retrieveMediator(MockMediator.NAME) == null);
	}

	
	/**
	 * Tests registering a Mediator for 2 different notifications, removing the
	 * Mediator from the View, and seeing that neither notification causes the
	 * Mediator to be notified.
	 */
	public function testRemoveMediatorAndSubsequentNotify():Void {
		
		// Get the Singleton View instance
		var view:IView = View.getInstance();
		
		// Create and register the test mediator to be removed.
		view.registerMediator(new MockMediator(this, [ViewTest.NOTE1, ViewTest.NOTE2]));
		
		// test that notifications work
		view.notifyObservers(new Notification(NOTE1));
		assertTrue("Expecting lastNotification == NOTE1", lastNotification == NOTE1);

		view.notifyObservers(new Notification(NOTE2));
		assertTrue("Expecting lastNotification == NOTE2", lastNotification == NOTE2);

		// Remove the Mediator
		view.removeMediator(MockMediator.NAME);

		// test that retrieving it now returns null			
		assertTrue("Expecting view.retrieveMediator( MockMediator.NAME ) == null", view.retrieveMediator(MockMediator.NAME) == null);

		// test that notifications no longer work
		lastNotification = null;
		
		view.notifyObservers(new Notification(NOTE1));
		assertTrue("Expecting lastNotification != NOTE1", lastNotification != NOTE1);

		view.notifyObservers(new Notification(NOTE2));
		assertTrue("Expecting lastNotification != NOTE2", lastNotification != NOTE2);
	}

	/**
	 * Tests registering one of two registered Mediators and seeing
	 * that the remaining one still responds.
	 */
	public function testRemoveOneOfTwoMediatorsAndSubsequentNotify():Void {
		
		// Get the Singleton View instance
		var view:IView = View.getInstance();
		
		// Create and register that responds to notifications 1 and 2
		view.registerMediator(new MockMediator(this, [ViewTest.NOTE1, ViewTest.NOTE2]));
		
		// Create and register that responds to notification 3
		view.registerMediator(new MockMediator(this, [ViewTest.NOTE3], "note3Mediator"));
		
		// test that all notifications work
		view.notifyObservers(new Notification(NOTE1));
		assertTrue("Expecting lastNotification == NOTE1", lastNotification == NOTE1);

		view.notifyObservers(new Notification(NOTE2));
		assertTrue("Expecting lastNotification == NOTE2", lastNotification == NOTE2);

		view.notifyObservers(new Notification(NOTE3));
		assertTrue("Expecting lastNotification == NOTE3", lastNotification == NOTE3);
				
		// Remove the Mediator that responds to 1 and 2
		view.removeMediator(MockMediator.NAME);

		// test that retrieving it now returns null			
		assertTrue("Expecting view.retrieveMediator( MockMediator.NAME ) == null", view.retrieveMediator(MockMediator.NAME) == null);

		// test that notifications no longer work
		// for notifications 1 and 2, but still work for 3
		lastNotification = null;
		
		view.notifyObservers(new Notification(NOTE1));
		assertTrue("Expecting lastNotification != NOTE1", lastNotification != NOTE1);

		view.notifyObservers(new Notification(NOTE2));
		assertTrue("Expecting lastNotification != NOTE2", lastNotification != NOTE2);

		view.notifyObservers(new Notification(NOTE3));
		assertTrue("Expecting lastNotification == NOTE3", lastNotification == NOTE3);
	}
}
