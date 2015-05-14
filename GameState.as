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
		private var _suburbScene2:SuburbScene2;
		private var _slumScene:SlumScene;
		private var _cityScene:CityScene;
		
		public function GameState()
		{
			startScene();
			//homeScene();
			//suburbScene();
			//suburbScene2();
			//slumScene();
			//cityScene();
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
			//_suburbScene.y = -180;
			addChild(_suburbScene);
		}
		
		public function suburbScene2()
		{
			removeScene();
			_suburbScene2 = new SuburbScene2(this, stage);
			//_suburbScene2.y = -180;
			addChild(_suburbScene2);
		}
		public function slumScene()
		{
			removeScene();
			_slumScene = new SlumScene(this, stage);
			//_slumScene.y = -50;
			addChild(_slumScene);
		}
		public function cityScene()
		{
			removeScene();
			_cityScene = new CityScene(this, stage);
			//_cityScene.y = -140;
			addChild(_cityScene);
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
			if (_suburbScene2)
			{
				removeChild(_suburbScene2);
				_suburbScene2 = null;
			}
			if (_slumScene)
			{
				removeChild(_slumScene);
				_slumScene = null;
			}
			if (_cityScene)
			{
				removeChild(_cityScene);
				_cityScene = null;
			}
		}
	}
}