package
{
	import flash.display.*;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.system.*;
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
		private var _mallScene:MallScene;
		private var _schoolScene:SchoolScene;

		public var heldPowerUp:Boolean = false;				//moved powerup stuff here so that they are stored from scene to scene
		public var curPowerUp:MovieClip = new MovieClip;
		public var powerUpTime:int = 1000;
		public var powerUpActive:Boolean = false;

		public var maxStamina:int = 1200;					// sprint meter and cooldown variables for Shift key
		public var minStamina:int = 0;						// moved here so stamina status is stored from scene to scene
		public var currentStamina:int = maxStamina;
		public var cooldown:Boolean = false;
		
		public var gameTimeRemaining:Number;
		private var gameTimer:Timer = new Timer(1000);		// 1000ms == 1second
		
		public var introMusic:Sound = new MusicIntro2;							// reference to imported music in Flash library
		public var stageMusic:Sound = new MusicStage3;
		public var hitEffect:Sound = new HitEffect;
		public var pickUpPowerUp:Sound = new ItemPickUp;
		public var usePowerUpEffect:Sound = new PowerUpUse;
		public var deathMusic:Sound = new MusicGameOver;
		public var volume:SoundTransform = new SoundTransform(0.2, 0);			// volume control and panning
		public var effectVolume:SoundTransform = new SoundTransform(0.1, 0);
		public var musicChannel:SoundChannel = new SoundChannel;				// needed to control sound beyond the basic .play() command
		public var effectChannel:SoundChannel = new SoundChannel;
		public var hitChannel:SoundChannel = new SoundChannel;
		
		public var shortCut:Boolean = false;				// variable for triggering the shortcut spawn location when transfering from Mall to School
		
		public function GameState()
		{
			//startScene();
			//homeScene();
			//suburbScene();
			suburbScene2();
			//slumScene();
			//cityScene();
			//mallScene();
			//schoolScene();
			//endScene();
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
			gameTimeRemaining = 180; //set time remaining here
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
		public function mallScene()
		{
			removeScene();
			_mallScene = new MallScene(this, stage);
			addChild(_mallScene);
			
			Player.userInterface.timeRemaining.text = String(Math.ceil(gameTimeRemaining));
		}
		public function schoolScene()
		{
			removeScene();
			_schoolScene = new SchoolScene(this, stage);
			addChild(_schoolScene);
			
			Player.userInterface.timeRemaining.text = String(Math.ceil(gameTimeRemaining));
		}
		
		public function endScene()
		{
			gameTimer.stop();
			removeScene();
			_endScene = new EndScene(this, stage);
			addChild(_endScene);
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
			if (_mallScene)
			{
				removeChild(_mallScene);
				_mallScene = null;
			}
			if (_schoolScene)
			{
				removeChild(_schoolScene);
				_schoolScene = null;
			}
		}
	}
}