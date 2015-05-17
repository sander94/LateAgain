package
{
	import KeyObject;
	import flash.display.*;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import flash.geom.*;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	public class Player extends MovieClip
	{
		private var key:KeyObject;
		private var stageRef:Stage;
		private var gameState:GameState;
		private var speed:Number = 3;
		private var userInterface:UI;
		private var staminaBar:StaminaBar;
		
		public static var speedMult:Number = 1;
		public static var playerX:Number;
		public static var playerY:Number;

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
		public var curPowerUp:MovieClip = new MovieClip;
		private var powerUpTime:int = 1000;
		public var powerUpActive:Boolean = false;
		private var curScene;
		
		private var leftKey;
		private var rightKey;
		private var upKey;
		private var downKey;
		
		public static var playerAlive:Boolean = true;
		public static var playerHit:Boolean = false;
		public var restartText:RestartText;
		
		private var parentClass;
		private var parentClassWidth:Number;
		private var parentClassHeight:Number;

		private var topY:Number;
		private var bottomY:Number;
		private var leftX:Number;
		private var rightX:Number;

		private var startX:Number;
		private var startY:Number;

		private var staminaColor:ColorTransform;
		
		public function Player(passedClass:GameState, stageRef:Stage, scene, curClass, passedX, passedY)
		{
			trace("in player")
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			gameState = passedClass;
			playerAlive = true;

			startX = passedX;
			startY = passedY;

			curScene = scene;
			parentClass = curClass;
			parentClassWidth = parentClass.width;
			parentClassHeight = parentClass.height;

			//Set the limits for camera movement
			topY = parentClass.object_screenBlock01.y;
			rightX = parentClass.object_screenBlock02.x;
			bottomY = parentClass.object_screenBlock03.y;
			leftX = parentClass.object_screenBlock04.x;

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
			
			addEventListeners();
		}

		//Hit detection
		private function hitTestPointHor(e:Event)
		{
			if (playerAlive && !playerHit)
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
							hitEnemy(curScene.objects[i], "left");
						}
						//Othervise stop movement in that direction
						else
						{
							leftCollision = true;
							//trace ("Collision")
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
							hitEnemy(curScene.objects[i], "right");
						}
						else
						{
							rightCollision = true;
							//trace ("Collision")
							break;
						}
					}
					else
					{
						rightCollision = false;
					}
				}
			}
		}
		private function hitTestPointVer(e:Event)
		{
			if (playerAlive && !playerHit)
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
							hitEnemy(curScene.objects[i], "up");
						}
						else
						{
							upCollision = true;
							//trace ("Collision")
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
							hitEnemy(curScene.objects[i], "down");
						}
						else
						{
							downCollision = true;
							//trace ("Collision")
							break;
						}
					}
					else
					{
						downCollision = false;
					}
				}
			}
		}

		//Camera code
		private function cameraFollowPlayer(e:Event)
		{
			if (parentClassHeight > 363 && parentClassWidth > 483)
			{
				switch (getXY())
				{
					case "middle":
					root.scrollRect = new Rectangle(x - stage.stageWidth/2, y - stage.stageHeight/2, stage.stageWidth, stage.stageHeight);
					break;

					case "top left":
					root.scrollRect = new Rectangle(leftX, topY, stage.stageWidth, stage.stageHeight);
					break;

					case "bottom left":
					root.scrollRect = new Rectangle(leftX, bottomY - 360, stage.stageWidth, stage.stageHeight);
					break;
					
					case "top right":
					root.scrollRect = new Rectangle(rightX - 480, topY, stage.stageWidth, stage.stageHeight);
					break;
					
					case "bottom right":
					root.scrollRect = new Rectangle(rightX - 480, bottomY - 360, stage.stageWidth, stage.stageHeight);
					break;

					case "left":
					root.scrollRect = new Rectangle(leftX, y - stage.stageHeight/2, stage.stageWidth, stage.stageHeight);
					break;
					
					case "right":
					root.scrollRect = new Rectangle(rightX - 480, y - stage.stageHeight/2, stage.stageWidth, stage.stageHeight);
					break;
					
					case "top":
					root.scrollRect = new Rectangle(x - stage.stageWidth/2, topY, stage.stageWidth, stage.stageHeight);
					break;
					
					case "bottom":
					root.scrollRect = new Rectangle(x - stage.stageWidth/2, bottomY - 360, stage.stageWidth, stage.stageHeight);
					break;
				}
			}
		}

		//Checks location of player in relation to borders
		private function getXY()
		{
			//Player is not at any edge or corner
			if (x >= leftX + 240 && x <= rightX - 240 && y >= topY + 180 && y <= bottomY - 180)
			{
				return "middle";
			}
			//Player is at top left corner
			else if (x <= leftX + 240 && y <= topY + 180)
			{
				return "top left";
			}
			//Player is at bottom left corner
			else if (x <= leftX + 240 && y >= bottomY - 180)
			{
				return "bottom left";
			}
			//Player is at top right corner
			else if (x >= rightX - 240 && y <= topY + 180)
			{
				return "top right";
			}
			//Player is at bottom right corner
			else if (x >= rightX - 240 && y >= bottomY - 180)
			{
				return "bottom right";
			}
			//Player is at left edge
			else if (x <= leftX + 240)
			{
				return "left";
			}
			//Player is at right edge
			else if (x >= rightX - 240)
			{
				return "right";
			}
			//Player is at top edge
			else if (y <= topY + 180)
			{
				return "top";
			}
			//Player is at bottom edge
			else if (y >= bottomY - 240)
			{
				return "bottom";
			}
		}

		//Remove EventListeners
		public function removeEventListeners()
		{
			removeEventListener(Event.ENTER_FRAME, hitTestPointHor);
			removeEventListener(Event.ENTER_FRAME, hitTestPointVer);
			removeEventListener(Event.ENTER_FRAME, playerLoop);
			removeEventListener(Event.ENTER_FRAME, cameraFollowPlayer);
			this.stageRef.removeChild(userInterface);
		}
		
		//Add EventListeners
		public function addEventListeners()
		{
			addEventListener(Event.ENTER_FRAME, hitTestPointHor);
			addEventListener(Event.ENTER_FRAME, hitTestPointVer);
			addEventListener(Event.ENTER_FRAME, playerLoop);
			addEventListener(Event.ENTER_FRAME, cameraFollowPlayer);
			userInterface = new UI;
			this.stageRef.addChild(userInterface);
			staminaBar = new StaminaBar;
			staminaBar.x = -65;
			userInterface.staminaFrame.addChildAt(staminaBar,0);
			staminaColor = new ColorTransform(0,0,0,1,0,255,0,0);
			staminaBar.transform.colorTransform = staminaColor;
		}

		//Collision with enemy
		private function hitEnemy(enemy, direction)
		{
			//Check if powerup is active and that it is energy drink (immortality)
			if (powerUpActive && curPowerUp.name.indexOf("energy") >= 0)
			{
				trace("Immune");
			}
			else
			{
				addEventListener(Event.ENTER_FRAME, playerDown);

				//Check wich direction got hit from
				switch (direction)
				{
					case "down":
					this.gotoAndStop("down_hit");
					break;

					case "up":
					this.gotoAndStop("up_hit");
					break;

					case "left":
					this.gotoAndStop("left_hit");
					break;

					case "right":
					this.gotoAndStop("right_hit");
					break;
				}

				//If enemy was car, game over
				if (enemy.name.indexOf("car") >= 0)
				{
					removeEventListeners();

					restartText = new RestartText;
					restartTextXY();
					parent.addChild(restartText);
					
					playerAlive = false;
				}
				else if (enemy.name.indexOf("granny") >= 0)
				{
					removeEventListener(Event.ENTER_FRAME, playerLoop);
					removeEventListener(Event.ENTER_FRAME, hitTestPointHor);
					removeEventListener(Event.ENTER_FRAME, hitTestPointVer);
					removeEventListener(Event.ENTER_FRAME, cameraFollowPlayer);
					
					restartText = new RestartText;
					restartTextXY();
					parent.addChild(restartText);

					playerHit = true;
				}
			}
		}
		
		//Player was hit
		private function playerDown(e:Event)
		{
			if (key.isDown(key.SPACE) && !playerAlive)
			{
				removeEventListener(Event.ENTER_FRAME, playerDown);

				gameState.startScene();
				curScene.objects = null;
			}
			if (key.isDown(key.SPACE) && playerAlive)
			{
				removeEventListener(Event.ENTER_FRAME, playerDown);

				addEventListener(Event.ENTER_FRAME, hitTestPointHor);
				addEventListener(Event.ENTER_FRAME, hitTestPointVer);
				addEventListener(Event.ENTER_FRAME, playerLoop);
				addEventListener(Event.ENTER_FRAME, cameraFollowPlayer);

				gameState.gameTimeRemaining -= 10; //Time penalty for being hit

				x = startX;
				y = startY;

				playerHit = false;

				parent.removeChild(restartText);
			}

		}

		//X and Y coordinates for restart text
		private function restartTextXY()
		{
			switch (getXY())
			{
				case "middle":
				restartText.x = x;
				restartText.y = y;
				break;

				case "top left":
				restartText.x = leftX + 240;
				restartText.y = topY + 180;
				break;

				case "bottom left":
				restartText.x = leftX + 240;
				restartText.y = bottomY - 180;
				break;
				
				case "top right":
				restartText.x = rightX - 240;
				restartText.y = topY + 180;
				break;
				
				case "bottom right":
				restartText.x = rightX - 240;
				restartText.y = bottomY - 180;
				break;

				case "left":
				restartText.x = leftX + 240;
				restartText.y = y;
				break;
				
				case "right":
				restartText.x = rightX - 240;
				restartText.y = y;
				break;
				
				case "top":
				restartText.x = x;
				restartText.y = topY + 180;
				break;
				
				case "bottom":
				restartText.x = x;
				restartText.y = bottomY - 180;
				break;
			}
		}
		
		//Pick up powerup
		private function pickedUpPowerUp(pickedUp)
		{
			if (!powerUpActive)
			{
				if (heldPowerUp)
				{
					userInterface.removeChild(curPowerUp);
				}
				
				curPowerUp = pickedUp;
				curPowerUp.x = userInterface.powerUpFrame.x;
				curPowerUp.y = userInterface.powerUpFrame.y;
				parent.removeChild(pickedUp);
				heldPowerUp = true;
				trace("Holding " + curPowerUp.name);
				userInterface.addChild(curPowerUp);
			}
		}
		
		//Use powerup
		private function usedPowerUp(e:Event)
		{
			if (curPowerUp.name.indexOf("energy") >= 0)
			{
				speed = 6;
			}
			if (curPowerUp.name.indexOf("coffee") >= 0)
			{
				if (key.isDown(key.SHIFT) && !cooldown)
				{
					speed = 8;
				}
				speed = 4;
				speedMult = 0.5;
			}
			
			if (powerUpTime > 0)
			{
				powerUpTime -= 10;
			}
			else if (powerUpTime <= 0)
			{
				powerUpActive = false;
				powerUpTime = 1000;
				removeEventListener(Event.ENTER_FRAME, usedPowerUp);
				if (curPowerUp.name.indexOf("coffee") >= 0)
				{
					speed = 3;
					speedMult = 1;
				}
				if (curPowerUp.name.indexOf("energy") >= 0)
				{
					speed = 3;
				}
				
				userInterface.removeChild(curPowerUp);
				heldPowerUp = false;
				curPowerUp = new MovieClip;
			}
		}
		
		//Player loop
		private function playerLoop(e:Event)
		{
			//trace(userInterface.timeRemaining.text);
			playerX = x;
			playerY = y;
			//userInterface.timeRemaining.text = String(gameState.gameTimeRemaining);

			leftKey = key.isDown(key.LEFT), key.isDown(key.A);
			rightKey = key.isDown(key.RIGHT), key.isDown(key.D);
			upKey = key.isDown(key.UP), key.isDown(key.W);
			downKey = key.isDown(key.DOWN), key.isDown(key.S);

			//coordinates for debug purposes
			//trace("x " + x + " " + parentClass.x + " y " + y + " " + parentClass.y)
			if (playerAlive && !playerHit)
			{
				if (key.isDown(key.SHIFT) && !cooldown)
				{
					if (currentStamina > minStamina)
					{
						currentStamina -= 30 * speedMult;
						staminaBar.width = currentStamina / 10;
						//trace(currentStamina)
					}
					else if (currentStamina <= minStamina)
					{
						staminaColor = new ColorTransform(0,0,0,1,255,0,0,0);
						staminaBar.transform.colorTransform = staminaColor;
						cooldown = true;
						trace("SPRINT COOLDOWN")
					}
					speed = 6;
				}
				else
				{
					if (currentStamina < maxStamina)
					{
						staminaBar.width = currentStamina / 10;
						currentStamina += 10 * speedMult;
						//trace(currentStamina)
					}
					else if (currentStamina == maxStamina)
					{
						staminaColor = new ColorTransform(0,0,0,1,0,255,0,0);
						staminaBar.transform.colorTransform = staminaColor;
						cooldown = false;
					}
					if (!powerUpActive && curPowerUp.name.indexOf("energy"))
					{
						speed = 3;
					}
				}
				
				if (key.isDown(key.E) && !powerUpActive && heldPowerUp)
				{
					powerUpActive = true;
					addEventListener(Event.ENTER_FRAME, usedPowerUp);
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
						x -= speed * speedMult;
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
						x += speed * speedMult;
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
						y -= speed * speedMult;
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
						y += speed * speedMult;
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
}