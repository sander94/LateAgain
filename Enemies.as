package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.text.*;
	
	public class Enemies extends MovieClip
	{
		private var startDirection:String;
		private var speed:Number;
		private var startX:Number;
		private var startY:Number;
		private var enemyType:String;
		private var returnToStart:Boolean = false;
		private var inRange:Boolean = true;
		private var patrolTimer:Timer = new Timer(1000);		// 1000ms == 1second

		private var hitboxLeft:MovieClip = new HitboxLeft;		// collision detection movieclips, alpha at 1%
		private var hitboxRight:MovieClip = new HitboxRight;
		private var hitboxDown:MovieClip = new HitboxDown;
		private var hitboxUp:MovieClip = new HitboxUp;

		private var leftCollision:Boolean = false;
		private var rightCollision:Boolean = false;
		private var upCollision:Boolean = false;
		private var downCollision:Boolean = false;

		public function Enemies(passedType, initialDirection, passedX, passedY)
		//passedType is the type of enemy, initalDirection is the direction the enemy will start to patrol towards, passedX and passedY are the spawn X and Y coordinates of the enemy
		{
			startDirection = initialDirection;
			enemyType = passedType;
			this.gotoAndStop(enemyType + "_move_" + startDirection);
			startX = passedX;
			startY = passedY;

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

			addEventListener(Event.ENTER_FRAME, playerInRange,false,0,true);
			addEventListener(Event.ENTER_FRAME, hitTestPointHor);
			addEventListener(Event.ENTER_FRAME, hitTestPointVer);

			switch (enemyType) //Initial switch statement, all enemies default to patrol, but may have different patrol times and walk speeds
			{
				case "granny":
				speed = 2;
				addEventListener(Event.ENTER_FRAME, patrol,false,0,true);
				patrolTimer = new Timer(1600);
				patrolTimer.start();
				patrolTimer.addEventListener(TimerEvent.TIMER, patrolTimerTick,false,0,true);
				break;

				case "nazi":
				speed = 1;
				addEventListener(Event.ENTER_FRAME, patrol,false,0,true);
				patrolTimer = new Timer(2000);
				patrolTimer.start();
				patrolTimer.addEventListener(TimerEvent.TIMER, patrolTimerTick,false,0,true);
				break;
				
				case "suit":
				speed = 2;
				addEventListener(Event.ENTER_FRAME, patrol,false,0,true);
				patrolTimer = new Timer(2400);
				patrolTimer.start();
				patrolTimer.addEventListener(TimerEvent.TIMER, patrolTimerTick,false,0,true);
				break;
			}
		}

		//Hit detection
		private function hitTestPointHor(e:Event)
		{
			if (Player.playerAlive)
			{
				for (var i = 0; i < Player.curScene.objects.length; i++)
				{
					//If hit check
					if (Player.curScene.objects[i].hitTestObject(hitboxLeft) && !(Player.curScene.objects[i].name.indexOf("enemy") >= 0) && !(Player.curScene.objects[i].name.indexOf("power") >= 0))
					{
						//Stop movement in that direction
						leftCollision = true;
						trace("leftCollision")
						break;
					}
					else
					{
						leftCollision = false;
					}
					
					if (Player.curScene.objects[i].hitTestObject(hitboxRight) && !(Player.curScene.objects[i].name.indexOf("enemy") >= 0) && !(Player.curScene.objects[i].name.indexOf("power") >= 0))
					{
						rightCollision = true;
						trace("rightCollision")
						break;
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
			if (Player.playerAlive)
			{
				for (var i = 0; i < Player.curScene.objects.length; i++)
				{
					if (Player.curScene.objects[i].hitTestObject(hitboxUp) && !(Player.curScene.objects[i].name.indexOf("enemy") >= 0) && !(Player.curScene.objects[i].name.indexOf("power") >= 0))
					{
						upCollision = true;
						trace("upCollision")
						break;
					}
					else
					{
						upCollision = false;
					}
					
					if (Player.curScene.objects[i].hitTestObject(hitboxDown) && !(Player.curScene.objects[i].name.indexOf("enemy") >= 0) && !(Player.curScene.objects[i].name.indexOf("power") >= 0))
					{
						downCollision = true;
						trace("downCollision")
						break;
					}
					else
					{
						downCollision = false;
					}
				}
			}
		}

		private function playerInRange(e:Event)
		{
			if (Player.playerX < x + 100 && Player.playerX > x - 100 && Player.playerY < y + 100 && Player.playerY > y - 100 && Player.playerAlive && !Player.playerHit)
			{
				inRange = true;

				switch (enemyType) //Switch statement only for enemies that will chace player
				{
					case "suit":
					addEventListener(Event.ENTER_FRAME, chaser,false,0,true);
					patrolTimer.removeEventListener(TimerEvent.TIMER, patrolTimerTick);
					removeEventListener(Event.ENTER_FRAME, patrol);
					patrolTimer.stop();
					returnToStart = false;
					break;

					case "nazi":
					addEventListener(Event.ENTER_FRAME, chaser,false,0,true);
					patrolTimer.removeEventListener(TimerEvent.TIMER, patrolTimerTick);
					removeEventListener(Event.ENTER_FRAME, patrol);
					patrolTimer.stop();
					returnToStart = false;
					break;

					default:
					break;
				}
			}
			else
			{
				inRange = false;
			}
		}
		
		private function chaser(e:Event)
		{
			if (inRange)//If player in range, chase
			{
				if (Player.playerX > x + 3 && !rightCollision)
				{
					this.gotoAndStop(enemyType + "_move_right");
					x += speed * Player.speedMult;
				}
				if (Player.playerX < x - 3 && !leftCollision)
				{
					this.gotoAndStop(enemyType + "_move_left");
					x -= speed * Player.speedMult;
				}
				if (Player.playerY > y + 3 && !downCollision)
				{
					this.gotoAndStop(enemyType + "_move_down");
					y += speed * Player.speedMult;
				}
				if (Player.playerY < y - 3 && !upCollision)
				{
					this.gotoAndStop(enemyType + "_move_up");
					y -= speed * Player.speedMult;
				}
			}
			else//Else return to spawn point and resume patrolling
			{
				if (x > startX && !leftCollision)
				{
					this.gotoAndStop(enemyType + "_move_left");
					x -= speed * Player.speedMult;
				}
				if (x < startX && !rightCollision)
				{
					this.gotoAndStop(enemyType + "_move_right");
					x += speed * Player.speedMult;
				}
				if (y > startY && !upCollision)
				{
					this.gotoAndStop(enemyType + "_move_up");
					y -= speed * Player.speedMult;
				}
				if (y < startY && !downCollision)
				{
					this.gotoAndStop(enemyType + "_move_down");
					y += speed * Player.speedMult;
				}
				if (x == startX && y == startY)
				{
					removeEventListener(Event.ENTER_FRAME, chaser);
					addEventListener(Event.ENTER_FRAME, patrol,false,0,true);
					patrolTimer.start();
					patrolTimer.addEventListener(TimerEvent.TIMER, patrolTimerTick,false,0,true);
				}
			}
		}

		private function patrol(e:Event)//Process patrol direction based on startDirection
		{
			switch (startDirection)
			{
				case "left":
				if (returnToStart && !rightCollision)
				{
					this.gotoAndStop(enemyType + "_move_right");
					x += speed * Player.speedMult;
				}
				else if (!returnToStart && !leftCollision)
				{
					this.gotoAndStop(enemyType + "_move_left");
					x -= speed * Player.speedMult;
				}
				break;

				case "right":
				if (returnToStart && !leftCollision)
				{
					this.gotoAndStop(enemyType + "_move_left");
					x -= speed * Player.speedMult;
				}
				else if (!returnToStart && !rightCollision)
				{
					this.gotoAndStop(enemyType + "_move_right");
					x += speed * Player.speedMult;
				}
				break;

				case "down":
				if (returnToStart && !upCollision)
				{
					this.gotoAndStop(enemyType + "_move_up");
					y -= speed * Player.speedMult;
				}
				else if (!returnToStart && !downCollision)
				{
					this.gotoAndStop(enemyType + "_move_down");
					y += speed * Player.speedMult;
				}
				break;

				case "up":
				if (returnToStart && !downCollision)
				{
					this.gotoAndStop(enemyType + "_move_down");
					y += speed * Player.speedMult;
				}
				else if (!returnToStart && !upCollision)
				{
					this.gotoAndStop(enemyType + "_move_up");
					y -= speed * Player.speedMult;
				}
				break;
			}
		}

		private function patrolTimerTick(timerEvent:TimerEvent):void//Every time timer runs to 0, change patrol direction
		{
			if (returnToStart)
			{
				returnToStart = false;
			}
			else
			{
				returnToStart = true;
			}
		}

		public function removeEventListeners()
		{
			removeEventListener(Event.ENTER_FRAME, chaser);
			removeEventListener(Event.ENTER_FRAME, patrol);
			removeEventListener(Event.ENTER_FRAME, playerInRange);
			patrolTimer.removeEventListener(TimerEvent.TIMER, patrolTimerTick);
			removeEventListener(Event.ENTER_FRAME, hitTestPointHor);
			removeEventListener(Event.ENTER_FRAME, hitTestPointVer);
		}
	}
}