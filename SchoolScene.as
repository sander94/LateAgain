package
{
	import KeyObject;
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class SchoolScene extends MovieClip
	{
		private var gameState:GameState;
		private var stageRef:Stage;
		public var player:Player;
		
		private var schoolForeground:SchoolForeground;
		private var cars:Cars;
		private var carsTimer:Timer = new Timer(1800);		// 1000ms == 1second
		private var enemies:Enemies;
		private var carDirection:String = "left";
		
		public static var objects:Array;
		
		public function SchoolScene(passedClass:GameState, stageRef:Stage)
		{
			gameState = passedClass;
			this.stageRef = stageRef;
			objects = new Array();
			addObjects();
			
			if (gameState.shortCut == true)
			{
				player = new Player(gameState, stageRef, SchoolScene, this, 30, 90);
				player.x = 30;
				player.y = 90;
			}
			else
			{
				player = new Player(gameState, stageRef, SchoolScene, this, 40, 325);
				player.x = 40;
				player.y = 325;
			}
			addChild(player);
			
			addEnemies();
			
			schoolForeground = new SchoolForeground;
			schoolForeground.x = 490;
			schoolForeground.y = 220;
			addChild(schoolForeground);
			
			carsTimer.start();
			carsTimer.addEventListener(TimerEvent.TIMER, carsTimerTick,false,0,true);
			addEventListener(Event.ENTER_FRAME, mainLoop,false,0,true);
			
			leaveSchool.addEventListener(Event.ENTER_FRAME, sceneChange,false,0,true);
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
			enemies = new Enemies("granny", "up", 789, 278); //Passing enemy type, direction to patrol in and spawn X and Y coordinates to the Enemies class
			enemies.x = 789;								//This is a testing location, change as you will
			enemies.y = 278;
			enemies.name = "enemy_granny_" + objects.length;
			addChild(enemies);
			objects.push(enemies);
			
			enemies = new Enemies("kid", "left", 292, 465); //Passing enemy type, direction to patrol in and spawn X and Y coordinates to the Enemies class
			enemies.x = 292;								//This is a testing location, change as you will
			enemies.y = 465;
			enemies.name = "enemy_kid_" + objects.length;
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
				leaveSchool.removeEventListener(Event.ENTER_FRAME, sceneChange);
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
				cars.y = 375;
				cars.name = "enemy_car_" + objects.length;
				addChild(cars);
				objects.push(cars);
				
				carDirection = "right";
				cars = new Cars(carDirection);
				cars.x = -60;
				cars.y = 430;
				cars.name = "enemy_car_" + objects.length;
				addChild(cars);
				objects.push(cars);
			}
		}
		
		public function sceneChange(event:Event)
		{
			if (leaveSchool.hitTestObject(player))
			{
				carsTimer.stop();
				carsTimer.removeEventListener(TimerEvent.TIMER, carsTimerTick);
				removeEventListener(Event.ENTER_FRAME, mainLoop);
				leaveSchool.removeEventListener(Event.ENTER_FRAME, sceneChange);
				player.removeEventListeners();
				for (var i = 0; i < objects.length; i++)
				{
					if (objects[i].name.indexOf("enemy") >= 0)
					{
						objects[i].removeEventListeners();
					}
				}
				objects = null;
				gameState.endScene();
				trace("THE END scene");
			}
		}
	}
}