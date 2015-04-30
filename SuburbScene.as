package
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.geom.Rectangle;
	
	public class SuburbScene extends MovieClip
	{
		private var _gameState:GameState;
		
		private var stageRef:Stage;
		public var _player:Player;
		private var treeBatch:SuburbTreesBatch;
		
		public static var objects:Array = new Array();
		
		
		public function SuburbScene(passedClass:GameState, stageRef:Stage)
		{
			_gameState = passedClass;
			this.stageRef = stageRef;
			
			_player = new Player(stageRef, SuburbScene);
			_player.x = 720;
			_player.y = 170;
			addChild(_player);
			
			objects.push(tree_collision01, tree_collision02, tree_collision03, tree_collision04, tree_collision05, tree_collision06, 
							tree_collision07, tree_collision08, tree_collision09, tree_collision10, tree_collision11, tree_collision12, tree_collision13, tree_collision14)
			
			treeBatch = new SuburbTreesBatch;
			treeBatch.x = 446;
			treeBatch.y = 181;
			addChild(treeBatch);

			addEventListener(Event.ENTER_FRAME, cameraFollowPlayer);
		}
		
		public function cameraFollowPlayer(evt:Event)
		{
			root.scrollRect = new Rectangle(_player.x - stage.stageWidth/2, _player.y - stage.stageHeight/2, stage.stageWidth, stage.stageHeight);
		}
	}
}