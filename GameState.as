package
{
	import flash.display.*;
	import flash.system.*;
	
	public class GameState extends Sprite
	{
		private var _startScene:StartScene;
		private var _endScene:EndScene;
		private var _homeScene:HomeScene;
		private var _suburbScene:SuburbScene;
		
		public function GameState()
		{
			//startScene();
			homeScene();
			//suburbScene();
		}
		
		public function startScene()
		{
			_startScene = new StartScene(this);
			addChild(_startScene);
		}
		
		public function homeScene()
		{
			if (_startScene)
			{
				removeChild(_startScene);
			}
			_homeScene = new HomeScene(this, stage);
			addChild(_homeScene);
		}
		
		public function suburbScene()
		{
			if (_homeScene)
			{
				removeChild(_homeScene);
			}
			_suburbScene = new SuburbScene(this, stage);
			addChild(_suburbScene);
		}
		
		public function endScene()
		{
			// TODO Auto Generated method stub
			
		}
		

	}
}