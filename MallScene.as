package
{
	import KeyObject;
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class MallScene extends MovieClip
	{
		private var gameState:GameState;
		private var stageRef:Stage;
		public var player:Player;
		
		private var mallForeground:MallForeground;
		private var cars:Cars;
		private var enemies:Enemies;
		private var carsTimer:Timer = new Timer(1300);		// 1000ms == 1second
		private var carDirection:String = "left";
		
		public static var objects:Array;
		
		public function MallScene(passedClass:GameState, stageRef:Stage)
		{
			gameState = passedClass;
			this.stageRef = stageRef;
			objects = new Array();
			addObjects();
			
			player = new Player(gameState, stageRef, MallScene, this, 24, 350);
			player.x = 24;
			player.y = 350;
			addChild(player);
			
			addEnemies();
			
			mallForeground = new MallForeground;
			mallForeground.x = 480;
			mallForeground.y = 290;
			addChild(mallForeground);
			
			carsTimer.start();
			carsTimer.addEventListener(TimerEvent.TIMER, carsTimerTick,false,0,true);
			addEventListener(Event.ENTER_FRAME, mainLoop,false,0,true);
			
			leaveMall.addEventListener(Event.ENTER_FRAME, sceneChange,false,0,true);
			leaveMallSC.addEventListener(Event.ENTER_FRAME, sceneChange2,false,0,true);
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
			enemies = new Enemies("granny", "down", 324, 200); //Passing enemy type, direction to patrol in and spawn X and Y coordinates to the Enemies class
			enemies.x = 324;//This is a testing location, change as you will
			enemies.y = 200;
			enemies.name = "enemy_granny_" + objects.length;
			addChild(enemies);
			objects.push(enemies);
			
			enemies = new Enemies("granny", "up", 640, 338); //Passing enemy type, direction to patrol in and spawn X and Y coordinates to the Enemies class
			enemies.x = 640;//This is a testing location, change as you will
			enemies.y = 338;
			enemies.name = "enemy_granny_" + objects.length;
			addChild(enemies);
			objects.push(enemies);
			
			enemies = new Enemies("hippie", "down", 728, 20); //Passing enemy type, direction to patrol in and spawn X and Y coordinates to the Enemies class
			enemies.x = 728;//This is a testing location, change as you will
			enemies.y = 20;
			enemies.name = "enemy_hippie_" + objects.length;
			addChild(enemies);
			objects.push(enemies);
			
			enemies = new Enemies("kid", "left", 360, 492); //Passing enemy type, direction to patrol in and spawn X and Y coordinates to the Enemies class
			enemies.x = 360;//This is a testing location, change as you will
			enemies.y = 492;
			enemies.name = "enemy_kid_" + objects.length;
			addChild(enemies);
			objects.push(enemies);
			
			enemies = new Enemies("suit", "right", 628, 160); //Passing enemy type, direction to patrol in and spawn X and Y coordinates to the Enemies class
			enemies.x = 628;//This is a testing location, change as you will
			enemies.y = 160;
			enemies.name = "enemy_suit_" + objects.length;
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
				leaveMall.removeEventListener(Event.ENTER_FRAME, sceneChange);
				leaveMallSC.removeEventListener(Event.ENTER_FRAME, sceneChange2);
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
				cars = new Cars(carDirection); //Passing direction to Cars class
				cars.x = 1020;
				cars.y = 402;
				cars.name = "enemy_car_" + objects.length;
				addChild(cars);
				objects.push(cars);
				
				carDirection = "right";
				cars = new Cars(carDirection);
				cars.x = -40;
				cars.y = 452;
				cars.name = "enemy_car_" + objects.length;
				addChild(cars);
				objects.push(cars);
			}
		}
		
		public function sceneChange(event:Event)
		{
			if (leaveMall.hitTestObject(player))
			{
				gameState.shortCut = false;
				carsTimer.stop();
				carsTimer.removeEventListener(TimerEvent.TIMER, carsTimerTick);
				leaveMall.removeEventListener(Event.ENTER_FRAME, sceneChange);
				leaveMallSC.removeEventListener(Event.ENTER_FRAME, sceneChange2);
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
				gameState.schoolScene();
				trace("Switch to School");
			}
		}
		public function sceneChange2(event:Event)
		{
			if (leaveMallSC.hitTestObject(player))
			{
				gameState.shortCut = true;
				carsTimer.stop();
				carsTimer.removeEventListener(TimerEvent.TIMER, carsTimerTick);
				leaveMallSC.removeEventListener(Event.ENTER_FRAME, sceneChange2);
				leaveMall.removeEventListener(Event.ENTER_FRAME, sceneChange);
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
				gameState.schoolScene();
				trace("Switch to School");
			}
		}
	}
	
}