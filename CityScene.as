package
{
	import KeyObject;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class CityScene extends MovieClip
	{
		private var gameState:GameState;
		private var stageRef:Stage;
		public var player:Player;
		
		private var cityForeground:CityForeground;
		private var porche:Porche;
		private var porcheTimer:Timer = new Timer(2000);		// 1000ms == 1second
		
		public static var objects:Array;
		
		public function CityScene(passedClass:GameState, stageRef:Stage)
		{
			gameState = passedClass;
			this.stageRef = stageRef;
			objects = new Array();
			addObjects();
			
			player = new Player(gameState, stageRef, CityScene, this);
			player.x = 38;
			player.y = 346;
			addChild(player);
			
			cityForeground = new CityForeground;
			cityForeground.x = 476;
			cityForeground.y = 256;
			addChild(cityForeground);
			
			porcheTimer.start();
			porcheTimer.addEventListener(TimerEvent.TIMER, porcheTimerTick,false,0,true);
			
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
		
		private function porcheTimerTick(timerEvent:TimerEvent):void
		{
			if (player.playerAlive)
			{
				porche = new Porche(SuburbScene); //Passing current scene to Porche class
				porche.x = 980;
				porche.y = 392;
				porche.name = "enemy_car_" + objects.length;
				addChild(porche);
				objects.push(porche);
			}
		}
		
		/*public function sceneChange(event:Event)
		{
			if (leaveSuburb.hitTestObject(player))
			{
				porcheTimer.stop();
				porcheTimer.removeEventListener(TimerEvent.TIMER, porcheTimerTick);
				leaveSuburb.removeEventListener(Event.ENTER_FRAME, sceneChange);
				player.removeEventListeners();
				porche.removeEventListeners();
				objects = null;
				gameState.suburbScene2();
				trace("Switch to Suburb 2");
			}
		}*/
	}
}