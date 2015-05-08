package
{
	import KeyObject;
	import SuburbScene;
	
	import flash.display.*;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	public class DeadPlayer extends MovieClip
	{
		
		private var _gameState:GameState;
		private var key:KeyObject;
		private var stageRef:Stage;
		private var startText:SubStartText;
		
		public function DeadPlayer(passedClass:GameState, stageRef:Stage)
		{
			
			_gameState = passedClass;
			trace("In Ssplayer")
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			
			startText = new SubStartText;
			startText.x = x;
			startText.y = y;
			startText.y += 22;
			addChild(startText);
			
			addEventListener(Event.ENTER_FRAME, playerLoop,false,0,true)
		}
		
		private function playerLoop(e:Event)
		{
			if (key.isDown(key.SPACE))
			{
				removeEventListener(Event.ENTER_FRAME, playerLoop)
				this.parent.removeChild(this);
				_gameState.homeScene();
			}
		}
		
	}
}