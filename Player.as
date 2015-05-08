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
		private var speed:Number = 5;
		private var leftKey;
		private var rightKey;
		private var upKey;
		private var downKey;
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
		private var heldPowerUp:Boolean = false;
		private var curPowerUp:MovieClip = new MovieClip;
		private var powerUpTime:int = 1000;
		private var powerUpActive:Boolean = false;
		private var curScene;
		
		public function Player(stageRef:Stage, scene)
		{
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			curScene = scene;
			
			addEventListener(Event.ENTER_FRAME, HitTestPointHor)
			addEventListener(Event.ENTER_FRAME, HitTestPointVer)
		}

		//Hit detection
		private function HitTestPointHor(e:Event)
		{
			for (var i = 0; i < curScene.objects.length; i++)
			{
				if (curScene.objects[i].hitTestPoint(hitLeft.x, hitLeft.y, true))
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
					_leftCollision = true; break;
					trace("hitLEFT");
					}
				}
				else
				{
					_leftCollision = false;
				}
				if (curScene.objects[i].hitTestPoint(hitRight.x, hitRight.y, true))
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
						_rightCollision = true; break;
						trace("hitRIGHT");
					}
				}
				else
				{
					_rightCollision = false;
				}
			}
		}
		private function HitTestPointVer(e:Event)
		{
			for (var i = 0; i < curScene.objects.length; i++)
			{
				if (curScene.objects[i].hitTestPoint(hitUp.x, hitUp.y, true))
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
					_upCollision = true; break;
					trace("hitUP");
					}
				}
				else
				{
					_upCollision = false;
				}
				if (curScene.objects[i].hitTestPoint(hitDown.x, hitDown.y, true))
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
					_downCollision = true; break;
					trace("hitDOWN");
					}
				}
				else
				{
					_downCollision = false;
				}
			}
			
			
			addEventListener(Event.ENTER_FRAME, playerLoop);
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
		
		//Player loop
		private function playerLoop(e:Event)
		{
			hitLeft.x = x - 10;
			hitLeft.y = y;
			hitRight.x = x + 10;
			hitRight.y = y;
			hitUp.x = x;
			hitUp.y = y - 15;
			hitDown.x = x;
			hitDown.y = y + 20;

			leftKey = key.isDown(key.LEFT), key.isDown(key.A);
			rightKey = key.isDown(key.RIGHT) || key.isDown(key.D);
			upKey = key.isDown(key.UP), key.isDown(key.W);
			downKey = key.isDown(key.DOWN), key.isDown(key.S);
			
			//SPACE
			if (key.isDown(key.SPACE) && heldPowerUp)
			{
				powerUpActive = true;
				addEventListener(Event.ENTER_FRAME, usedPowerUp);
			}
			
			//SHIFT
			if (key.isDown(key.SHIFT) && !cooldown && (!powerUpActive && curPowerUp.name.indexOf("energy") <= 0))
			{
				if (currentStamina > minStamina)
				{
					currentStamina -= 30;
					//trace(currentStamina)
					speed = 10;
				}
				else if (currentStamina == minStamina)
				{
					cooldown = true;
					trace("SPRINT COOLDOWN");
				}
			}
			else if (!powerUpActive && curPowerUp.name.indexOf("energy") <= 0)
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
			
			//LEFT
			if (leftKey)
			{
				
				if (_leftCollision)
				{
					animationState = "left_stop";
					trace("Left is Blocked");
				}
				else
				{
					animationState = "left_move";
					lastDirection = "left_stop";
					x -= speed;
					//this.rotation = -90;
				}
			}
			
			//RIGHT
			if (rightKey)
			{
				
				if (_rightCollision)
				{
					animationState = "right_stop";
					trace("Right is Blocked");
				}
				else
				{
					animationState = "right_move";
					lastDirection = "right_stop";
					x += speed;
					//this.rotation = 90;
				}
			}
			
			//UP
			if (upKey)
			{
				
				if (_upCollision)
				{
					animationState = "up_stop";
					trace("Up is Blocked");
				}
				else
				{
					animationState = "up_move";
					lastDirection = "up_stop";
					y -= speed;
					//this.rotation = 0;
				}
			}
			
			//DOWN
			if (downKey)
			{
				
				
				if(_downCollision)
				{
					animationState = "down_stop";
					trace("Down is Blocked");
				}
				else
				{
					animationState = "down_move";
					lastDirection = "down_stop";
					y += speed;
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
			
			//Change animation
			if (!(downKey || upKey || rightKey || leftKey))
			{
				animationState = lastDirection;
			}
			
			if(this.currentLabel != animationState){
				this.gotoAndStop(animationState);
			}
		}
	}
}