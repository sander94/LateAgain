package
{
	import flash.display.*;
	import flash.events.*;
	import flash.system.*;
	
	public class StartScene extends MovieClip
	{

		private var _gameState:GameState;
		
		private var _startButton:StartButton = new StartButton;
		private var _exitButton:ExitButton = new ExitButton;
		private var _instructionsButton:InstructionsButton = new InstructionsButton;
		
		
		public function StartScene(passedClass:GameState)
		{
			_gameState = passedClass;
			
			trace("In the menu of the game");
			
			_startButton.x = 483;
			_startButton.y = 284;
			_instructionsButton.x = 483;
			_instructionsButton.y = 366;
			_exitButton.x = 483;
			_exitButton.y = 450;
			
			addChild(_startButton);
			addChild(_instructionsButton);
			addChild(_exitButton);
			
			_startButton.addEventListener(MouseEvent.CLICK, startGame)
			_instructionsButton.addEventListener(MouseEvent.CLICK, showInstructions)
			_exitButton.addEventListener(MouseEvent.CLICK, exitGame)
		}
		
		private function startGame(event:MouseEvent)
		{
			_gameState.homeScene();
			trace("Start the game")
		}
		
		private function showInstructions(event:MouseEvent)
		{
			trace("Show instructions")
		}
		
		private function exitGame(event:MouseEvent)
		{
			trace("Exit the game")
		}
	}
}