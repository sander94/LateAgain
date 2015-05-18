package
{
	import KeyObject;
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class CityScene extends MovieClip
	{
		private var gameState:GameState;
		private var stageRef:Stage;
		public var player:Player;
		
		private var cityForeground:CityForeground;
		private var cars:Cars;
		private var carsTimer:Timer = new Timer(1200);		// 1000ms == 1second
		private var enemies:Enemies;
		
		public static var objects:Array;
		
		public function CityScene(passedClass:GameState, stageRef:Stage)
		{
			gameState = passedClass;
			this.stageRef = stageRef;
			objects = new Array();
			addObjects();
			
			player = new Player(gameState, stageRef, CityScene, this, 38, 346);
			player.x = 38;
			player.y = 346;
			addChild(player);
			
			cityForeground = new CityForeground;
			cityForeground.x = 476;
			cityForeground.y = 256;
			addChild(cityForeground);
			
			addEnemies();
			
			carsTimer.start();
			carsTimer.addEventListener(TimerEvent.TIMER, carsTimerTick,false,0,true);
			addEventListener(Event.ENTER_FRAME, mainLoop,false,0,true);
			
			//leaveSuburb.addEventListener(Event.ENTER_FRAME, sceneChange,false,0,true);
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
			enemies = new Enemies("suit", "left", 500, 340); //Passing enemy type, direction to patrol in and spawn X and Y coordinates to the Enemies class
			enemies.x = 500;//This is a testing location, change as you will
			enemies.y = 340;
			enemies.name = "enemy_suit_" + objects.length;
			addChild(enemies);
			objects.push(enemies);
			
			enemies = new Enemies("suit", "right", 300, 240); //Passing enemy type, direction to patrol in and spawn X and Y coordinates to the Enemies class
			enemies.x = 300;//This is a testing location, change as you will
			enemies.y = 240;
			enemies.name = "enemy_suit_" + objects.length;
			addChild(enemies);
			objects.push(enemies);
			//Add more enemies here
		}
		
		private function mainLoop(e:Event)
		{
			if (objects == null)
			{
				carsTimer.stop();
				carsTimer.removeEventListener(TimerEvent.TIMER, carsTimerTick);
				//leaveCity.removeEventListener(Event.ENTER_FRAME, sceneChange);
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
			if (Player.playerAlive)
			{
				cars = new Cars("left"); //Passing current scene to Cars class
				cars.x = 1060;
				cars.y = 400;
				cars.name = "enemy_car_" + objects.length;
				addChild(cars);
				objects.push(cars);
			}
		}
		
		/*public function sceneChange(event:Event)
		{
			if (leaveSuburb.hitTestObject(player))
			{
				carsTimer.stop();
				carsTimer.removeEventListener(TimerEvent.TIMER, carsTimerTick);
				removeEventListener(Event.ENTER_FRAME, mainLoop);
				leaveSuburb.removeEventListener(Event.ENTER_FRAME, sceneChange);
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
		}*/
	}
}