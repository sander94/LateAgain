package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	public class HomeScene extends Sprite
	{
		private var _gameState:GameState;
		private var _player:Sprite = new Player;
		private var _drawer1:Sprite = new DrawerM;
		private var _drawer2:Sprite = new DrawerM;
		private var _drawer3:Sprite = new Drawer;
		private var _drawer4:Sprite = new Drawer;
		private var _cabinetDoor1:Sprite = new CabinetDoor;
		private var _cabinetDoor2:Sprite = new CabinetDoorM;
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
		
		trace("in HomeScene")
		
		public function HomeScene(passedClass:GameState, stageRef:Stage)
		{
			_gameState = passedClass;
			placePlayer();
			makeRoom();
			
			stageRef.addEventListener(KeyboardEvent.KEY_DOWN, playerInput);
		}
		
		private function makeRoom()
		{
			//Create the room
			_floor.x = 62;
			_floor.y = 62;
			
			_walls.x = -62;
			_walls.y = -62;
			
			_desk.x = 62;
			_desk.y = 62;
			
			_chair.x = 202;
			_chair.y = 180;
			
			_door.x = 117;
			_door.y = 479;
			
			_drawer1.x = 62;
			_drawer1.y = 85;
			
			_drawer2.x = 311;
			_drawer2.y = 85;
			
			_drawers.x = 322;
			_drawers.y = 398;
			
			_drawer3.x = 321;
			_drawer3.y = 395;
			
			_drawer4.x = 449;
			_drawer4.y = 395;
			
			_cabinet.x = 786;
			_cabinet.y = 281;
			
			_cabinetDoor1.x = 786;
			_cabinetDoor1.y = 281;
			
			_cabinetDoor2.x = 786;
			_cabinetDoor2.y = 478;
			
			_bed.x = 803;
			_bed.y = 62;
			
			_table.x = 721;
			_table.y = 79;
			
			_trashcan.x = 456;
			_trashcan.y = 99;
			
			addChild(_floor);
			_floor.addChild(_walls);
			_walls.addChildAt(_desk, 2);
			_walls.addChildAt(_drawer1, 1);
			_walls.addChildAt(_drawer2, 1);
			_walls.addChild(_door);
			_walls.addChild(_chair);
			_walls.addChildAt(_drawers, 2);
			_walls.addChildAt(_drawer3, 1);
			_walls.addChildAt(_drawer4, 1);
			_walls.addChildAt(_cabinet, 2);
			_walls.addChildAt(_cabinetDoor1, 3);
			_walls.addChildAt(_cabinetDoor2, 3);
			_walls.addChildAt(_bed, 1)
			_walls.addChildAt(_table, 1)
			_walls.addChildAt(_trashcan, 1)
		}//end makeRoom
		
		private function placePlayer()
		{
			_player.x = 740;
			_player.y = 150;
			
			_walls.addChild(_player);
		}//end placePlayer
		
		private function playerInput(event:KeyboardEvent)
		{
			//Process player input
			
			var key:uint = event.keyCode;
			var step:uint = 5
			
			switch (key) {
				case Keyboard.LEFT:
				case Keyboard.A:
					_player.x -= step;
					break;
				case Keyboard.RIGHT:
				case Keyboard.D:
					_player.x += step;
					break;
				case Keyboard.UP:
				case Keyboard.W:
					_player.y -= step;
					break;
				case Keyboard.DOWN:
				case Keyboard.S:
					_player.y += step;
					break;
			}

		}//end playerInput
	}
}