package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class HomeScene extends Sprite
	{
		private var _gameState:GameState;
		public var _player:Object;
		private var _drawer1:Sprite = new Drawer;
		private var _drawer2:Sprite = new Drawer;
		private var _drawer3:Sprite = new Drawer;
		private var _drawer4:Sprite = new Drawer;
		private var _cabinet1:Sprite = new CabinetDoor;
		private var _cabinet2:Sprite = new CabinetDoor;
		private var _door:Sprite = new Door;
		
		public function HomeScene(passedClass:GameState, stageRef:Stage)
		{
			
			_gameState = passedClass;
			makeRoom();
			_player = new Player(stageRef);
			
		}
		
		private function makeRoom()
		{
			/*addChild(_drawer1);
			addChild(_drawer2);
			addChild(_door);
			/*addChild(_drawer3);
			addChild(_drawer4);
			addChild(_cabinet1);
			addChild(_cabinet2);*/
			
		}
	}
}