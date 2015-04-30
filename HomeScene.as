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
		
		public function HomeScene(passedClass:GameState, stageRef:Stage)
		{
			
			_gameState = passedClass;
			this.stageRef = stageRef;
			_player = new Player(stageRef, HomeScene);
			/*trace(desk_mc.x +  " " + desk_mc.y)
			trace(desk_mc.width + " " + desk_mc.height)
			trace(bed_mc.x + " " + bed_mc.y)
			trace(bed_mc.width + " " + bed_mc.height)*/
			objects.push(desk_mc, bed_mc, drawers_mc, trashcan_mc, cabinet_mc, table_mc, chair_mc)

			_player.x = 720;
			_player.y = 170;
			addChild(_player);

			_door.addEventListener(Event.ENTER_FRAME, doorHitTest)
			
			addEventListener(Event.ENTER_FRAME, cameraFollowPlayer);//Temporary camera code, not needed for homeScene
		}
		
		//Temporary camera code, not needed for homeScene
		public function cameraFollowPlayer(evt:Event)
		{
			root.scrollRect = new Rectangle(_player.x - stage.stageWidth/2, _player.y - stage.stageHeight/2, stage.stageWidth, stage.stageHeight);
		}
		
		public function doorHitTest(event:Event)
		{
			if(_door.hitTestObject(_player))
			{
				trace("WOOOOOOOP")
				removeEventListener(Event.ENTER_FRAME, cameraFollowPlayer);
				_gameState.suburbScene();
			}
		}
	}
}