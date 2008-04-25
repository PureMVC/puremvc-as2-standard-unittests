/* 
 PureMVC AS2 Unit Tests Ported by James Knight <james.knight@puremvc.org>  
 PureMVC - Copyright(c) 2006, 2007 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
import org.puremvc.as2.interfaces.*;
import org.puremvc.as2.patterns.observer.*;

class org.puremvc.as2.patterns.observer.MockNotification extends Notification implements INotification {
	
	/**
	* The name of this Notification.
	*/
	public static var NAME:String = "MockNotification";

	/**
	* Constructor.
	* 
	* @param name Ignored and forced to NAME.
	* @param body the body of the Notification to be constructed.
	*/
	public function MockNotification(name:String, body:Object){						
		super(NAME, body);
	}

	/**
	* Factory method.
	* 
	* This method creates new instances of the ViewTestNote class,
	* automatically setting the note name so you don't have to. Use
	* this as an alternative to the constructor.
	* 
	* @param name the name of the Notification to be constructed.
	* @param body the body of the Notification to be constructed.
	*/
	public static function create(body:Object):INotification {
		return new MockNotification(NAME, body);
	}

	
}