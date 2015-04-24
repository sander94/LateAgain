package
{
	import HomeScene;
	
	import KeyObject;
	
	import flash.display.*;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	public class Player extends MovieClip
	{
		private var key:KeyObject;
		private var stageRef:Stage;
		private var speed:Number = 4;
		private var j = 0;
		private var _leftCollision:Boolean = false;
		private var _rightCollision:Boolean = false;
		private var _upCollision:Boolean = false;
		private var _downCollision:Boolean = false;
		private var hitLeft:Point = new Point;
		private var hitRight:Point = new Point;
		private var hitUp:Point = new Point;
		private var hitDown:Point = new Point;
		
		public function Player(stageRef:Stage)
		{
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			
			hitLeft.x = 696;
			hitLeft.y = 170;
			hitLeft=localToGlobal(hitLeft);
			hitRight.x = 744;
			hitRight.y = 170;
			hitRight=localToGlobal(hitRight);
			hitUp.x = 720;
			hitUp.y = 146;
			hitUp=localToGlobal(hitUp);
			hitDown.x = 720;
			hitDown.y = 194;
			hitDown=localToGlobal(hitDown);
			
			addEventListener(Event.ENTER_FRAME, HitTestPointHor)
			addEventListener(Event.ENTER_FRAME, HitTestPointVer)
			//addEventListener(Event.ENTER_FRAME, hitCheck)
		}
		
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
			
		
		private function HitTestPointHor(e:Event)
		{
			j++
			for (var i = 0; i < HomeScene.objects.length; i++)
			{
				if (HomeScene.objects[i].hitTestPoint(hitLeft.x, hitLeft.y, true))
				{
					_leftCollision = true; break;
					trace("hitLEFT" + j);
				}
				else
				{
					_leftCollision = false;
				}
				if (HomeScene.objects[i].hitTestPoint(hitRight.x, hitRight.y, true))
				{
					_rightCollision = true; break;
					trace("hitRIGHT" + j);
				}
				else
				{
					_rightCollision = false;
				}
			}
		}
		private function HitTestPointVer(e:Event)
		{
			j++
			for (var i = 0; i < HomeScene.objects.length; i++)
			{
				if (HomeScene.objects[i].hitTestPoint(hitUp.x, hitUp.y, true))
				{
					_upCollision = true; break;
					trace("hitUP" + j);
				}
				else
				{
					_upCollision = false;
				}
				if (HomeScene.objects[i].hitTestPoint(hitDown.x, hitDown.y, true))
				{
					_downCollision = true; break;
					trace("hitDOWN" + j);
				}
				else
				{
					_downCollision = false;
				}
			}
			
			
			addEventListener(Event.ENTER_FRAME, playerLoop)
		}
		
		private function playerLoop(e:Event)
		{

			if (key.isDown(key.SHIFT))
			{
				speed = 8;
			}
			else
			{
				speed = 4;
			}
			
			if (key.isDown(key.LEFT) || key.isDown(key.A))
			{
				if (_leftCollision)
				{
					trace("Left is Blocked")
				}
				else
				{
					x -= speed;
					hitDown.x -= speed;
					hitUp.x -= speed;
					hitLeft.x -= speed;
					hitRight.x -= speed;
					this.rotation = -90;
				}
			}
			if (key.isDown(key.RIGHT) || key.isDown(key.D))
			{
				if (_rightCollision)
				{
					trace("Right is Blocked")
				}
				else
				{
					x += speed;
					hitDown.x += speed;
					hitUp.x += speed;
					hitLeft.x += speed;
					hitRight.x += speed;
					this.rotation = 90;
				}
			}
			if (key.isDown(key.UP) || key.isDown(key.W))
			{
				if (_upCollision)
				{
					trace("Up is Blocked")
				}
				else
				{
					y -= speed;
					hitDown.y -= speed;
					hitUp.y -= speed;
					hitLeft.y -= speed;
					hitRight.y -= speed;
					this.rotation = 0;
				}
			}
			if (key.isDown(key.DOWN) || key.isDown(key.S))
			{
				if(_downCollision)
				{
					trace("Down is Blocked")
				}
				else
				{
					y += speed;
					hitDown.y += speed;
					hitUp.y += speed;
					hitLeft.y += speed;
					hitRight.y += speed;
					this.rotation = 180;
				}
			}
			if ((key.isDown(key.LEFT) || key.isDown(key.A)) && (key.isDown(key.UP) || key.isDown(key.W)))
			{
				this.rotation = -45;
			}
			if ((key.isDown(key.LEFT) || key.isDown(key.A)) && (key.isDown(key.DOWN) || key.isDown(key.S)))
			{
				this.rotation = -135;
			}
			if ((key.isDown(key.RIGHT) || key.isDown(key.D)) && (key.isDown(key.UP) || key.isDown(key.W)))
			{
				this.rotation = 45;
			}
			if ((key.isDown(key.RIGHT) || key.isDown(key.D)) && (key.isDown(key.DOWN) || key.isDown(key.S)))
			{
				this.rotation = 135;
			}
		}

	}
}