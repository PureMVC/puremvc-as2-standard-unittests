/* 
 PureMVC AS2 Unit Tests Ported by James Knight <james.knight@puremvc.org>  
 PureMVC - Copyright(c) 2006, 2007 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
import org.puremvc.as2.core.Model;
import org.puremvc.as2.interfaces.IModel;
import org.puremvc.as2.interfaces.IProxy;
import org.puremvc.as2.patterns.proxy.MockProxy;
import org.puremvc.as2.patterns.proxy.Proxy;

class org.puremvc.as2.core.ModelTest extends com.asunit.framework.TestCase {

	private var className:String = "org.puremvc.as2.core.ModelTest";
	private var instance:IModel;

	public function setUp():Void {
		instance = Model.getInstance();
	}

	public function tearDown():Void {
		delete instance;
 	}
	
	
	/**
	* Tests the Model Singleton Factory Method 
	*/
	public function testGetInstance():Void {
		assertNotNull("Expecting instance not null", instance);
		assertTrue("Expecting instance implements IModel", instance instanceof IModel);
		
		var model:IModel = Model.getInstance();
		assertSame("2 Model variable point to the same Model in memory", instance, model);
	}
	
	
	/**
	 * Tests the proxy registration and retrieval methods.
	 * 
	 * Tests {@link registerProxy} and {@link retrieveProxy} in the same test.
	 * 
	 * These methods cannot currently be tested separately
	 * in any meaningful way other than to show that the
	 * methods do not throw exceptions when called.
	 */
	public function testRegisterAndRetrieveProxy():Void{
		
		// register a proxy and retrieve it.
		var model:IModel = Model.getInstance();
		model.registerProxy(new Proxy('colors', ['red', 'green', 'blue']));
		var proxy:Proxy = Proxy(model.retrieveProxy('colors'));
		var data = proxy.getData();
		
		// test assertions
		assertNotNull( "Expecting data not null", data);
		assertTrue( "Expecting data type is Array", data instanceof Array);
		assertTrue( "Expecting data.length == 3", data.length == 3);
		assertTrue( "Expecting data[0] == 'red'", data[0]  == 'red');
		assertTrue( "Expecting data[1] == 'green'", data[1]  == 'green');
		assertTrue( "Expecting data[2] == 'blue'", data[2]  == 'blue');
	}
	
	/**
	 * Tests the proxy removal method.
	 */
	public function testRegisterAndRemoveProxy():Void{
		
		// register a proxy, remove it, then try to retrieve it
		var model:IModel = Model.getInstance();
		var proxy:IProxy = new Proxy('sizes', ['7', '13', '21']);
		model.registerProxy(proxy);

		// remove the proxy
		var removedProxy:IProxy = model.removeProxy('sizes');
		
		// assert that we removed the appropriate proxy
		assertTrue("Expecting removedProxy.getProxyName() == 'sizes'", 
					removedProxy.getProxyName() == 'sizes');
		
		// ensure that the proxy is no longer retrievable from the model
		proxy = model.retrieveProxy('sizes');

		// test assertions
		assertNull( "Expecting proxy is null", proxy );
	}
	
	/**
	 * Tests the hasProxy Method
	 */
	public function testHasProxy():Void{
		
		// register a proxy
		var model:IModel = Model.getInstance();
		var proxy:IProxy = new Proxy('aces', ['clubs', 'spades', 'hearts', 'diamonds']);
		model.registerProxy(proxy);
		
		// assert that the model.hasProxy method returns true
		// for that proxy name
		assertTrue("Expecting model.hasProxy('aces') == true", 
					model.hasProxy('aces') == true);
		
		// remove the proxy
		model.removeProxy('aces');
		
		// assert that the model.hasProxy method returns false
		// for that proxy name
		assertTrue("Expecting model.hasProxy('aces') == false", 
					model.hasProxy('aces') == false);
	}
	
	/**
	 * Tests that the Model calls the onRegister and onRemove methods
	 */
	public function testOnRegisterAndOnRemove():Void{
		
		// Get the Singleton View instance
		var model:IModel = Model.getInstance();

		// Create and register the test proxy
		var proxy:IProxy = new MockProxy();
		// check that there's no data before registration
		assertTrue("Before registering with model, proxy.getData() == ''", 
					proxy.getData() == "");
		
		model.registerProxy( proxy);

		// assert that onRegister was called, and the proxy responded by setting its data accordingly
		assertTrue("Expecting proxy.getData() == MockProxy.ON_REGISTER_CALLED", 
					proxy.getData() == MockProxy.ON_REGISTER_CALLED);
		
		// Remove the component
		model.removeProxy(MockProxy.NAME);

		// assert that onRemove was called, and the proxy responded by setting its data accordingly
		assertTrue("Expecting proxy.getData() == MockProxy.ON_REMOVE_CALLED", 
					proxy.getData() == MockProxy.ON_REMOVE_CALLED);
	}


}
