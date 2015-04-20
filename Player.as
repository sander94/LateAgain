package
{
	import HomeScene;
	import KeyObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import flash.ui.Keyboard;
	
	public class Player extends MovieClip
	{
		private var key:KeyObject;
		private var stageRef:Stage;
		private var speed:Number = 4;
		private var j = 0;
		
		public function Player(stageRef:Stage)
		{
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			
			addEventListener(Event.ENTER_FRAME, hitCheck)
		}
		
		private function hitCheck(e:Event)
		{
			j++;
			for (var i = 0; i < HomeScene.objects.length; i++) 
			{
				var hitRangeX:Number = HomeScene.objects[i].width / 2;
				var hitRangeY:Number = HomeScene.objects[i].height / 2;
				
				if (y + height/2 > HomeScene.objects[i].y - hitRangeY && y - height/2 < HomeScene.objects[i].y + hitRangeY)
				{
					if (x + width/2 > HomeScene.objects[i].x - hitRangeX && x - width/2 < HomeScene.objects[i].x + hitRangeX)
					{
						trace("Hit " + HomeScene.objects[i] + j)
					}
				}
			}
			addEventListener(Event.ENTER_FRAME, playerLoop)
		}
		
		private function playerLoop(e:Event)
		{
			if (key.isDown(key.SHIFT))
			{
				speed = 10;
			}
			else
			{
				speed = 4;
			}
			if (key.isDown(key.LEFT) || key.isDown(key.A))
			{
				x -= speed;
			}
			if (key.isDown(key.RIGHT) || key.isDown(key.D))
			{
				x += speed;
			}
			if (key.isDown(key.UP) || key.isDown(key.W))
			{
				y -= speed;
			}
			if (key.isDown(key.DOWN) || key.isDown(key.S))
			{
				y += speed;
			}
		}
	}
}