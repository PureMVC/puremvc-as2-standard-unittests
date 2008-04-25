/* 
 PureMVC AS2 Unit Tests Ported by James Knight <james.knight@puremvc.org>  
 PureMVC - Copyright(c) 2006, 2007 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */

class AllTests extends asunit.framework.TestSuite {

	private var className:String = "AllTests";

	public function AllTests() {
		super();
		addTest(new org.puremvc.as2.core.ControllerTest());
		addTest(new org.puremvc.as2.core.ModelTest());
		addTest(new org.puremvc.as2.core.ViewTest());
		addTest(new org.puremvc.as2.patterns.command.MacroCommandTest());
		addTest(new org.puremvc.as2.patterns.command.SimpleCommandTest());
		addTest(new org.puremvc.as2.patterns.facade.FacadeTest());
		addTest(new org.puremvc.as2.patterns.mediator.MediatorTest());
		addTest(new org.puremvc.as2.patterns.observer.NotificationTest());
		addTest(new org.puremvc.as2.patterns.observer.ObserverTest());
		addTest(new org.puremvc.as2.patterns.proxy.ProxyTest());
	}
}
