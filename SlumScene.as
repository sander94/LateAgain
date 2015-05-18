package
{
	import KeyObject;
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class SlumScene extends MovieClip
	{
		private var gameState:GameState;
		private var stageRef:Stage;
		public var player:Player;
		
		private var slumForeground:SlumForeground;
		private var cars:Cars;
		private var carsTimer:Timer = new Timer(3000);		// 1000ms == 1second
		private var enemies:Enemies;
		
		public static var objects:Array;
		
		public function SlumScene(passedClass:GameState, stageRef:Stage)
		{
			gameState = passedClass;
			this.stageRef = stageRef;
			objects = new Array();
			addObjects();
			
			player = new Player(gameState, stageRef, SlumScene, this, 40,184);
			player.x = 40;
			player.y = 184;
			addChild(player);
			
			slumForeground = new SlumForeground;
			slumForeground.x = 489;
			slumForeground.y = 232;
			addChild(slumForeground);
			
			addEnemies();
			
			/*carsTimer.start();
			carsTimer.addEventListener(TimerEvent.TIMER, carsTimerTick,false,0,true);*/
			addEventListener(Event.ENTER_FRAME, mainLoop,false,0,true);

			leaveSlum.addEventListener(Event.ENTER_FRAME, sceneChange,false,0,true);
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
			enemies = new Enemies("nazi", "right", 0, 0); //Passing enemy type, direction to patrol in and spawn X and Y coordinates to the Enemies class
			enemies.x = 580;//This is a testing location, change as you will
			enemies.y = 230;
			enemies.name = "enemy_nazi_" + objects.length;
			addChild(enemies);
			objects.push(enemies);
			
			enemies = new Enemies("nazi", "left", 0, 0); //Passing enemy type, direction to patrol in and spawn X and Y coordinates to the Enemies class
			enemies.x = 480;//This is a testing location, change as you will
			enemies.y = 190;
			enemies.name = "enemy_nazi_" + objects.length;
			addChild(enemies);
			objects.push(enemies);
			//Add more enemies here
		}

		private function mainLoop(e:Event)
		{
			/*if (objects == null)
			{
				carsTimer.stop();
				carsTimer.removeEventListener(TimerEvent.TIMER, carsTimerTick);
				leaveSlum.removeEventListener(Event.ENTER_FRAME, sceneChange);
				removeEventListener(Event.ENTER_FRAME, mainLoop);
			}
			else if (!player.playerAlive)
			{
				for (var i = 0; i < objects.length; i++)
				{
					if (objects[i].name.indexOf("enemy") >= 0)
					{
						objects[i].removeEventListeners();
					}
				}
			}*/
		}
		
		/*private function carsTimerTick(timerEvent:TimerEvent):void
		{
			if (player.playerAlive)
			{
				cars = new Cars(SuburbScene); //Passing current scene to Cars class
				cars.x = 1060;
				cars.y = 420;
				cars.name = "enemy_car_" + objects.length;
				addChild(cars);
				objects.push(cars);
			}
		}*/

		public function sceneChange(event:Event)
		{
			if (leaveSlum.hitTestObject(player))
			{
				/*carsTimer.stop();
				carsTimer.removeEventListener(TimerEvent.TIMER, carsTimerTick);
				removeEventListener(Event.ENTER_FRAME, mainLoop);*/
				leaveSlum.removeEventListener(Event.ENTER_FRAME, sceneChange);
				player.removeEventListeners();
				/*for (var i = 0; i < objects.length; i++)
				{
					if (objects[i].name.indexOf("enemy") >= 0)
					{
						objects[i].removeEventListeners();
					}
				}*/
				objects = null;
				gameState.cityScene();
				trace("Moving to City");
			}
		}
		
	}
}