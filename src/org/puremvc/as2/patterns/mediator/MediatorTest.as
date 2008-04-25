/* 
 PureMVC AS2 Unit Tests Ported by James Knight <james.knight@puremvc.org>  
 PureMVC - Copyright(c) 2006, 2007 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
import org.puremvc.as2.interfaces.IMediator;
import org.puremvc.as2.patterns.facade.Facade;
import org.puremvc.as2.patterns.mediator.Mediator;
import org.puremvc.as2.patterns.mediator.MockMediator;

class org.puremvc.as2.patterns.mediator.MediatorTest extends asunit.framework.TestCase {
	
	private var className:String = "org.puremvc.as2.patterns.mediator.MediatorTest";
	private var instance:Mediator;

	public function MediatorTest(testMethod:String) {
		super(testMethod);
	}

	public function setUp():Void {
		instance = new Mediator();
	}

	public function tearDown():Void {
		delete instance;
 	}

 	public function testInstantiated():Void {
		assertTrue("Mediator instantiated", instance instanceof Mediator);
	}
	
	/**
	 * Tests getting the name using Mediator class accessor method. 
	 */
	public function testNameAccessor():Void {

		// Create a new Mediator and use accessors to set the mediator name 
		var mediator:Mediator = new Mediator();
		
		// test assertions
		assertTrue("Expecting mediator.getMediatorName() == Mediator.NAME", mediator.getMediatorName() == Mediator.NAME);
	}

	/**
	 * Tests getting the name using Mediator class accessor method. 
	 */
	public function testViewAccessor():Void {

		// Create a view object
		var view:Object = new Object();
		
		// Create a new Proxy and use accessors to set the proxy name 
		var mediator:Mediator = new Mediator(Mediator.NAME, view);
					
		// test assertions
		assertNotNull("Expecting mediator.getViewComponent() not null", mediator.getViewComponent());
	}

	public function testListNotificationInterests():Void {
		// Create a view object
		var view:Object = new Object();
		var interests:Array = ["a", "b", "c"];
		// Create a new Proxy and use accessors to set the proxy name 
		var mediator:IMediator = new MockMediator(view, interests);
		
		assertTrue("MockMediator#listNotificationInterests() returns Array", mediator.listNotificationInterests() instanceof Array);		assertEquals("MockMediator#listNotificationInterests() returns ['a', 'b', 'c']", interests, mediator.listNotificationInterests());
	}
	
	public function testOnRegister():Void {
		var view:Object = new Object();
		var mediator:MockMediator = new MockMediator(view);
		
		assertFalse("before registration, MockMediator#onRegister has not been called", mediator.onRegisterCalled);
		
		Facade.getInstance().registerMediator(mediator);
		assertTrue("after registration, MockMediator#onRegister has been called", mediator.onRegisterCalled);
	}
	
	public function testOnRemove():Void {
		var view:Object = new Object();
		var mediator:MockMediator = new MockMediator(view);
		
		assertFalse("before registration, MockMediator#onRegister has not been called", mediator.onRemoveCalled);
		
		Facade.getInstance().registerMediator(mediator);
		assertFalse("after registration, MockMediator#onRegister has been called", mediator.onRemoveCalled);
		
		Facade.getInstance().removeMediator(MockMediator.NAME);
		assertTrue("after removal, MockMediator#onRemoved has been called", mediator.onRemoveCalled);
	}
}
