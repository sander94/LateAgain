package
{
	import flash.display.*;
	/*import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;*/
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class HomeScene extends MovieClip
	{
		private var _gameState:GameState;
		private var stageRef:Stage;
		private var _player:Player;
		public static var objects:Array = new Array();
		/*private var _drawer1:Sprite = new Drawer;
		private var _drawer2:Sprite = new Drawer;
		private var _drawer3:Sprite = new Drawer;
		private var _drawer4:Sprite = new Drawer;
		private var _cabinet1:Sprite = new CabinetDoor;
		private var _cabinet2:Sprite = new CabinetDoor;
		private var _door:Sprite = new Door;*/
		
		public function HomeScene(passedClass:GameState, stageRef:Stage)
		{
			this.stageRef = stageRef;
			_player = new Player(stageRef);
			_gameState = passedClass;
			trace(desk_mc.x +  " " + desk_mc.y)
			trace(desk_mc.width + " " + desk_mc.height)
			objects.push(desk_mc)
			makeRoom();

			_player.x = 720;
			_player.y = 170;
			addChild(_player);
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