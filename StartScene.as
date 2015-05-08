package
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class StartScene extends MovieClip
	{

		private var _gameState:GameState;
		private var stageRef:Stage;
		private var _player:SsPlayer;
		
		private var _startButton:StartButton = new StartButton;
		private var _exitButton:ExitButton = new ExitButton;
		private var _instructionsButton:InstructionsButton = new InstructionsButton;
		
		
		public function StartScene(passedClass:GameState, stageRef:Stage)
		{
			_gameState = passedClass;
			this.stageRef = stageRef;
			_player = new SsPlayer(_gameState, stageRef);
			
			_player.x = 780;
			_player.y = 230;
			addChild(_player);
			
			trace("In the menu of the game");
			
			/*_startButton.x = 483;
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
			_exitButton.addEventListener(MouseEvent.CLICK, exitGame)*/
			
		}
		
		/*private function startGame(event:MouseEvent)
		{
			_startButton.removeEventListener(MouseEvent.CLICK, startGame)
			_instructionsButton.removeEventListener(MouseEvent.CLICK, showInstructions)
			_exitButton.removeEventListener(MouseEvent.CLICK, exitGame)
			_gameState.homeScene();
			trace("Start the game")
		}
		
		private function showInstructions(event:MouseEvent)
		{
			_instructionsButton.removeEventListener(MouseEvent.CLICK, showInstructions)
			trace("Show instructions")
		}
		
		private function exitGame(event:MouseEvent)
		{
			_exitButton.removeEventListener(MouseEvent.CLICK, exitGame)
			trace("Exit the game")
		}*/
	}
}