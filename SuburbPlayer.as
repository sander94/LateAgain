package
{
	import KeyObject;
	
	import SuburbScene;
	
	import flash.display.*;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	public class SuburbPlayer extends MovieClip
	{ 
		private var key:KeyObject;
		private var stageRef:Stage;
		private var parentClass:SuburbScene;
		
		private var speed:Number = 4;
		private var j = 0;
		private var _leftCollision:Boolean = false;
		private var _rightCollision:Boolean = false;
		private var _upCollision:Boolean = false;
		private var _downCollision:Boolean = false;
		private var animationState:String = "down_stop";
		private var lastDirection:String = "down_stop"; 	// player facing when not moving
		private var maxStamina:int = 1200;					// sprint meter and cooldown variables for Shift key
		private var minStamina:int = 0;
		private var currentStamina:int = maxStamina;
		private var cooldown:Boolean = false;
		private var hitLeft:MovieClip = new HitLeft;		// collision detection movieclips, alpha at 1%
		private var hitRight:MovieClip = new HitRight;
		private var hitDown:MovieClip = new HitDown;
		private var hitUp:MovieClip = new HitUp;
		
		public function SuburbPlayer(stageRef:Stage, passedClass:SuburbScene)
		{
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			parentClass = passedClass;
			
			hitLeft.x = this.x;
			hitLeft.y = this.y;
			hitLeft.x -= 6;
			addChild(hitLeft);
			
			hitRight.x = this.x;
			hitRight.y = this.y;
			hitRight.x += 6;
			addChild(hitRight);
			
			hitDown.x = this.x;
			hitDown.y = this.y;
			hitDown.y += 10;
			addChild(hitDown);
			
			hitUp.x = this.x;
			hitUp.y = this.y;
			hitUp.y -= 10;
			addChild(hitUp);
			

			addEventListener(Event.ENTER_FRAME, HitTestPointHor,false,0,true)
			addEventListener(Event.ENTER_FRAME, HitTestPointVer,false,0,true)
			addEventListener(Event.ENTER_FRAME, playerLoop,false,0,true)
			//addEventListener(Event.ENTER_FRAME, hitCheck) -- Moved alternative collision detection code to SpaceScene --
			
		}
		
		private function HitTestPointHor(e:Event)
		{
			j++
			for (var i = 0; i < SuburbScene.objects.length; i++)
			{
				if (SuburbScene.objects[i].hitTestObject(hitLeft))
				{
					_leftCollision = true; break;
					//trace("hitLEFT" + j);
				}
				else
				{
					_leftCollision = false;
				}
				if (SuburbScene.objects[i].hitTestObject(hitRight))
				{
					_rightCollision = true; break;
					//trace("hitRIGHT" + j);
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
			for (var i = 0; i < SuburbScene.objects.length; i++)
			{
				if (SuburbScene.objects[i].hitTestObject(hitUp))
				{
					_upCollision = true; break;
					//trace("hitUP" + j);
				}
				else
				{
					_upCollision = false;
				}
				if (SuburbScene.objects[i].hitTestObject(hitDown))
				{
					_downCollision = true; break;
					//trace("hitDOWN" + j);
				}
				else
				{
					_downCollision = false;
				}
			}
			
			

		}
		
		private function playerLoop(e:Event)
		{
			
			if (key.isDown(key.SHIFT) && !cooldown)
			{
				if (currentStamina > minStamina)
				{
					currentStamina -= 20;
					//trace(currentStamina)
				}
				else if (currentStamina == minStamina)
				{
					cooldown = true;
					trace("SPRINT COOLDOWN")
				}
				speed = 4;
			}
			else
			{
				if (currentStamina < maxStamina)
				{
					currentStamina += 10;
					//trace(currentStamina)
				}
				else if (currentStamina == maxStamina)
				{
					cooldown = false;
				}
				speed = 2;
			}
			
			if (key.isDown(key.LEFT) || key.isDown(key.A))
			{
				//PlayerAnimation(leftWalk, true)
				
				if (_leftCollision)
				{
					animationState = "left_move";
					//trace("Left is Blocked")
				}
				else
				{
					animationState = "left_move";
					lastDirection = "left_stop";
					x -= speed;
					if (parentClass.x <= -2 && parentClass.x >= -480 && x <= 720)
					{
						parentClass.x += speed;
					}
				}
			}
			if (key.isDown(key.RIGHT) || key.isDown(key.D))
			{
				//PlayerAnimation(rightWalk, true)
				
				if (_rightCollision)
				{
					animationState = "right_move";
					//trace("Right is Blocked")
				}
				else
				{
					animationState = "right_move";
					lastDirection = "right_stop";
					x += speed;
					if (parentClass.x >= -478 && x >= 240)
					{
						parentClass.x -= speed;
					}
					trace(x)
				}
			}
			if (key.isDown(key.UP) || key.isDown(key.W))
			{
				//PlayerAnimation(upWalk, true)
				
				if (_upCollision)
				{
					animationState = "up_move";
					//trace("Up is Blocked")
				}
				else
				{
					animationState = "up_move";
					lastDirection = "up_stop";
					y -= speed;
					if (parentClass.y <= 180 && y <= 180)
					{
						parentClass.y += speed;
					}
				}
			}
			if (key.isDown(key.DOWN) || key.isDown(key.S))
			{
				//PlayerAnimation(downWalk, true)
				
				
				if(_downCollision)
				{
					animationState = "down_move";
					//trace("Down is Blocked")
				}
				else
				{
					animationState = "down_move";
					lastDirection = "down_stop";
					y += speed;
					if (parentClass.y >= -12 && y >= 0)
					{
						parentClass.y -= speed;
					}
				}
			}
			
			if (!(key.isDown(key.DOWN) || key.isDown(key.S) || key.isDown(key.UP) || key.isDown(key.W) || key.isDown(key.RIGHT) || key.isDown(key.D) || key.isDown(key.LEFT) || key.isDown(key.A)))
			{
				animationState = lastDirection;
			}
			
			if(this.currentLabel != animationState){
				this.gotoAndStop(animationState);
			}
			
		}
		public function dispose()
		{
			stop();
			stage.removeEventListener(Event.ENTER_FRAME, HitTestPointHor)
			stage.removeEventListener(Event.ENTER_FRAME, HitTestPointVer)
			stage.removeEventListener(Event.ENTER_FRAME, playerLoop)
			removeEventListener(Event.ENTER_FRAME, HitTestPointHor)
			removeEventListener(Event.ENTER_FRAME, HitTestPointVer)
			removeEventListener(Event.ENTER_FRAME, playerLoop)
				
		}
		
	}
}