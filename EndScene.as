package
{
	import KeyObject;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.geom.Rectangle;

	public class EndScene extends MovieClip
	{
		private var key:KeyObject;
		private var stageRef:Stage;
		private var gameState:GameState;

		public function EndScene(passedClass:GameState, stageRef:Stage)
		{
			trace("EndScene");
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			gameState = passedClass;
			
			scoreboard.text = String(gameState.gameTimeRemaining);
			
			addEventListener(Event.ENTER_FRAME, mainLoop);
			addEventListener(Event.ENTER_FRAME, sceneChange);
		}

		private function mainLoop(e:Event)
		{
			root.scrollRect = new Rectangle(0, 0, stageRef.stageWidth, stageRef.stageHeight); //needed to center the scene
		}

		private function sceneChange(e:Event)
		{
			if (key.isDown(key.SPACE))
			{
				removeEventListener(Event.ENTER_FRAME, sceneChange);
				gameState.startScene();
			}
		}
	}
}