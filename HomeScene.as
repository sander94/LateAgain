package
{

	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
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
		private var leaveHome:MovieClip = new LeaveHome;
		
		public function HomeScene(passedClass:GameState, stageRef:Stage)
		{
			_gameState = passedClass;
			this.stageRef = stageRef;
			_player = new Player(stageRef);

			objects.push(wallBlock01, wallBlock02, wallBlock03, wallBlock04, furnitureBlock01, furnitureBlock02, furnitureBlock03, furnitureBlock04)

			leaveHome.x = 282;
			leaveHome.y = 193;
			addChild(leaveHome);
			
			_player.x = 374;
			_player.y = 84;
			addChild(_player);
			
			leaveHome.addEventListener(Event.ENTER_FRAME, doorHitTest,false,0,true)
		}
		
		public function doorHitTest(event:Event)
		{
			if(leaveHome.hitTestObject(_player))
			{
				leaveHome.removeEventListener(Event.ENTER_FRAME, doorHitTest)
				_gameState.suburbScene();
				trace("WOOOOOOOP")
			}
		}
	}
}