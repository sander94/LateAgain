package
{
	import flash.display.*;
	import flash.system.*;
	import flash.events.*;
	import flash.utils.Timer;
	
	public class GameState extends Sprite
	{
		private var _startScene:StartScene;
		private var _endScene:EndScene;
		private var _homeScene:HomeScene;
		private var _suburbScene:SuburbScene;
		private var _suburbScene2:SuburbScene2;
		private var _slumScene:SlumScene;
		private var _cityScene:CityScene;
		public var gameTimeRemaining:Number = 300;
		private var gameTimer:Timer = new Timer(1000);		// 1000ms == 1second
		
		public function GameState()
		{
			//startScene();
			//homeScene();
			//suburbScene();
			suburbScene2();
			//slumScene();
			//cityScene();
		}

		private function gameTimerTick(e:TimerEvent)
		{
			if (!Player.playerHit)
			{
				gameTimeRemaining -= 1 * Player.speedMult;
			}
			Player.userInterface.timeRemaining.text = String(Math.ceil(gameTimeRemaining));
		}
		
		public function startScene()
		{
			gameTimer.stop();
			gameTimer = new Timer(1000);
			gameTimeRemaining = 300;
			gameTimer.removeEventListener(TimerEvent.TIMER, gameTimerTick)
			removeScene();
			_startScene = new StartScene(this, stage);
			addChild(_startScene);
		}
		
		public function homeScene()
		{
			removeScene();
			_homeScene = new HomeScene(this, stage);
			addChild(_homeScene);

			Player.userInterface.timeRemaining.text = String(Math.ceil(gameTimeRemaining));
			gameTimer.start();
			gameTimer.addEventListener(TimerEvent.TIMER, gameTimerTick);
		}
		
		public function suburbScene()
		{
			removeScene();
			_suburbScene = new SuburbScene(this, stage);
			addChild(_suburbScene);

			Player.userInterface.timeRemaining.text = String(Math.ceil(gameTimeRemaining));
		}
		
		public function suburbScene2()
		{
			removeScene();
			_suburbScene2 = new SuburbScene2(this, stage);
			addChild(_suburbScene2);

			Player.userInterface.timeRemaining.text = String(Math.ceil(gameTimeRemaining));
		}
		public function slumScene()
		{
			removeScene();
			_slumScene = new SlumScene(this, stage);
			addChild(_slumScene);

			Player.userInterface.timeRemaining.text = String(Math.ceil(gameTimeRemaining));
		}
		public function cityScene()
		{
			removeScene();
			_cityScene = new CityScene(this, stage);
			addChild(_cityScene);

			Player.userInterface.timeRemaining.text = String(Math.ceil(gameTimeRemaining));
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