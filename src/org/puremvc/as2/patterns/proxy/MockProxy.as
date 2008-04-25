/* 
 PureMVC AS2 Unit Tests Ported by James Knight <james.knight@puremvc.org>  
 PureMVC - Copyright(c) 2006, 2007 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
import org.puremvc.as2.patterns.proxy.Proxy;

/**
 * Another Mock to facilitate testing
 * 
 * @see org.puremvc.as2.patterns.proxy.Proxy
 */
class org.puremvc.as2.patterns.proxy.MockProxy extends Proxy {
	
	public static var NAME:String = 'MockProxy';
	public static var ON_REGISTER_CALLED:String = 'onRegister Called';
	public static var ON_REMOVE_CALLED:String = 'onRemove Called';

	public function MockProxy() {
		super(NAME, "");
	}

	/**
	 * When this mock is registered, {@link #setData()} sets
	 * {@link data} to {@link #ON_REGISTER_CALLED}
	 */
	public function onRegister():Void {
		setData(ON_REGISTER_CALLED);
	}		

	/**
	 * When this mock is removed, {@link #setData()} sets
	 * {@link data} to {@link #ON_REMOVE_CALLED}
	 */
	public function onRemove():Void {
		setData(ON_REMOVE_CALLED);
	}			
}