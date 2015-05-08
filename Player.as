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
	import flash.utils.Timer;
	
	public class Player extends MovieClip
	{
		private var key:KeyObject;
		private var stageRef:Stage;
		private var speed:Number = 3;
		private var leftCollision:Boolean = false;
		private var rightCollision:Boolean = false;
		private var upCollision:Boolean = false;
		private var downCollision:Boolean = false;
		
		private var hitLeft:MovieClip = new HitLeft;		// collision detection movieclips, alpha at 1%
		private var hitRight:MovieClip = new HitRight;
		private var hitDown:MovieClip = new HitDown;
		private var hitUp:MovieClip = new HitUp;
		private var animationState:String = "down_stop";
		private var lastDirection:String = "down_stop"; 	// player facing when not moving
		
		private var maxStamina:int = 1200;					// sprint meter and cooldown variables for Shift key
		private var minStamina:int = 0;
		private var currentStamina:int = maxStamina;
		private var cooldown:Boolean = false;
		
		private var heldPowerUp:Boolean = false;
		private var curPowerUp:MovieClip = new MovieClip;
		private var powerUpTime:int = 1000;
		private var powerUpActive:Boolean = false;
		private var curScene;
		
		private var leftKey;
		private var rightKey;
		private var upKey;
		private var downKey;
		
		private var lastX:Number;
		private var lastY:Number;
		private var deadPlayer:DeadPlayer;
		
		private var parentClass;
		
		public function Player(stageRef:Stage, scene, passedClass)
		{
			trace("in player")
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			curScene = scene;
			
			parentClass = passedClass;
			
			trace(parentClass)
			
			hitLeft.x = x - 6;
			hitLeft.y = y;
			addChild(hitLeft);
			
			hitRight.x = x + 6;
			hitRight.y = y;
			addChild(hitRight);
			
			hitDown.x = x;
			hitDown.y = x + 10;
			addChild(hitDown);
			
			hitUp.x = x;
			hitUp.y = y - 10;
			addChild(hitUp);
			
			addEventListener(Event.ENTER_FRAME, HitTestPointHor)
			addEventListener(Event.ENTER_FRAME, HitTestPointVer)
		}
		
		private function HitTestPointHor(e:Event)
		{
			for (var i = 0; i < curScene.objects.length; i++)
			{
				if (curScene.objects[i].hitTestObject(hitLeft))
				{
					if (curScene.objects[i].name.indexOf("power") >= 0)
					{
						pickedUpPowerUp(curScene.objects[i]);
						trace(curScene.objects[i].name);
					}
					else if (curScene.objects[i].name.indexOf("enemy") >= 0)
					{
						hitEnemy(curScene.objects[i]);
						trace(curScene.objects[i].name);
					}
					else
					{
						leftCollision = true; break;
						trace("hitLEFT");
					}
				}
				else
				{
					leftCollision = false;
				}
				
				if (curScene.objects[i].hitTestObject(hitRight))
				{
					if (curScene.objects[i].name.indexOf("power") >= 0)
					{
						pickedUpPowerUp(curScene.objects[i]);
						trace(curScene.objects[i].name);
					}
					else if (curScene.objects[i].name.indexOf("enemy") >= 0)
					{
						hitEnemy(curScene.objects[i]);
						trace(curScene.objects[i].name);
					}
					else
					{
						rightCollision = true; break;
						trace("hitRIGHT");
					}
				}
				else
				{
					rightCollision = false;
				}
			}
		}
		private function HitTestPointVer(e:Event)
		{
			for (var i = 0; i < curScene.objects.length; i++)
			{
				if (curScene.objects[i].hitTestObject(hitUp))
				{
					if (curScene.objects[i].name.indexOf("power") >= 0)
					{
						pickedUpPowerUp(curScene.objects[i]);
						trace(curScene.objects[i].name);
					}
					else if (curScene.objects[i].name.indexOf("enemy") >= 0)
					{
						hitEnemy(curScene.objects[i]);
						trace(curScene.objects[i].name);
					}
					else
					{
						upCollision = true; break;
						trace("hitUP");
					}
				}
				else
				{
					upCollision = false;
				}
				
				if (curScene.objects[i].hitTestObject(hitDown))
				{
					if (curScene.objects[i].name.indexOf("power") >= 0)
					{
						pickedUpPowerUp(curScene.objects[i]);
						trace(curScene.objects[i].name);
					}
					else if (curScene.objects[i].name.indexOf("enemy") >= 0)
					{
						hitEnemy(curScene.objects[i]);
						trace(curScene.objects[i].name);
					}
					else
					{
						downCollision = true; break;
						trace("hitDOWN");
					}
				}
				else
				{
					downCollision = false;
				}
			}
			
			addEventListener(Event.ENTER_FRAME, playerLoop)
		}
		
		private function hitEnemy(enemy)
		{
			if (powerUpActive && curPowerUp.name.indexOf("energy") >= 0)
			{
				trace("Immune");
			}
			else if (enemy.name.indexOf("car") >= 0)
			{
				trace("You got flattened by a car!")
			}
		}
		
		//Pick up powerup
		private function pickedUpPowerUp(pickedUp)
		{
			if (!powerUpActive)
			{
				if (heldPowerUp)
				{
					removeChild(curPowerUp);
				}
				
				curPowerUp = pickedUp;
				curPowerUp.x = x;
				curPowerUp.y = y;
				parent.removeChild(pickedUp);
				heldPowerUp = true;
				trace("Holding " + curPowerUp.name);
				addChild(curPowerUp);
			}
		}
		
		//Use powerup
		private function usedPowerUp(e:Event)
		{
			if (curPowerUp.name.indexOf("energy") >= 0)
			{
				speed = 15;
				
				if (!powerUpActive && currentStamina < maxStamina)
				{
					cooldown = true;
				}
			}
			
			if (powerUpTime > 0)
			{
				powerUpTime -= 10;
			}
			else if (powerUpTime == 0)
			{
				powerUpActive = false;
				powerUpTime = 1000;
				removeEventListener(Event.ENTER_FRAME, usedPowerUp);
				
				parent.removeChild(curPowerUp);
				heldPowerUp = false;
				curPowerUp = new MovieClip;
			}
		}
		
		private function playerLoop(e:Event)
		{
			leftKey = key.isDown(key.LEFT), key.isDown(key.A);
			rightKey = key.isDown(key.RIGHT), key.isDown(key.D);
			upKey = key.isDown(key.UP), key.isDown(key.W);
			downKey = key.isDown(key.DOWN), key.isDown(key.S);
			
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
				speed = 6;
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
				speed = 3;
			}
			
			if (leftKey)
			{
				//PlayerAnimation(leftWalk, true)
				
				if (leftCollision)
				{
					//animationState = "left_stop";
					//trace("Left is Blocked")
				}
				else
				{
					animationState = "left_move";
					lastDirection = "left_stop";
					x -= speed;
					if (parentClass.x <= -2 && parentClass.x >= -stage.width && x <= parentClass.width - (stage.width / 2))
					{
						parentClass.x += speed;
					}
				}
			}
			if (rightKey)
			{
				//PlayerAnimation(rightWalk, true)
				
				if (rightCollision)
				{
					//animationState = "right_stop";
					//trace("Right is Blocked")
				}
				else
				{
					animationState = "right_move";
					lastDirection = "right_stop";
					x += speed;
					if (parentClass.x >= -stage.width + 2 && parentClass.x <= stage.width && x <= parentClass.width - (stage.width / 2))
					{
						parentClass.x -= speed;
					}
				}
			}
			if (upKey)
			{
				//PlayerAnimation(upWalk, true)
				
				if (upCollision)
				{
					//animationState = "up_stop";
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
			if (downKey)
			{
				//PlayerAnimation(downWalk, true)
				
				
				if(downCollision)
				{
					//animationState = "down_stop";
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
			
			if (!(downKey || upKey || rightKey || leftKey))
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
			/*stage.removeEventListener(Event.ENTER_FRAME, HitTestPointHor)
			stage.removeEventListener(Event.ENTER_FRAME, HitTestPointVer)
			stage.removeEventListener(Event.ENTER_FRAME, playerLoop)*/
			removeEventListener(Event.ENTER_FRAME, HitTestPointHor)
			removeEventListener(Event.ENTER_FRAME, HitTestPointVer)
			removeEventListener(Event.ENTER_FRAME, playerLoop)
			
		}
	}
}