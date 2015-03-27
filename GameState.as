package
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.system.*;
	
	public class GameState extends Sprite
	{
		private var _startScene:StartScene;
		private var _endScene:EndScene;
		private var _homeScene:HomeScene;
		
		public function GameState()
		{
			startScene();
		}
		
		private function homeScene()
		{
			_homeScene = new HomeScene(this);
			addChild(_homeScene);
		}
		
		private function endScene()
		{
			// TODO Auto Generated method stub
			
		}
		
		private function startScene()
		{
			_startScene = new StartScene(this);
			addChild(_startScene);
		}
	}
}