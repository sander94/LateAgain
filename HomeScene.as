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
		private var gameState:GameState;
		private var stageRef:Stage;
		public var player:Player;
		public static var objects:Array = new Array();
		private var leaveHome:MovieClip = new LeaveHome;
		
		public function HomeScene(passedClass:GameState, stageRef:Stage)
		{
			gameState = passedClass;
			this.stageRef = stageRef;
			player = new Player(stageRef, HomeScene, this);

			addObjects();

			leaveHome.x = 282;
			leaveHome.y = 193;
			addChild(leaveHome);
			
			player.x = 374;
			player.y = 84;
			addChild(player);
			
			leaveHome.addEventListener(Event.ENTER_FRAME, doorHitTest,false,0,true)
		}
		
		//Add collidable objects to objects array
		public function addObjects()
		{
			var i:uint = 0;
			for (i; i < this.numChildren; i++)
			{
				if (this.getChildAt(i).name.indexOf("object") >= 0 || this.getChildAt(i).name.indexOf("power") >= 0 || this.getChildAt(i).name.indexOf("enemy") >= 0)
				{
					objects.push(this.getChildAt(i))
				}
			}
		}
		
		public function doorHitTest(event:Event)
		{
			if(leaveHome.hitTestObject(player))
			{
				leaveHome.removeEventListener(Event.ENTER_FRAME, doorHitTest)
				gameState.suburbScene();
				trace("WOOOOOOOP")
			}
		}
	}
}