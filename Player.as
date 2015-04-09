package
{
	import KeyObject;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.*;
	
	public class Player extends Sprite
	{
		private var key:KeyObject;
		
		public function Player(stageRef:Stage)
		{
			

			var key:KeyObject = new KeyObject(stageRef);
			
			//_player.addEventListener(
		}
		
		private function playerLoop():void
		{
			if (key.isDown(key.LEFT))
			{
				//_playerS.x -= 5;
			}
		}
	}
}