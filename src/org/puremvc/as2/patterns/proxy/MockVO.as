/* 
 PureMVC AS2 Unit Tests Ported by James Knight <james.knight@puremvc.org>  
 PureMVC - Copyright(c) 2006, 2007 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */


/**
 * A utility class used by {@link ControllerTest}.
 * 
 * It holds properties which get updated through interaction with the
 * relevant {@link MockCommand}
 * 
 * @see org.puremvc.as2.core.controller.ControllerTest ControllerTest
 * @see org.puremvc.as2.core.patterns.command.MockSimpleCommand MockSimpleCommand
 */
class org.puremvc.as2.patterns.proxy.MockVO {
	
	public var input:Number;
	public var result:Number;
	public var result1:Number;
	public var result2:Number;

	/**
	 * Constructor.
	 * 
	 * @param input the number to be fed to the {@link MockSimpleCommand}
	 */
	public function MockVO (input:Number){
		this.input = input;
	}
}
