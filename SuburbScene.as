package
{
	import SuburbPlayer;
	import KeyObject;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class SuburbScene extends MovieClip
	{
		private var gameState:GameState;
		private var stageRef:Stage;
		public var player:Player;
		
		private var treeBatch:SuburbTreesBatch;					// Layering the objects on with in batches so they can appear on top of the player object
		private var streetLightBatch:SubStreetLightBatch;
		private var bushBatch:SubBushBatch;
		private var houseBatch:SubHouseBatch;
		private var subSign:SubSign;
		private var subPorche:SubPorche;
		private var porcheTimer:Timer = new Timer(2000);		// 1000ms == 1second
		
		public static var carList:Array = new Array ();
		public static var objects:Array = new Array();
		
		public function SuburbScene(passedClass:GameState, stageRef:Stage)
		{
			gameState = passedClass;
			this.stageRef = stageRef;
			
			player = new Player(stageRef, SuburbScene, this);
			player.x = 131;
			player.y = 150;
			addChild(player);
			
			addObjects();
			
			houseBatch = new SubHouseBatch;
			houseBatch.x = 451;
			houseBatch.y = -41;
			addChild(houseBatch);
			
			subSign = new SubSign;
			subSign.x = 357;
			subSign.y = 196;
			addChild(subSign);
			
			bushBatch = new SubBushBatch;
			bushBatch.x = 462;
			bushBatch.y = 17;
			addChild(bushBatch);
			
			treeBatch = new SuburbTreesBatch;
			treeBatch.x = 446;
			treeBatch.y = 12;
			addChild(treeBatch);
			
			streetLightBatch = new SubStreetLightBatch;
			streetLightBatch.x = 479;
			streetLightBatch.y = 48;
			addChild(streetLightBatch);
			
			porcheTimer.start();
			porcheTimer.addEventListener( TimerEvent.TIMER, porcheTimerTick,false,0,true );
			//_player.addEventListener(Event.ENTER_FRAME, carHitTest,false,0,true);
			
		}
		
		//Add collidable objects to objects array
		public function addObjects()
		{
			var i:uint = 0;
			for (i; i < this.numChildren; i++)
			{
				if (this.getChildAt(i).name.indexOf("object") >= 0 || this.getChildAt(i).name.indexOf("power") >= 0 || this.getChildAt(i).name.indexOf("enemy") >= 0)
				{
					objects.push(this.getChildAt(i))
				}
			}
		}
		
		public function porcheTimerTick( timerEvent:TimerEvent ):void
		{
			subPorche = new SubPorche;
			subPorche.x = 1060;
			subPorche.y = 270;
			subPorche.name = "enemy_car_" + carList.length;
			addChild(subPorche);
			carList.push(subPorche)
		}
		
		/*protected function carHitTest(event:Event):void
		{
			for (var i = 0; i < carList.length; i++)
			{
				if (carList[i].hitTestObject(_player))
				{
					porcheTimer.removeEventListener(TimerEvent.TIMER, porcheTimerTick);
					_player.removeEventListener(Event.ENTER_FRAME, carHitTest);
					lastX = _player.x;
					lastY = _player.y;
					playerAlive = false;
					deadPlayer = new DeadPlayer(_gameState, stage);
					deadPlayer.x = lastX;
					deadPlayer.y = lastY;
					_player.dispose();
					removeChild(_player);
					addChild(deadPlayer);
				}
			}
		}*/
		
	}
}