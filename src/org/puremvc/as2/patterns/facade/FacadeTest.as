/* 
 PureMVC AS2 Unit Tests Ported by James Knight <james.knight@puremvc.org>  
 PureMVC - Copyright(c) 2006, 2007 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
import org.puremvc.as2.interfaces.*;
import org.puremvc.as2.patterns.command.MockSimpleCommand;
import org.puremvc.as2.patterns.facade.Facade;
import org.puremvc.as2.patterns.mediator.Mediator;
import org.puremvc.as2.patterns.proxy.MockVO;
import org.puremvc.as2.patterns.proxy.Proxy;

class org.puremvc.as2.patterns.facade.FacadeTest extends asunit.framework.TestCase {
	
	private var className:String = "org.puremvc.as2.patterns.facade.FacadeTest";

	
	public function FacadeTest(testMethod:String) {
		super(testMethod);
	}

	/**
	 * Tests the Facade Singleton Factory Method 
	 */
	public function testGetInstance():Void {
		
		// Test Factory Method
		var facade:IFacade = Facade.getInstance();
		
		// test assertions
		assertTrue("Expecting instance not null", facade != null);
		assertTrue("Expecting instance implements IFacade", facade instanceof IFacade);
	}

	/**
	 * Tests Command registration and execution via the Facade.
	 * 
	 * This test gets the Singleton Facade instance 
	 * and registers the FacadeTestCommand class 
	 * to handle 'FacadeTest' Notifcations.
	 * 
	 * It then sends a notification using the Facade. 
	 * Success is determined by evaluating 
	 * a property on an object placed in the body of
	 * the Notification, which will be modified by the Command.
	 * 
	 */
	public function testRegisterCommandAndSendNotification():Void {
		
		// Create the Facade, register the FacadeTestCommand to 
		// handle 'FacadeTest' notifications
		var facade:IFacade = Facade.getInstance();
		facade.registerCommand('FacadeTestNote', MockSimpleCommand);		
		// Send notification. The Command associated with the event
		// (FacadeTestCommand) will be invoked, and will multiply 
		// the vo.input value by 2 and set the result on vo.result
		var vo:Object = new MockVO(32);
		facade.sendNotification('FacadeTestNote', vo);
		
		// test assertions 
		assertTrue("Expecting vo.result == 64", vo.result == 64);
	}
	
	/**
	 * Tests Command removal via the Facade.
	 * 
	 * This test gets the Singleton Facade instance 
	 * and registers the FacadeTestCommand class 
	 * to handle 'FacadeTest' Notifcations. Then it removes the command.
	 * 
	 * It then sends a Notification using the Facade. 
	 * Success is determined by evaluating 
	 * a property on an object placed in the body of
	 * the Notification, which will NOT be modified by the Command.
	 * 
	 */
	public function testRegisterAndRemoveCommandAndSendNotification():Void {
		
		// Create the Facade, register the FacadeTestCommand to 
		// handle 'FacadeTest' events
		var facade:IFacade = Facade.getInstance();
		facade.registerCommand('FacadeTestNote', MockSimpleCommand);
		facade.removeCommand('FacadeTestNote');
		

		// Send notification. The Command associated with the event
		// (FacadeTestCommand) will NOT be invoked, and will NOT multiply 
		// the vo.input value by 2 
		var vo:Object = new MockVO(32);
		facade.sendNotification('FacadeTestNote', vo);
		
		// test assertions 
		assertTrue( "Expecting vo.result != 64", vo.result != 64 );
	}
	
	/**
	 * Tests the regsitering and retrieving Model proxies via the Facade.
	 * 
	 * Tests {@code registerProxy} and {@code retrieveProxy} in the same test.
	 * These methods cannot currently be tested separately
	 * in any meaningful way other than to show that the
	 * methods do not throw exception when called.
	 */
	public function testRegisterAndRetrieveProxy():Void {
		
		// register a proxy and retrieve it.
		var facade:IFacade = Facade.getInstance();
		facade.registerProxy(new Proxy('colors', ['red', 'green', 'blue']));
		var proxy:Proxy = Proxy( facade.retrieveProxy('colors'));
		
		// test assertions
		assertTrue("Expecting proxy is IProxy", proxy instanceof IProxy);

		// retrieve data from proxy
		var data = proxy.getData();
		
		// test assertions
		assertNotNull("Expecting data not null", data);
		assertTrue("Expecting data is Array", data instanceof Array);
		assertTrue("Expecting data.length == 3", data.length == 3);
		assertTrue("Expecting data[0] == 'red'", data[0]  == 'red');
		assertTrue("Expecting data[1] == 'green'", data[1]  == 'green');
		assertTrue("Expecting data[2] == 'blue'", data[2]  == 'blue');
	}

	/**
	 * Tests the removing Proxies via the Facade.
	 */
	public function testRegisterAndRemoveProxy():Void {
		
		// register a proxy, remove it, then try to retrieve it
		var facade:IFacade = Facade.getInstance();
		var proxy:IProxy = new Proxy('sizes', ['7', '13', '21']);
		facade.registerProxy(proxy);
		
		// remove the proxy
		var removedProxy:IProxy = facade.removeProxy('sizes');

		// assert that we removed the appropriate proxy
		assertTrue("Expecting removedProxy.getProxyName() == 'sizes'", 
					removedProxy.getProxyName() == 'sizes');
		
		// make sure we can no longer retrieve the proxy from the model
		proxy = facade.retrieveProxy('sizes');
		
		// test assertions
		assertNull("Expecting proxy is null", proxy);
	}
   		
	/**
	 * Tests registering, retrieving and removing Mediators via the Facade.
	 */
	public function testRegisterRetrieveAndRemoveMediator():Void {
		
		// register a mediator, remove it, then try to retrieve it
		var facade:IFacade = Facade.getInstance();
		facade.registerMediator(new Mediator( Mediator.NAME, createEmptyMovieClip()));
		
		// retrieve the mediator
		assertNotNull("Expecting mediator is not null", facade.retrieveMediator(Mediator.NAME));

		// remove the mediator
		var removedMediator:IMediator = facade.removeMediator(Mediator.NAME);

		// assert that we have removed the appropriate mediator
		assertTrue("Expecting removedMediator.getMediatorName() == Mediator.NAME", 
					removedMediator.getMediatorName() == Mediator.NAME);
			
		// assert that the mediator is no longer retrievable
		assertTrue("Expecting facade.retrieveMediator( Mediator.NAME ) == null )", 
					facade.retrieveMediator(Mediator.NAME) == null);
								
	}
	
	/**
	 * Tests the hasProxy Method
	 */
	public function testHasProxy():Void {
		
		// register a Proxy
		var facade:IFacade = Facade.getInstance();
		facade.registerProxy(new Proxy('hasProxyTest', [1,2,3]));
		
		// assert that the model.hasProxy method returns true
		// for that proxy name
		assertTrue( "Expecting facade.hasProxy('hasProxyTest') == true", 
					facade.hasProxy('hasProxyTest') == true);
		
	}

	/**
	 * Tests the hasMediator Method
	 */
	public function testHasMediator():Void {
		
		// register a Mediator
		var facade:IFacade = Facade.getInstance();
		facade.registerMediator(new Mediator('facadeHasMediatorTest', createEmptyMovieClip()));
		
		// assert that the facade.hasMediator method returns true
		// for that mediator name
		assertTrue("Expecting facade.hasMediator('facadeHasMediatorTest') == true", 
					facade.hasMediator('facadeHasMediatorTest') == true);
					
		facade.removeMediator('facadeHasMediatorTest');
		
		// assert that the facade.hasMediator method returns false
		// for that mediator name
		assertTrue("Expecting facade.hasMediator('facadeHasMediatorTest') == false", 
					facade.hasMediator('facadeHasMediatorTest') == false);
		
	}

	/**
	 * Test hasCommand method.
	 */
	public function testHasCommand():Void {
		
		// register the ControllerTestCommand to handle 'hasCommandTest' notes
		var facade:IFacade = Facade.getInstance();
		facade.registerCommand('facadeHasCommandTest', MockSimpleCommand);
		
		// test that hasCommand returns true for hasCommandTest notifications 
		assertTrue("Expecting facade.hasCommand('facadeHasCommandTest') == true", facade.hasCommand('facadeHasCommandTest') == true);
		
		// Remove the Command from the Controller
		facade.removeCommand('facadeHasCommandTest');
		
		// test that hasCommand returns false for hasCommandTest notifications 
		assertTrue("Expecting facade.hasCommand('facadeHasCommandTest') == false", facade.hasCommand('facadeHasCommandTest') == false);
		
	}




}
