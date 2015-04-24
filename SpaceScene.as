package
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.display.Stage;
	
	public class SpaceScene extends MovieClip
	{
		private var _gameState:GameState;
		
		private var stageRef:Stage;
		public var _player:Player;
		
		public function SpaceScene()
		{
			super();
		}
	}
}