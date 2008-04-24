/* 
 PureMVC AS2 Unit Tests Ported by James Knight <james.knight@puremvc.org>  
 PureMVC - Copyright(c) 2006, 2007 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */

import org.puremvc.as2.patterns.proxy.Proxy;

class org.puremvc.as2.patterns.proxy.ProxyTest extends com.asunit.framework.TestCase {
	
	private var className:String = "org.puremvc.as2.patterns.proxy.ProxyTest";
	private var instance:Proxy;

	public function setUp():Void {
		instance = new Proxy();
	}

	public function tearDown():Void {
		delete instance;
 	}

 	public function testInstantiated():Void {
		assertTrue("Proxy instantiated", instance instanceof Proxy);
	}
	
	/**
	 * Tests getting the name using Proxy class accessor method. Setting can only be done in constructor.
	 */
	public function testNameAccessor():Void {

		// Create a new Proxy and use accessors to set the proxy name 
		var proxy:Proxy = new Proxy('TestProxy');
		
		// test assertions
		assertTrue("Expecting proxy.getProxyName() == 'TestProxy'", proxy.getProxyName() == 'TestProxy');
	}

	/**
	 * Tests setting and getting the data using Proxy class accessor methods.
	 */
	public function testDataAccessors():Void {

		// Create a new Proxy and use accessors to set the data
		var proxy:Proxy = new Proxy('colors');
		proxy.setData(['red', 'green', 'blue']);
		var data = proxy.getData();
		
		// test assertions
		assertTrue("Expecting data.length == 3", data.length == 3);
		assertTrue("Expecting data[0] == 'red'", data[0]  == 'red');
		assertTrue("Expecting data[1] == 'green'", data[1]  == 'green');
		assertTrue("Expecting data[2] == 'blue'", data[2]  == 'blue');
	}
	
	/**
	 * Tests setting the name and body using the Notification class Constructor.
	 */
	public function testConstructor():Void {

		// Create a new Proxy using the Constructor to set the name and data
		var proxy:Proxy = new Proxy('colors', ['red', 'green', 'blue']);
		var data = proxy.getData();
		
		// test assertions
		assertNotNull("Expecting proxy not null", proxy);
		assertTrue("Expecting proxy.getProxyName() == 'colors'", proxy.getProxyName() == 'colors');
		assertTrue("Expecting data.length == 3", data.length == 3);
		assertTrue("Expecting data[0] == 'red'", data[0]  == 'red');
		assertTrue("Expecting data[1] == 'green'", data[1]  == 'green');
		assertTrue("Expecting data[2] == 'blue'", data[2]  == 'blue');
	}


}
