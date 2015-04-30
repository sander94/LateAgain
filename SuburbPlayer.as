package
{
	import SuburbScene;
	import KeyObject;
	
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
		private var animationState:String = "down_stop";
		private var lastDirection:String = "down_stop"; 	// player facing when not moving
		private var maxStamina:int = 1200;					// sprint meter and cooldown variables for Shift key
		private var minStamina:int = 0;
		private var currentStamina:int = maxStamina;
		private var cooldown:Boolean = false;
		/*private var downStop:String = "down_stop";
		private var downWalk:String = "down_walk";
		private var upStop:String = "up_stop";
		private var upWalk:String = "up_walk";
		private var leftStop:String = "left_stop";
		private var leftWalk:String = "left_walk";
		private var rightStop:String = "right_stop";
		private var rightWalk:String = "right_walk"; 		-- Old animation variables -- */
		
		public function SuburbPlayer(stageRef:Stage)
		{
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			
			hitLeft.x = 698;
			hitLeft.y = 170;
			hitLeft=localToGlobal(hitLeft);
			hitRight.x = 742;
			hitRight.y = 170;
			hitRight=localToGlobal(hitRight);
			hitUp.x = 720;
			hitUp.y = 148;
			hitUp=localToGlobal(hitUp);
			hitDown.x = 720;
			hitDown.y = 192;
			hitDown=localToGlobal(hitDown);
			
			addEventListener(Event.ENTER_FRAME, HitTestPointHor)
			addEventListener(Event.ENTER_FRAME, HitTestPointVer)
			//addEventListener(Event.ENTER_FRAME, hitCheck) -- Moved alternative collision detection code to SpaceScene --
		}
		
		private function HitTestPointHor(e:Event)
		{
			j++
			for (var i = 0; i < SuburbScene.objects.length; i++)
			{
				if (SuburbScene.objects[i].hitTestPoint(hitLeft.x, hitLeft.y, true))
				{
					_leftCollision = true; break;
					trace("hitLEFT" + j);
				}
				else
				{
					_leftCollision = false;
				}
				if (SuburbScene.objects[i].hitTestPoint(hitRight.x, hitRight.y, true))
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
			for (var i = 0; i < SuburbScene.objects.length; i++)
			{
				if (SuburbScene.objects[i].hitTestPoint(hitUp.x, hitUp.y, true))
				{
					_upCollision = true; break;
					trace("hitUP" + j);
				}
				else
				{
					_upCollision = false;
				}
				if (SuburbScene.objects[i].hitTestPoint(hitDown.x, hitDown.y, true))
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
			
			if (key.isDown(key.SHIFT) && !cooldown)
			{
				if (currentStamina > minStamina)
				{
					currentStamina -= 30;
					//trace(currentStamina)
				}
				else if (currentStamina == minStamina)
				{
					cooldown = true;
					trace("SPRINT COOLDOWN")
				}
				speed = 10;
			}
			else
			{
				if (currentStamina < maxStamina)
				{
					currentStamina += 10;
					trace(currentStamina)
				}
				else if (currentStamina == maxStamina)
				{
					cooldown = false;
				}
				speed = 5;
			}
			
			if (key.isDown(key.LEFT) || key.isDown(key.A))
			{
				//PlayerAnimation(leftWalk, true)
				
				if (_leftCollision)
				{
					animationState = "left_stop";
					trace("Left is Blocked")
				}
				else
				{
					animationState = "left_move";
					lastDirection = "left_stop";
					x -= speed;
					hitDown.x -= speed;
					hitUp.x -= speed;
					hitLeft.x -= speed;
					hitRight.x -= speed;
					//this.rotation = -90;
				}
			}
			if (key.isDown(key.RIGHT) || key.isDown(key.D))
			{
				//PlayerAnimation(rightWalk, true)
				
				if (_rightCollision)
				{
					animationState = "right_stop";
					trace("Right is Blocked")
				}
				else
				{
					animationState = "right_move";
					lastDirection = "right_stop";
					x += speed;
					hitDown.x += speed;
					hitUp.x += speed;
					hitLeft.x += speed;
					hitRight.x += speed;
					//this.rotation = 90;
				}
			}
			if (key.isDown(key.UP) || key.isDown(key.W))
			{
				//PlayerAnimation(upWalk, true)
				
				if (_upCollision)
				{
					animationState = "up_stop";
					trace("Up is Blocked")
				}
				else
				{
					animationState = "up_move";
					lastDirection = "up_stop";
					y -= speed;
					hitDown.y -= speed;
					hitUp.y -= speed;
					hitLeft.y -= speed;
					hitRight.y -= speed;
					//this.rotation = 0;
				}
			}
			if (key.isDown(key.DOWN) || key.isDown(key.S))
			{
				//PlayerAnimation(downWalk, true)
				
				
				if(_downCollision)
				{
					animationState = "down_stop";
					trace("Down is Blocked")
				}
				else
				{
					animationState = "down_move";
					lastDirection = "down_stop";
					y += speed;
					hitDown.y += speed;
					hitUp.y += speed;
					hitLeft.y += speed;
					hitRight.y += speed;
					//this.rotation = 180;
				}
			}
			/*if ((key.isDown(key.LEFT) || key.isDown(key.A)) && (key.isDown(key.UP) || key.isDown(key.W)))
			{
			this.rotation = -45;
			}
			if ((key.isDown(key.LEFT) || key.isDown(key.A)) && (key.isDown(key.DOWN) || key.isDown(key.S)))
			{
			this.rotation = 45;
			}
			if ((key.isDown(key.RIGHT) || key.isDown(key.D)) && (key.isDown(key.UP) || key.isDown(key.W)))
			{
			this.rotation = -45;
			}
			if ((key.isDown(key.RIGHT) || key.isDown(key.D)) && (key.isDown(key.DOWN) || key.isDown(key.S)))
			{
			this.rotation = 135;
			}*/
			
			if (!(key.isDown(key.DOWN) || key.isDown(key.S) || key.isDown(key.UP) || key.isDown(key.W) || key.isDown(key.RIGHT) || key.isDown(key.D) || key.isDown(key.LEFT) || key.isDown(key.A)))
			{
				animationState = lastDirection;
			}
			
			if(this.currentLabel != animationState){
				this.gotoAndStop(animationState);
			}
		}
		
		/*public function PlayerAnimation(label:String, play:Boolean=false):void
		{ 
		if( play ){
		gotoAndPlay(label);
		}else{
		gotoAndStop(label);
		}
		}*/
		
		
	}
}