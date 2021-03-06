package
{
	import KeyObject;
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class SuburbScene extends MovieClip
	{
		private var gameState:GameState;
		private var stageRef:Stage;
		public var player:Player;

		private var suburbForeground:SuburbForeground;
		private var cars:Cars;
		private var enemies:Enemies;
		private var carsTimer:Timer = new Timer(2000);		// 1000ms == 1second
		private var carDirection:String = "left";
		
		public static var objects:Array;
		
		public function SuburbScene(passedClass:GameState, stageRef:Stage)
		{
			gameState = passedClass;
			this.stageRef = stageRef;
			objects = new Array();
			addObjects();

			player = new Player(gameState, stageRef, SuburbScene, this, 91, 292);
			player.x = 91;
			player.y = 292;
			addChild(player);
			
			gameState.volume.volume = 0.5;
			gameState.musicChannel.stop()
			gameState.musicChannel = gameState.stageMusic.play(0, 10, gameState.volume);
			
			addEnemies();

			suburbForeground = new SuburbForeground;
			suburbForeground.x = 480;
			suburbForeground.y = 268;
			addChild(suburbForeground);

			carsTimer.start();
			carsTimer.addEventListener(TimerEvent.TIMER, carsTimerTick,false,0,true);
			addEventListener(Event.ENTER_FRAME, mainLoop,false,0,true);
			
			leaveSuburb.addEventListener(Event.ENTER_FRAME, sceneChange,false,0,true);
		}
		
		//Add collidable objects to objects array
		public function addObjects()
		{
			var i:uint = 0;
			for (i; i < this.numChildren; i++)
			{
				if (this.getChildAt(i).name.indexOf("object") >= 0 || this.getChildAt(i).name.indexOf("power") >= 0 || this.getChildAt(i).name.indexOf("enemy") >= 0)
				{
					objects.push(this.getChildAt(i));
				}
			}
		}

		private function addEnemies()
		{
			enemies = new Enemies("granny", "down", 380, 220); 	//Passing enemy type, direction to patrol in and spawn X and Y coordinates to the Enemies class
			enemies.x = 326;									//This is a testing location, change as you will
			enemies.y = 250;
			enemies.name = "enemy_granny_" + objects.length;
			addChild(enemies);
			objects.push(enemies);

			enemies = new Enemies("kid", "up", 565, 362); 		//Passing enemy type, direction to patrol in and spawn X and Y coordinates to the Enemies class
			enemies.x = 565;									//This is a testing location, change as you will
			enemies.y = 362;
			enemies.name = "enemy_kid_" + objects.length;
			addChild(enemies);
			objects.push(enemies);
			
			enemies = new Enemies("kid", "right", 565, 518); 		//Passing enemy type, direction to patrol in and spawn X and Y coordinates to the Enemies class
			enemies.x = 565;									//This is a testing location, change as you will
			enemies.y = 518;
			enemies.name = "enemy_kid_" + objects.length;
			addChild(enemies);
			objects.push(enemies);
			//Add more enemies here
		}

		private function mainLoop(e:Event)
		{
			//removing all enemies if array is reset
			if (objects == null)
			{
				carsTimer.stop();
				carsTimer.removeEventListener(TimerEvent.TIMER, carsTimerTick);
				leaveSuburb.removeEventListener(Event.ENTER_FRAME, sceneChange);
				removeEventListener(Event.ENTER_FRAME, mainLoop);
			}
			else if (!Player.playerAlive)
			{
				for (var i = 0; i < objects.length; i++)
				{
					if (objects[i].name.indexOf("enemy") >= 0)
					{
						objects[i].removeEventListeners();
					}
				}
			}
		}
		
		private function carsTimerTick(timerEvent:TimerEvent):void
		{
			if (Player.playerAlive || !Player.playerHit)
			{
				carDirection = "left";
				cars = new Cars(carDirection);	//passing direction to Cars Class
				cars.x = 1060;
				cars.y = 422;
				cars.name = "enemy_car_" + objects.length;
				addChild(cars);
				objects.push(cars);
				
				carDirection = "right";
				cars = new Cars(carDirection);
				cars.x = -40;
				cars.y = 478;
				cars.name = "enemy_car_" + objects.length;
				addChild(cars);
				objects.push(cars);
			}
		}
		
		public function sceneChange(event:Event)
		{
			if (leaveSuburb.hitTestObject(player))
			{
				carsTimer.stop();
				carsTimer.removeEventListener(TimerEvent.TIMER, carsTimerTick);
				leaveSuburb.removeEventListener(Event.ENTER_FRAME, sceneChange);
				removeEventListener(Event.ENTER_FRAME, mainLoop);
				player.removeEventListeners();
				for (var i = 0; i < objects.length; i++)
				{
					if (objects[i].name.indexOf("enemy") >= 0)
					{
						objects[i].removeEventListeners();
					}
				}
				objects = null;
				gameState.suburbScene2();
				trace("Switch to Suburb 2");
			}
		}
	}
}