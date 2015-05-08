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
		private var _gameState:GameState;
		private var stageRef:Stage;
		public var _player:SuburbPlayer;
		
		private var treeBatch:SuburbTreesBatch;					// Layering the objects on with in batches so they can appear on top of the player object
		private var streetLightBatch:SubStreetLightBatch;
		private var bushBatch:SubBushBatch;
		private var houseBatch:SubHouseBatch;
		private var subSign:SubSign;
		private var subPorche:SubPorche;
		private var porcheTimer:Timer = new Timer(2000);		// 1000ms == 1second
		
		public static var carList:Array = new Array ();
		public static var objects:Array = new Array();
		
		private var j = 0;
		private var lastX:Number;
		private var lastY:Number;
		public static var playerAlive:Boolean = true;
		private var deadPlayer:DeadPlayer;
		
		public function SuburbScene(passedClass:GameState, stageRef:Stage)
		{
			_gameState = passedClass;
			this.stageRef = stageRef;
			
			playerAlive = true;
			_player = new SuburbPlayer(stageRef, this);
			_player.x = 131;
			_player.y = 150;
			addChild(_player);
			
			objects.push(tree_collision01, tree_collision02, tree_collision03, tree_collision04, tree_collision05, tree_collision06, 
							tree_collision07, tree_collision08, tree_collision09, tree_collision10, tree_collision11, tree_collision12, 
							tree_collision13, tree_collision14, tree_collision15, strLight_collision01, strLight_collision02, strLight_collision03, strLight_collision04, 
							strLight_collision05, strLight_collision06, strLight_collision07, strLight_collision08, strLight_collision09, subFountain,
							bush_block01, bush_block02, bush_block03, bush_block04, bush_block05, bush_block06, bush_block07, bush_block08,
							house01_collision, house02_collision, house03_collision, sign_collision, screenBlock01, screenBlock02, screenBlock03, screenBlock04)
			
			
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
			_player.addEventListener(Event.ENTER_FRAME, carHitTest,false,0,true);
			
		}
		
		public function porcheTimerTick( timerEvent:TimerEvent ):void
		{
			subPorche = new SubPorche;
			subPorche.x = 1060;
			subPorche.y = 270;
			addChild(subPorche);
			carList.push(subPorche)
			//trace(carList)
		}
		
		protected function carHitTest(event:Event):void
		{
			j++
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
			

		}
		
	}
}