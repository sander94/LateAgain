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
		public static var userInterface:UI;
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
		
		public static var curScene:Class;
		
		private var leftKey;
		private var rightKey;
		private var upKey;
		private var downKey;

		private var energyDrink:MovieClip = new EnergyDrink;
		private var coffee:MovieClip = new Coffee;
		
		public static var playerAlive:Boolean = true;
		public static var playerHit:Boolean = false;
		private var textXY:Object;
		public var resetText:ResetText;
		public var gameOverText:GameOverText;
		
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
			//trace("in player")
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
			hitboxDown.y = y + 10;
			addChild(hitboxDown);
			
			hitboxUp.x = x;
			hitboxUp.y = y - 10;
			addChild(hitboxUp);
			
			addEventListeners();
		}

		//Hit detection
		private function hitTestLeft(e:Event)
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
				}
			}
		}
		private function hitTestRight(e:Event)
		{
			if (playerAlive && !playerHit)
			{
				for (var i = 0; i < curScene.objects.length; i++)
				{
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
		private function hitTestUp(e:Event)
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
				}
			}
		}
		private function hitTestDown(e:Event)
		{
			if (playerAlive && !playerHit)
			{
				for (var i = 0; i < curScene.objects.length; i++)
				{
					
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
			if (parentClassHeight > 370 && parentClassWidth > 490)
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
			removeEventListener(Event.ENTER_FRAME, hitTestLeft);
			removeEventListener(Event.ENTER_FRAME, hitTestRight);
			removeEventListener(Event.ENTER_FRAME, hitTestUp);
			removeEventListener(Event.ENTER_FRAME, hitTestDown);
			removeEventListener(Event.ENTER_FRAME, playerLoop);
			removeEventListener(Event.ENTER_FRAME, cameraFollowPlayer);
			this.stageRef.removeChild(userInterface);
		}
		
		//Add EventListeners
		public function addEventListeners()
		{
			addEventListener(Event.ENTER_FRAME, hitTestLeft);
			addEventListener(Event.ENTER_FRAME, hitTestRight);
			addEventListener(Event.ENTER_FRAME, hitTestUp);
			addEventListener(Event.ENTER_FRAME, hitTestDown);
			addEventListener(Event.ENTER_FRAME, playerLoop);
			addEventListener(Event.ENTER_FRAME, cameraFollowPlayer);
			userInterface = new UI;
			this.stageRef.addChild(userInterface);
			staminaBar = new StaminaBar;
			staminaBar.x = -65;
			userInterface.staminaFrame.addChildAt(staminaBar,0);
			if (!gameState.cooldown)
			{
				staminaColor = new ColorTransform(0,0,0,1,0,255,0,0);
				staminaBar.transform.colorTransform = staminaColor;
			}
			else
			{
				staminaColor = new ColorTransform(0,0,0,1,255,0,0,0);
				staminaBar.transform.colorTransform = staminaColor;
			}
			
			if (gameState.curPowerUp.name.indexOf("energy") >= 0)
			{
				energyDrink.name = "power_energy";
				gameState.curPowerUp = energyDrink;
				userInterface.powerUpFrame.addChild(gameState.curPowerUp);
			}
			else if (gameState.curPowerUp.name.indexOf("coffee") >= 0)
			{
				coffee.name = "power_coffee";
				gameState.curPowerUp = coffee;
				userInterface.powerUpFrame.addChild(gameState.curPowerUp);
			}
			if (gameState.powerUpActive)
			{
				addEventListener(Event.ENTER_FRAME, usedPowerUp);
			}
		}

		//Collision with enemy
		private function hitEnemy(enemy, direction)
		{
			//Check if powerup is active and that it is energy drink (immortality)
			if (gameState.powerUpActive && gameState.curPowerUp.name.indexOf("energy") >= 0)
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
					gameState.effectChannel.stop()
					gameState.musicChannel.stop()
					gameState.hitChannel = gameState.deathMusic.play(0, 0, gameState.effectVolume)

					playerAlive = false;
					removeEventListeners();

					textXY = getTextXY();
					gameOverText = new GameOverText;
					gameOverText.x = textXY.posX;
					gameOverText.y = textXY.posY;
					parent.addChild(gameOverText);
					
					speedMult = 1;
					gameState.curPowerUp = new MovieClip;
					gameState.heldPowerUp = false;
					gameState.powerUpTime = 1000;
					gameState.powerUpActive = false;
					gameState.currentStamina = gameState.maxStamina;
					gameState.cooldown = false;
				}
				//Othervise reset player and give time penalty
				else
				{
					gameState.effectChannel.stop()
					gameState.hitChannel = gameState.hitEffect.play(0, 0, gameState.effectVolume)
					
					removeEventListener(Event.ENTER_FRAME, playerLoop);
					removeEventListener(Event.ENTER_FRAME, hitTestLeft);
					removeEventListener(Event.ENTER_FRAME, hitTestRight);
					removeEventListener(Event.ENTER_FRAME, hitTestUp);
					removeEventListener(Event.ENTER_FRAME, hitTestDown);
					removeEventListener(Event.ENTER_FRAME, cameraFollowPlayer);
					
					textXY = getTextXY();
					resetText = new ResetText;
					resetText.x = textXY.posX;
					resetText.y = textXY.posY;
					parent.addChild(resetText);

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

				addEventListener(Event.ENTER_FRAME, hitTestLeft);
				addEventListener(Event.ENTER_FRAME, hitTestRight);
				addEventListener(Event.ENTER_FRAME, hitTestUp);
				addEventListener(Event.ENTER_FRAME, hitTestDown);
				addEventListener(Event.ENTER_FRAME, playerLoop);
				addEventListener(Event.ENTER_FRAME, cameraFollowPlayer);

				gameState.gameTimeRemaining -= 10; //Time penalty for being hit

				x = startX;
				y = startY;

				playerHit = false;

				parent.removeChild(resetText);
			}
		}

		//X and Y coordinates for restart text
		private function getTextXY()
		{
			if (parentClassHeight > 363 && parentClassWidth > 483)
			{
				switch (getXY())
				{
					case "middle":
					//resetText.x = x;
					//resetText.y = y;
					return {posX: x, posY: y};
					break;

					case "top left":
					//resetText.x = leftX + 240;
					//resetText.y = topY + 180;
					return {posX: leftX + 240, posY: topY + 180};
					break;

					case "bottom left":
					//resetText.x = leftX + 240;
					//resetText.y = bottomY - 180;
					return {posX: leftX + 240, posY: bottomY - 180};
					break;
					
					case "top right":
					//resetText.x = rightX - 240;
					//resetText.y = topY + 180;
					return {posX: rightX - 240, posY: topY + 180};
					break;
					
					case "bottom right":
					//resetText.x = rightX - 240;
					//resetText.y = bottomY - 180;
					return {posX: rightX - 240, posY: bottomY - 180};
					break;

					case "left":
					//resetText.x = leftX + 240;
					//resetText.y = y;
					return {posX: leftX + 240, posY: y};
					break;
					
					case "right":
					//resetText.x = rightX - 240;
					//resetText.y = y;
					return {posX: rightX - 240, posY: y};
					break;
					
					case "top":
					//resetText.x = x;
					//resetText.y = topY + 180;
					return {posX: x, posY: topY + 180};
					break;
					
					case "bottom":
					//resetText.x = x;
					//resetText.y = bottomY - 180;
					return {posX: x, posY: bottomY - 180};
					break;
				}
			}
			else
			{
				//resetText.x = 240;
				//resetText.y = 180;
				return {posX: 240, posY: 180};
			}
		}
		
		//Pick up powerup
		private function pickedUpPowerUp(pickedUp)
		{
			if (pickedUp.parent.name != "powerUpFrame")
			{
				if (!gameState.powerUpActive)
				{
					gameState.effectVolume.volume = 0.1;
					gameState.effectChannel = gameState.pickUpPowerUp.play(0, 0, gameState.effectVolume)
					
					if (gameState.heldPowerUp)
					{
						userInterface.powerUpFrame.removeChild(gameState.curPowerUp);
					}
					
					gameState.curPowerUp = pickedUp;
					gameState.curPowerUp.x = 0;
					gameState.curPowerUp.y = 0;
					parent.removeChild(pickedUp);
					gameState.heldPowerUp = true;
					trace("Holding " + gameState.curPowerUp.name);
					userInterface.powerUpFrame.addChild(gameState.curPowerUp);
				}
			}
		}
		
		//Use powerup
		private function usedPowerUp(e:Event)
		{
			if (gameState.powerUpActive)
			{
				if (gameState.curPowerUp.name.indexOf("energy") >= 0)
				{
					speed = 6;
				}
				if (gameState.curPowerUp.name.indexOf("coffee") >= 0)
				{
					if (key.isDown(key.SHIFT) && !gameState.cooldown)
					{
						speed = 8;
					}
					else
					{
						speed = 4;
					}
					speedMult = 0.5;
				}
				
				if (gameState.powerUpTime > 0)
				{
					gameState.powerUpTime -= 10;
				}
				else if (gameState.powerUpTime <= 0)
				{
					removeEventListener(Event.ENTER_FRAME, usedPowerUp);
					gameState.powerUpActive = false;
					gameState.powerUpTime = 1000;
					
					if (gameState.curPowerUp.name.indexOf("coffee") >= 0)
					{
						speed = 3;
						speedMult = 1;
					}
					if (gameState.curPowerUp.name.indexOf("energy") >= 0)
					{
						speed = 3;
					}
					
					userInterface.powerUpFrame.removeChild(gameState.curPowerUp);
					gameState.heldPowerUp = false;
					gameState.curPowerUp = new MovieClip;
				}
			}
		}
		
		//Player loop
		private function playerLoop(e:Event)
		{
			playerX = x;
			playerY = y;
			
			leftKey = key.isDown(key.LEFT), key.isDown(key.A);
			rightKey = key.isDown(key.RIGHT), key.isDown(key.D);
			upKey = key.isDown(key.UP), key.isDown(key.W);
			downKey = key.isDown(key.DOWN), key.isDown(key.S);

			//coordinates for debug purposes
			//trace("x " + x + " " + parentClass.x + " y " + y + " " + parentClass.y)
			if (playerAlive && !playerHit)
			{
				if (key.isDown(key.SHIFT) && !gameState.cooldown)
				{
					if (gameState.currentStamina > gameState.minStamina)
					{
						gameState.currentStamina -= 30 * speedMult;
						staminaBar.width = gameState.currentStamina / 10;
						//trace(gameState.currentStamina)
					}
					else if (gameState.currentStamina <= gameState.minStamina)
					{
						staminaColor = new ColorTransform(0,0,0,1,255,0,0,0);
						staminaBar.transform.colorTransform = staminaColor;
						gameState.cooldown = true;
						trace("SPRINT COOLDOWN")
					}
					speed = 6;
				}
				else
				{
					if (gameState.currentStamina < gameState.maxStamina)
					{
						staminaBar.width = gameState.currentStamina / 10;
						gameState.currentStamina += 10 * speedMult;
						//trace(gameState.currentStamina)
					}
					else if (gameState.currentStamina >= gameState.maxStamina)
					{
						staminaColor = new ColorTransform(0,0,0,1,0,255,0,0);
						staminaBar.transform.colorTransform = staminaColor;
						gameState.cooldown = false;
					}
					if (!gameState.powerUpActive && gameState.curPowerUp.name.indexOf("energy"))
					{
						speed = 3;
					}
				}
				
				if (key.isDown(key.E) && !gameState.powerUpActive && gameState.heldPowerUp)
				{
					gameState.effectVolume.volume = 0.1;
					gameState.effectChannel = gameState.usePowerUpEffect.play(0, 0, gameState.effectVolume)
						
					gameState.powerUpActive = true;
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

				//if time runs to 0 game over
				if (gameState.gameTimeRemaining <= 0)
				{
					switch (lastDirection)
					{
						case "left_stop":
						this.gotoAndStop("left_hit");
						break;

						case "right_stop":
						this.gotoAndStop("right_hit");
						break;

						case "up_stop":
						this.gotoAndStop("up_hit");
						break;

						case "down_stop":
						this.gotoAndStop("down_hit");
						break;
					}
					
					gameState.musicChannel.stop()
					gameState.volume.volume = 0.1;
					gameState.musicChannel = gameState.deathMusic.play(0, 0, gameState.volume)
					
					playerAlive = false;
					addEventListener(Event.ENTER_FRAME, playerDown);
					removeEventListeners();

					textXY = getTextXY();
					gameOverText = new GameOverText;
					gameOverText.x = textXY.posX;
					gameOverText.y = textXY.posY;
					parent.addChild(gameOverText);
				}
			}
		}
	}
}