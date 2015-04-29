package
{
	import flash.display.*;
	import flash.system.*;
	
	public class GameState extends Sprite
	{
		private var _startScene:StartScene;
		private var _endScene:EndScene;
		private var _homeScene:HomeScene;
		
		public function GameState()
		{
			//startScene();
			homeScene();
		}
		
		public function startScene()
		{
			if(_homeScene)
			{
				removeChild(_homeScene);
			}
			_startScene = new StartScene(this);
			addChild(_startScene);
		}
		
		public function homeScene()
		{
			_homeScene = new HomeScene(this, stage);
			addChild(_homeScene);
		}
		
		public function endScene()
		{
			// TODO Auto Generated method stub
			
		}
		

	}
}