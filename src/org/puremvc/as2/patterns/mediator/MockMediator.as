/* 
 PureMVC AS2 Unit Tests Ported by James Knight <james.knight@puremvc.org>  
 PureMVC - Copyright(c) 2006, 2007 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
import org.puremvc.as2.core.ViewTest;
import org.puremvc.as2.interfaces.IMediator;
import org.puremvc.as2.interfaces.INotification;
import org.puremvc.as2.patterns.mediator.Mediator;

/**
 * A {@link Mediator} used by {@link ViewTest}.
 * 
 * This mock updates {@link ViewTest#lastNotification} with #getName().
 * 
 * @see org.puremvc.as2.core.view.ViewTest ViewTest
 */
	
class org.puremvc.as2.patterns.mediator.MockMediator extends Mediator implements IMediator {
	
	public static var NAME:String = "MockMediator";
	
	private var _interests:Array;
	public var onRegisterCalled:Boolean;
	public var onRemoveCalled:Boolean;

	/**
	 * @param view - Object
	 * @param interests - optional Array of String objects
	 * @param name - optional, used to override {@link #NAME}, in case multiple mocks
	 * need to be registered in a single {@link TestCase}
	 * 
	 * If {@code interests} is not passed in, #listNotificationInterests()
	 * will return {@code ["ABC", "DEF", "GHI"]}
	 * 
	 */
	public function MockMediator(view:Object, interests:Array, name:String) {
		super((name || NAME), view);
		if (interests != undefined) {
			_interests = interests;
		} else {
			_interests = ['ABC', 'DEF', 'GHI'];
		}
		onRegisterCalled = false;
		onRemoveCalled = false;
	}

	/**
	 * If interests have not been passed into the constructor, 
	 * this will return {@code ["ABC", "DEF", "GHI"]}
	 */
	public function listNotificationInterests():Array {
		return _interests;
	}

	public function handleNotification(notification:INotification):Void {
		viewTest.lastNotification = notification.getName();
	}
	
	/**
	 * @return {@code viewComponent} correctly cast to {@link ViewType}
	 */	
	public function get viewTest():ViewTest {
		return ViewTest(viewComponent);
	}
			
	/**
	 * Implementation of {@link IMediator#onRegister}, this
	 * sets {@link #onRegisterCalled} to {@code true} 
	 */
	public function onRegister():Void {
		viewTest.onRegisterCalled = true;		onRegisterCalled = true;
	}
	
	/**
	 * Implementation of {@link IMediator#onRemove}, this
	 * sets {@link #onRemoveCalled} to {@code true} 
	 */
	public function onRemove():Void {
		viewTest.onRemoveCalled = true;		onRemoveCalled = true;
	}
}