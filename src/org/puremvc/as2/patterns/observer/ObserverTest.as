/* 
 PureMVC AS2 Unit Tests Ported by James Knight <james.knight@puremvc.org>  
 PureMVC - Copyright(c) 2006, 2007 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
import org.puremvc.as2.interfaces.*;
import org.puremvc.as2.patterns.observer.*;

class org.puremvc.as2.patterns.observer.ObserverTest extends asunit.framework.TestCase {

	private var className:String = "org.puremvc.as2.patterns.observer.ObserverTest";
	private var instance:Observer;

	public function ObserverTest(testMethod:String) {
		super(testMethod);
	}

	public function setUp():Void {
		instance = new Observer();
	}

	public function tearDown():Void {
		delete instance;
 	}

 	public function testInstantiated():Void {
		assertTrue("Observer instantiated", instance instanceof Observer);
	}
	
	/**
	 * Tests observer class when initialized by accessor methods.
	 * 
	 */
	public function testObserverAccessors():Void {
		
		// Create observer with null args, then
		// use accessors to set notification method and context
		var observer:Observer = new Observer(null, null);
		observer.setNotifyContext(this);
		observer.setNotifyMethod(observerTestMethod);
		
		// create a test event, setting a payload value and notify 
		// the observer with it. since the observer is this class 
		// and the notification method is observerTestMethod,
		// successful notification will result in our local 
		// observerTestVar being set to the value we pass in 
		// on the note body.
		var note:Notification = new Notification('ObserverTestNote', 10);
		observer.notifyObserver(note);

		// test assertions  			
		assertTrue( "Expecting observerTestVar = 10", observerTestVar == 10 );
	}

	/**
	 * Tests observer class when initialized by constructor.
	 * 
	 */
	public function testObserverConstructor():Void {
		
		// Create observer passing in notification method and context
		var observer:Observer = new Observer(observerTestMethod,this);
		
		// create a test note, setting a body value and notify 
		// the observer with it. since the observer is this class 
		// and the notification method is observerTestMethod,
		// successful notification will result in our local 
		// observerTestVar being set to the value we pass in 
		// on the note body.
		var note:Notification = new Notification('ObserverTestNote', 5);
		observer.notifyObserver(note);

		// test assertions  			
		assertTrue( "Expecting observerTestVar = 5", observerTestVar == 5 );
	}
	
	/**
	 * Tests the compareNotifyContext method of the Observer class
	 * 
	 */
	public function testCompareNotifyContext():Void {
		
		// Create observer passing in notification method and context
		var observer:Observer = new Observer(observerTestMethod, this);
		
		var negTestObj:Object = new Object();
		
		// test assertions  			
		assertTrue("Expecting observer.compareNotifyContext(negTestObj) == false", observer.compareNotifyContext(negTestObj) == false);
		assertTrue("Expecting observer.compareNotifyContext(this) == true", observer.compareNotifyContext(this) == true);
	}




	/**
	 * A test variable that proves the notify method was
	 * executed with 'this' as its exectution context
	 */
	private var observerTestVar:Number;

	/**
	 * A function that is used as the observer notification
	 * method. It multiplies the input number by the 
	 * observerTestVar value
	 */
	private function observerTestMethod( note:INotification ):Void {
		observerTestVar = Number(note.getBody());
	}

}
