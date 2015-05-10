package
{
	import KeyObject;
	import flash.display.*;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	public class Player extends MovieClip
	{
		private var key:KeyObject;
		private var stageRef:Stage;
		private var gameState:GameState;
		private var speed:Number = 3;
		private var leftCollision:Boolean = false;
		private var rightCollision:Boolean = false;
		private var upCollision:Boolean = false;
		private var downCollision:Boolean = false;
		
		private var hitboxLeft:MovieClip = new HitboxLeft;		// collision detection movieclips, alpha at 1%
		private var hitboxRight:MovieClip = new HitboxRight;
		private var hitboxDown:MovieClip = new HitboxDown;
		private var hitboxUp:MovieClip = new HitboxUp;

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
		
		public var playerAlive:Boolean = true;
		private var downHit:DownHit; //Hit from down direction
		/*private var upHit:UpHit; //Hit from up direction
		private var leftHit:LeftHit; //Hit from left direction
		private var rightHit:RightHit; //Hit from right direction*/
		
		private var parentClass;
		private var parentClassWidth;
		private var parentClassHeight;
		
		public function Player(passedClass:GameState, stageRef:Stage, scene, curClass)
		{
			trace("in player")
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			gameState = passedClass;

			curScene = scene;
			parentClass = curClass;
			parentClassWidth = parentClass.width;
			parentClassHeight = parentClass.height;

			hitboxLeft.x = x - 6;
			hitboxLeft.y = y;
			addChild(hitboxLeft);
			
			hitboxRight.x = x + 6;
			hitboxRight.y = y;
			addChild(hitboxRight);
			
			hitboxDown.x = x;
			hitboxDown.y = x + 10;
			addChild(hitboxDown);
			
			hitboxUp.x = x;
			hitboxUp.y = y - 10;
			addChild(hitboxUp);
			
			addEventListeners()
		}

		//Hit detection
		private function HitTestPointHor(e:Event)
		{
			for (var i = 0; i < curScene.objects.length; i++)
			{
				//If hit check
				if (curScene.objects[i].hitTestObject(hitboxLeft))
				{
					//If the target was a powerup
					if (curScene.objects[i].name.indexOf("power") >= 0)
					{
						pickedUpPowerUp(curScene.objects[i]);
					}
					//Or enemy
					else if (curScene.objects[i].name.indexOf("enemy") >= 0)
					{
						hitEnemy(curScene.objects[i]);
					}
					//Othervise stop movement in that direction
					else
					{
						leftCollision = true;
						break;
					}
				}
				else
				{
					leftCollision = false;
				}
				
				if (curScene.objects[i].hitTestObject(hitboxRight))
				{
					if (curScene.objects[i].name.indexOf("power") >= 0)
					{
						pickedUpPowerUp(curScene.objects[i]);
					}
					else if (curScene.objects[i].name.indexOf("enemy") >= 0)
					{
						hitEnemy(curScene.objects[i]);
					}
					else
					{
						rightCollision = true;
						break;
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
				if (curScene.objects[i].hitTestObject(hitboxUp))
				{
					if (curScene.objects[i].name.indexOf("power") >= 0)
					{
						pickedUpPowerUp(curScene.objects[i]);
					}
					else if (curScene.objects[i].name.indexOf("enemy") >= 0)
					{
						hitEnemy(curScene.objects[i]);
					}
					else
					{
						upCollision = true;
						break;
					}
				}
				else
				{
					upCollision = false;
				}
				
				if (curScene.objects[i].hitTestObject(hitboxDown))
				{
					if (curScene.objects[i].name.indexOf("power") >= 0)
					{
						pickedUpPowerUp(curScene.objects[i]);
					}
					else if (curScene.objects[i].name.indexOf("enemy") >= 0)
					{
						hitEnemy(curScene.objects[i]);
					}
					else
					{
						downCollision = true;
						break;
					}
				}
				else
				{
					downCollision = false;
				}
			}
		}

		//Remove EventListeners
		public function removeEventListeners()
		{
			removeEventListener(Event.ENTER_FRAME, HitTestPointHor);
			removeEventListener(Event.ENTER_FRAME, HitTestPointVer);
			removeEventListener(Event.ENTER_FRAME, playerLoop);
		}
		
		//Add EventListeners
		public function addEventListeners()
		{
			addEventListener(Event.ENTER_FRAME, HitTestPointHor);
			addEventListener(Event.ENTER_FRAME, HitTestPointVer);
			addEventListener(Event.ENTER_FRAME, playerLoop);
		}

		//Collision with enemy
		private function hitEnemy(enemy)
		{
			//Check if powerup is active and that it is energy drink (immortality)
			if (powerUpActive && curPowerUp.name.indexOf("energy") >= 0)
			{
				trace("Immune");
			}
			//Check wich direction got hit from
			else if (enemy.hitTestObject(hitboxDown))
			{
				//Collision happened with hitboxDown
				enemy.removeEventListeners();
				downHit = new DownHit(gameState, stageRef, enemy, curScene); //Pass enemy information, gameState, stageRef and current scene to the DownHit class
				downHit.x = x;
				downHit.y = y;
				playerAlive = downHit.hitCheck();
				parent.addChild(downHit);
				parent.removeChild(this);
				removeEventListeners();

			}
			/*TODO add other collision directions
			else if ()
			{

			}*/
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
			leftKey = key.isDown(key.LEFT), key.isDown(key.A);
			rightKey = key.isDown(key.RIGHT), key.isDown(key.D);
			upKey = key.isDown(key.UP), key.isDown(key.W);
			downKey = key.isDown(key.DOWN), key.isDown(key.S);

			//coordinates for debug purposes
			//trace("x " + x + " " + parentClass.x + " width " + parentClassWidth + " y " + y + " " + parentClass.y + " height " + parentClassHeight)

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
					if (parentClass.x <= -3 && x <= parentClassWidth - 260 && parentClassWidth > 483)
					//if (parentClass.x <= -2 && parentClass.x >= -480 && x <= 720)
					{
						parentClass.x += speed;
					}
				}
			}
			if (rightKey)
			{
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
					if (parentClass.x >= -parentClassWidth + 510 && x >= 240 && parentClassWidth > 483)
					//if (parentClass.x >= -478 && x >= 240)
					{
						parentClass.x -= speed;
					}
				}
			}
			if (upKey)
			{
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
					if (parentClass.y <= -3 && y <= -parentClass.y + 180 && parentClassHeight > 363)
					//if (parentClass.y <= 180 && y <= 180)
					{
						parentClass.y += speed;
					}
				}
			}
			if (downKey)
			{
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
					if (parentClass.y >= -parentClassHeight + 380 && y >= 180 && parentClassHeight > 363)
					{
						parentClass.y -= speed;
					}
				}
			}
			
			if (!(downKey || upKey || rightKey || leftKey))
			{
				animationState = lastDirection;
			}
			
			if (this.currentLabel != animationState){
				this.gotoAndStop(animationState);
			}
		}
	}
}