package
{
	import flash.display.Sprite;
	import flash.events.*;
	
	public class StartScene extends Sprite
	{
		
		private var _gameState:GameState;
		private var _startButton:StartButton = new StartButton;
		private var _quitButton:QuitButton = new QuitButton;
		private var _instructionsButton:InstructionsButton = new InstructionsButton;
		
		
		public function StartScene(passedClass:GameState)
		{
			_gameState = passedClass;
			trace("In the menu of the game");
			/*_startButton.x = ;
			_startButton.y = ;
			_quitButton.x = ;
			_quitButton.y = ;
			_instructionsButton.x = ;
			_instructionsButton.y = ;*/
			
			
		}
		
		
		/*private function startGame(event:MouseEvent)
		{
			_gameState.gameScene();
		}
		
		private function quitGame(event:MouseEvent)
		{
			_gameState.quitGame();
		}*/
	}
}