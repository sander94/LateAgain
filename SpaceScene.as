package
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.display.Stage;
	
	public class SpaceScene extends MovieClip
	{
		private var _gameState:GameState;
		
		private var stageRef:Stage;
		public var _player:Player;
		
		public function SpaceScene()
		{
			/*private function hitCheck(e:Event)
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
			_collision = true;
			upBlocked = false;
			downBlocked = false;
			upBlocked = false;
			downBlocked = false;
			trace("Hit " + HomeScene.objects[i] + j)
			
			if (HomeScene.objects[i].y + hitRangeY > hitUp.y && HomeScene.objects[i].x + hitRangeX > hitUp.x && HomeScene.objects[i].x - hitRangeX < hitUp.x)
			{
			upBlocked = true;
			}
			else
			{
			upBlocked = false;
			}
			if ((HomeScene.objects[i].y - hitRangeY) <= hitDown.y)
			{
			downBlocked = true;
			}
			else if ((HomeScene.objects[i].y - hitRangeY) > hitDown.y)
			{
			downBlocked = false;
			}
			if ((HomeScene.objects[i].x + hitRangeX) >= hitRight.x)
			{
			leftBlocked = true;
			}
			else if ((HomeScene.objects[i].x + hitRangeX) < hitRight.x)
			{
			leftBlocked = false;
			}
			if ((HomeScene.objects[i].x - hitRangeX) <= hitLeft.x)
			{
			rightBlocked = true;
			}
			else if ((HomeScene.objects[i].x - hitRangeX) > hitLeft.x)
			{
			rightBlocked = false;
			}
			}
			else
			{
			_collision = false;
			}
			
			}
			
			}
			
			addEventListener(Event.ENTER_FRAME, playerLoop)
			
			}*/
			
		}
	}
}