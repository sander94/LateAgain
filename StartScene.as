package
{
	import KeyObject;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class StartScene extends MovieClip
	{

		private var _gameState:GameState;
		private var stageRef:Stage;
		private var key:KeyObject;
		
		public function StartScene(passedClass:GameState, stageRef:Stage)
		{
			key = new KeyObject(stageRef);
			_gameState = passedClass;
			this.stageRef = stageRef;
			
			addEventListener(Event.ENTER_FRAME, pressStart);
		}

		private function pressStart(e:Event)
		{
			if (key.isDown(key.SPACE))
			{
				removeEventListener(Event.ENTER_FRAME, pressStart)
				_gameState.homeScene();
			}
		}
		
	}
}