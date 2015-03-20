package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class HomeScene extends Sprite
	{
		private var _gameState:GameState;
		private var _player:Sprite = new Player;
		private var _drawer1:Sprite = new Drawer;
		private var _drawer2:Sprite = new Drawer;
		private var _drawer3:Sprite = new Drawer;
		private var _drawer4:Sprite = new Drawer;
		private var _cabinet1:Sprite = new CabinetDoor;
		private var _cabinet2:Sprite = new CabinetDoor;
		private var _door:Sprite = new Door;
		
		public function HomeScene(passedClass:GameState)
		{
			_gameState = passedClass;
			placePlayer();
			placeDoors();
		}
		
		private function placeDoors():void
		{
			_drawer1.x = 0;
			_drawer1.y = 150;
			
			_drawer2.x = 100;
			_drawer2.y = 150;
			
			_drawer3.x = 200;
			_drawer3.y = 150;
			
			_drawer4.x = 300;
			_drawer4.y = 150;
			
			_cabinet1.x = 0;
			_cabinet1.y = 250;
			
			_cabinet2.x = 100;
			_cabinet2.y = 250;
			
			addChild(_drawer1);
			addChild(_drawer2);
			addChild(_drawer3);
			addChild(_drawer4);
			addChild(_cabinet1);
			addChild(_cabinet2);
			addChild(_door);
		}
		
		private function placePlayer()
		{
			_player.x = 740;
			_player.y = 150;
			
			addChild(_player);
		}
	}
}