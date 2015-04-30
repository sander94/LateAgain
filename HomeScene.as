package
{

	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.geom.Rectangle; //Temporary camera code, not needed for homeScene
	
	public class HomeScene extends MovieClip
	{
		private var _gameState:GameState;
		private var stageRef:Stage;
		public var _player:Player;
		
		public static var objects:Array = new Array();
		
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
			this.stageRef = stageRef;
			_player = new Player(stageRef, HomeScene);
			/*trace(desk_mc.x +  " " + desk_mc.y)
			trace(desk_mc.width + " " + desk_mc.height)
			trace(bed_mc.x + " " + bed_mc.y)
			trace(bed_mc.width + " " + bed_mc.height)*/
			objects.push(desk_mc, bed_mc, drawers_mc, trashcan_mc, cabinet_mc, table_mc, chair_mc, power_energy_mc, power_coffee_mc, enemy_car_mc)
			
			makeRoom();

			_player.x = 720;
			_player.y = 170;
			addChild(_player);
			
			addEventListener(Event.ENTER_FRAME, cameraFollowCharacter);//Temporary camera code, not needed for homeScene
		}
		
		//Temporary camera code, not needed for homeScene
		public function cameraFollowCharacter(evt:Event)
		{
			root.scrollRect = new Rectangle(_player.x - stage.stageWidth/2, _player.y - stage.stageHeight/2, stage.stageWidth, stage.stageHeight);
		}

		public function makeRoom()
		{
			trace("in makeRoom");
			_door.x = 196;
			_door.y = 478;
			addChild(_door);
			
			_door.addEventListener(Event.ENTER_FRAME, doorHitTest)
		}
		
		public function doorHitTest(event:Event)
		{
			if(_door.hitTestObject(_player))
			{
				trace("WOOOOOOOP")
			}
		}
	}
}