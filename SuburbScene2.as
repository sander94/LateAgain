package
{
	import KeyObject;
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class SuburbScene2 extends MovieClip
	{
		private var gameState:GameState;
		private var stageRef:Stage;
		public var player:Player;
		
		private var suburbForeground:SuburbForeground2;
		private var cars:Cars;
		private var carsTimer:Timer = new Timer(2000);		// 1000ms == 1second
		private var enemies:Enemies;
		private var carDirection:String = "left";
		
		public static var objects:Array;
		
		public function SuburbScene2(passedClass:GameState, stageRef:Stage)
		{
			gameState = passedClass;
			this.stageRef = stageRef;
			objects = new Array();
			addObjects();
			
			player = new Player(gameState, stageRef, SuburbScene2, this, 40, 142);
			player.x = 40;
			player.y = 142;
			addChild(player);
			
			suburbForeground = new SuburbForeground2;
			suburbForeground.x = 532.5;
			suburbForeground.y = 337;
			addChild(suburbForeground);
			
			addEnemies();
			
			carsTimer.start();
			carsTimer.addEventListener(TimerEvent.TIMER, carsTimerTick,false,0,true);
			addEventListener(Event.ENTER_FRAME, mainLoop,false,0,true);
			
			leaveSuburb2.addEventListener(Event.ENTER_FRAME, sceneChange,false,0,true);
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
			enemies = new Enemies("granny", "up", 420, 250); //Passing enemy type, direction to patrol in and spawn X and Y coordinates to the Enemies class
			enemies.x = 422;								//This is a testing location, change as you will
			enemies.y = 290;
			enemies.name = "enemy_granny_" + objects.length;
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
				leaveSuburb2.removeEventListener(Event.ENTER_FRAME, sceneChange);
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
				carDirection = "left";
				cars = new Cars("left"); //Passing direction to Cars class
				cars.x = 1060;
				cars.y = 50;
				cars.name = "enemy_car_" + objects.length;
				addChild(cars);
				objects.push(cars);
				
				carDirection = "left";
				cars = new Cars(carDirection);
				cars.x = 1060;
				cars.y = 396;
				cars.name = "enemy_car_" + objects.length;
				addChild(cars);
				objects.push(cars);
			}
		}
		
		public function sceneChange(event:Event)
		{
			if (leaveSuburb2.hitTestObject(player))
			{
				carsTimer.stop();
				carsTimer.removeEventListener(TimerEvent.TIMER, carsTimerTick);
				removeEventListener(Event.ENTER_FRAME, mainLoop);
				leaveSuburb2.removeEventListener(Event.ENTER_FRAME, sceneChange);
				player.removeEventListeners();
				for (var i = 0; i < objects.length; i++)
				{
					if (objects[i].name.indexOf("enemy") >= 0)
					{
						objects[i].removeEventListeners();
					}
				}
				objects = null;
				gameState.slumScene();
				trace("GAME CONTINUE TIME LOOOOOOOOOOOP");
			}
		}
	}
}