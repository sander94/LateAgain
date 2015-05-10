package
{
	import KeyObject;
	import flash.display.*;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	public class DownHit extends MovieClip
	{
		private var key:KeyObject;
		private var stageRef:Stage;
		private var gameState:GameState;
		private var curScene;
		private var hitEnemy;
		private var restartText:RestartText;
		
		public function DownHit(passedClass:GameState, stageRef:Stage, enemy, scene)
		{
			gameState = passedClass;
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			curScene = scene;
			hitEnemy = enemy;

			addEventListener(Event.ENTER_FRAME, mainLoop,false,0,true)
		}

		public function hitCheck()
		{
			//If enemy was car, game over
			if (hitEnemy.name.indexOf("car"))
			{
				restartText = new RestartText;
				restartText.x = x;
				restartText.y = y + 22;
				addChild(restartText);

				return false; //Retrun false to set playerAlive in Player class to false
			}
			/*Cheking and processing of hitting other enemies
			else if ()
			{

			}*/
		}
		
		private function mainLoop(e:Event)
		{
			if (key.isDown(key.SPACE))
			{
				var i:uint = 0;
				for (i; i < curScene.numChildren; i++)
				{
					curScene.removeChildAt(i);
				}
				removeEventListener(Event.ENTER_FRAME, mainLoop)
				parent.removeChild(this);
				gameState.startScene();
				curScene.objects = null;
			}
		}
		
	}
}