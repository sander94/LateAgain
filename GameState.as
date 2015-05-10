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
			startScene();
			//homeScene();
			//suburbScene();
		}
		
		public function startScene()
		{
			removeScene();
			_startScene = new StartScene(this, stage);
			addChild(_startScene);
		}
		
		public function homeScene()
		{
			removeScene();
			_homeScene = new HomeScene(this, stage);
			addChild(_homeScene);
		}
		
		public function suburbScene()
		{
			removeScene();
			_suburbScene = new SuburbScene(this, stage);
			_suburbScene.y = -180;
			addChild(_suburbScene);
		}
		
		public function endScene()
		{
			// TODO Auto Generated method stub
			
		}

		public function removeScene()
		{
			if (_startScene)
			{
				removeChild(_startScene);
				_startScene = null;
			}
			if (_homeScene)
			{
				removeChild(_homeScene);
				_homeScene = null;
			}
			if (_suburbScene)
			{
				removeChild(_suburbScene);
				_suburbScene = null;
			}
		}
	}
}