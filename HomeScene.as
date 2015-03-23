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
		private var _desk:Sprite = new Desk;
		private var _drawers:Sprite = new Drawers;
		private var _bed:Sprite = new Bed;
		private var _cabinet:Sprite = new Cabinet;
		private var _chair:Sprite = new Chair;
		private var _walls:Sprite = new Walls;
		private var _table:Sprite = new Table;
		private var _trashcan:Sprite = new Trashcan;
		private var _floor:Sprite = new Floor;
		
		public function HomeScene(passedClass:GameState)
		{
			_gameState = passedClass;
			placePlayer();
			makeRoom();
			
			this.addEventListener(KeyboardEvent.KEY_DOWN,playerInput);
		}
		
		private function makeRoom()
		{
			_floor.x = 62;
			_floor.y = 62;
			
			_walls.x = -62;
			_walls.y = -62;
			
			_chair.x = 202;
			_chair.y = 180;
			
			_door.x = 117;
			_door.y = 479;
			
			_drawer1.y = 105;
			_drawer1.rotationX = 180;
			
			_drawer2.x = 247;
			_drawer2.y = 105;
			_drawer2.rotationX = 180;
			
			_drawer3.x = 200;
			_drawer3.y = 150;
			
			_drawer4.x = 300;
			_drawer4.y = 150;
			
			_cabinet1.x = 0;
			_cabinet1.y = 250;
			
			_cabinet2.x = 100;
			_cabinet2.y = 250;
			
			addChild(_floor);
			_floor.addChild(_walls);
			_floor.addChildAt(_desk, 2);
			_floor.addChildAt(_drawer1, 1);
			_floor.addChildAt(_drawer2, 1);
			_walls.addChild(_door);
			_walls.addChild(_chair);
			/*addChild(_drawer3);
			addChild(_drawer4);
			addChild(_cabinet1);
			addChild(_cabinet2);*/
			
		}
		
		private function placePlayer()
		{
			_player.x = 740;
			_player.y = 150;
			
			_walls.addChild(_player);
		}
		
		private function playerInput(event:KeyboardEvent)
		{
			/*if (evemt.Key = )
			{
				
			}*/
		}
	}
}