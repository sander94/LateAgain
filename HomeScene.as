package
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class HomeScene extends MovieClip
	{
		private var gameState:GameState;
		private var stageRef:Stage;
		public var player:Player;
		public static var objects:Array;
		
		public function HomeScene(passedClass:GameState, stageRef:Stage)
		{
			gameState = passedClass;
			this.stageRef = stageRef;
			objects = new Array();
			addObjects();

			player = new Player(gameState, stageRef, HomeScene, this, 374, 84);
			player.x = 374;
			player.y = 84;
			addChild(player);
			
			gameState.volume.volume = 0.6;
			
			leaveHome.addEventListener(Event.ENTER_FRAME, sceneChange,false,0,true);//leaveHome not needed to be defined as a varialbe as it is already placed and named in the scene
		}
		
		//Add collidable objects to objects array
		public function addObjects()
		{
			var i:uint = 0;
			for (i; i < this.numChildren; i++)
			{
				if (this.getChildAt(i).name.indexOf("object") >= 0 || this.getChildAt(i).name.indexOf("power") >= 0 || this.getChildAt(i).name.indexOf("enemy") >= 0)
				{
					objects.push(this.getChildAt(i));
				}
			}
		}

		public function sceneChange(event:Event)
		{
			if (leaveHome.hitTestObject(player))//leaveHome not needed to be defined as a varialbe as it is already placed and named in the scene
			{
				leaveHome.removeEventListener(Event.ENTER_FRAME, sceneChange);
				player.removeEventListeners();
				objects = null;
				gameState.musicChannel.stop();
				gameState.suburbScene();
				trace("WOOOOOOOP");
			}
		}
	}
}