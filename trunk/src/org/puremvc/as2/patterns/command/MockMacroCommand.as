/* 
 PureMVC AS2 Unit Tests Ported by James Knight <james.knight@puremvc.org>  
 PureMVC - Copyright(c) 2006, 2007 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
import org.puremvc.as2.interfaces.ICommand;
import org.puremvc.as2.patterns.command.MacroCommand;
import org.puremvc.as2.patterns.command.MockSimpleCommand;

class org.puremvc.as2.patterns.command.MockMacroCommand extends MacroCommand implements ICommand {
	
	public function MockMacroCommand() {
		super();
	}
	
	/**
	 * Initialize the MacroCommandTestCommand by adding
	 * its 2 SubCommands.
	 */
	public function initializeMacroCommand():Void {
		
		var subCommand1:ICommand = new MockSimpleCommand(2, "result1");
		var subCommand2:ICommand = new MockSimpleCommand(5, "result2");
		
		addSubCommand(subCommand1);
		addSubCommand(subCommand2);
	}
	
}