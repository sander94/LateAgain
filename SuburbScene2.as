package
{
	import KeyObject;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class SuburbScene2 extends MovieClip
	{
		private var gameState:GameState;
		private var stageRef:Stage;
		public var player:Player;
		
		private var suburbForeground:SuburbForeground2;
		private var porche:Porche;
		private var porcheTimer:Timer = new Timer(2000);		// 1000ms == 1second
		
		//public static var carList:Array = new Array();
		public static var objects:Array;
		
		public function SuburbScene2(passedClass:GameState, stageRef:Stage)
		{
			gameState = passedClass;
			this.stageRef = stageRef;
			objects = new Array();
			addObjects();
			
			player = new Player(gameState, stageRef, SuburbScene2, this);
			player.x = 40;
			player.y = 142;
			addChild(player);
			
			suburbForeground = new SuburbForeground2;
			suburbForeground.x = 532,5;
			suburbForeground.y = 337;
			addChild(suburbForeground);
			
			//porcheTimer.start();
			//porcheTimer.addEventListener(TimerEvent.TIMER, porcheTimerTick,false,0,true);
			
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
		
		/*private function porcheTimerTick(timerEvent:TimerEvent):void
		{
			if (player.playerAlive)
			{
				porche = new Porche(SuburbScene2); //Passing current scene to Porche class
				porche.x = 1060;
				porche.y = 420;
				porche.name = "enemy_car_" + objects.length;
				addChild(porche);
				objects.push(porche);
			}
		}*/
		
		public function sceneChange(event:Event)
		{
			if (leaveSuburb2.hitTestObject(player))
			{
				//porcheTimer.stop();
				//porcheTimer.removeEventListener(TimerEvent.TIMER, porcheTimerTick);
				leaveSuburb2.removeEventListener(Event.ENTER_FRAME, sceneChange);
				player.removeEventListeners();
				//porche.removeEventListeners();
				objects = null;
				gameState.slumScene();
				trace("GAME CONTINUE TIME LOOOOOOOOOOOP");
			}
		}
	}
}