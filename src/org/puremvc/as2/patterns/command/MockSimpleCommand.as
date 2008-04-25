/* 
 PureMVC AS2 Unit Tests Ported by James Knight <james.knight@puremvc.org>  
 PureMVC - Copyright(c) 2006, 2007 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
import org.puremvc.as2.interfaces.*;
import org.puremvc.as2.patterns.command.*;
import org.puremvc.as2.patterns.proxy.MockVO;

/**
 * A SimpleCommand subclass used by ControllerTest.
 * Execute defaults to changing the 'result' property of the VO, multiplying the 
 * input by 2
 * @see org.puremvc.as2.core.controller.ControllerTest ControllerTest
 * @see org.puremvc.as2.core.controller.MockVO MockVO
 */
class org.puremvc.as2.patterns.command.MockSimpleCommand extends SimpleCommand implements ICommand {

	private var _multiplier:Number;
	private var _receiver:String; //String name of property in receiving VO
	
	/**
	 * Constructor.
	 */
	public function MockSimpleCommand(multiplier:Number, receiver:String) {
		super();
		_multiplier = multiplier || 2;
		_receiver = receiver || "result";
	}
	
	/**
	 * Fabricate a result by multiplying the input by 2
	 * 
	 * @param note the note carrying the ControllerTestVO
	 */
	public function execute( note:INotification ):Void {
		
		var vo:MockVO = MockVO(note.getBody());
		// Fabricate a result
		vo[_receiver]= _multiplier * vo.input;
	}
	
}
