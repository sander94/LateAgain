package
{
	import StartScene;
	
	import KeyObject;
	
	import flash.display.*;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	public class SsPlayer extends MovieClip
	{
		
		private var _gameState:GameState;
		private var key:KeyObject;
		private var stageRef:Stage;
		
		public function SsPlayer(passedClass:GameState, stageRef:Stage)
		{
			
			_gameState = passedClass;
			trace("In Ssplayer")
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			
			addEventListener(Event.ENTER_FRAME, playerLoop)
		}
		
		private function playerLoop(e:Event)
		{
			if (key.isDown(key.SPACE))
			{
				removeEventListener(Event.ENTER_FRAME, playerLoop)
				_gameState.homeScene();
			}
		}
		
	}
}