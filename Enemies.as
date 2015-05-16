package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	
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

		public function Enemies(passedType, initialDirection, passedX, passedY)
		//passedType is the type of enemy, initalDirection is the direction the enemy will start to patrol towards, passedX and passedY are the spawn X and Y coordinates of the enemy
		{
			startDirection = initialDirection;
			enemyType = passedType;
			this.gotoAndStop(enemyType + "_move_" + startDirection);
			startX = passedX;
			startY = passedY;

			addEventListener(Event.ENTER_FRAME, playerInRange,false,0,true);

			switch (enemyType) //Initial switch statement, all enemies default to patrol, but may have different patrol times and walk speeds
			{
				case "granny":
				speed = 2;
				addEventListener(Event.ENTER_FRAME, patrol,false,0,true);
				patrolTimer = new Timer(1000);
				patrolTimer.start();
				patrolTimer.addEventListener(TimerEvent.TIMER, patrolTimerTick,false,0,true);
				break;

				/*case "enemy2":
				speed = 3;
				addEventListener(Event.ENTER_FRAME, patrol,false,0,true);
				patrolTimer = new Timer(1500);
				patrolTimer.start();
				patrolTimer.addEventListener(TimerEvent.TIMER, patrolTimerTick,false,0,true);
				break;*/
			}
		}

		private function playerInRange(e:Event)
		{
			if (Player.playerX < x + 100 && Player.playerX > x - 100 && Player.playerY < y + 100 && Player.playerY > y - 100 && Player.playerAlive && !Player.playerHit)
			{
				inRange = true;

				switch (enemyType) //Switch statement only for enemies that will chace player
				{
					case "granny":
					addEventListener(Event.ENTER_FRAME, chaser,false,0,true);
					break;

					/*case "enemy3":
					addEventListener(Event.ENTER_FRAME, chaser,false,0,true);
					break;*/
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
				patrolTimer.removeEventListener(TimerEvent.TIMER, patrolTimerTick);
				removeEventListener(Event.ENTER_FRAME, patrol);
				patrolTimer.stop();
				returnToStart = false;

				if (Player.playerX > x + 3)
				{
					this.gotoAndStop(enemyType + "_move_right");
					x += speed * Player.speedMult;
				}
				if (Player.playerX < x - 3)
				{
					this.gotoAndStop(enemyType + "_move_left");
					x -= speed * Player.speedMult;
				}
				if (Player.playerY > y + 3)
				{
					this.gotoAndStop(enemyType + "_move_down");
					y += speed * Player.speedMult;
				}
				if (Player.playerY < y - 3)
				{
					this.gotoAndStop(enemyType + "_move_up");
					y -= speed * Player.speedMult;
				}
			}
			else//Else return to spawn point and resume patrolling
			{
				if (x > startX)
				{
					this.gotoAndStop(enemyType + "_move_left");
					x -= speed * Player.speedMult;
				}
				if (x < startX)
				{
					this.gotoAndStop(enemyType + "_move_right");
					x += speed * Player.speedMult;
				}
				if (y > startY)
				{
					this.gotoAndStop(enemyType + "_move_up");
					y -= speed * Player.speedMult;
				}
				if (y < startY)
				{
					this.gotoAndStop(enemyType + "_move_down");
					y += speed * Player.speedMult;
				}
				if (x == startX && y == startY)
				{
					removeEventListener(Event.ENTER_FRAME, chaser);
					addEventListener(Event.ENTER_FRAME, patrol,false,0,true);
					patrolTimer = new Timer(1000);
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
				if (returnToStart)
				{
					this.gotoAndStop(enemyType + "_move_right");
					x += speed * Player.speedMult;
				}
				else if (!returnToStart)
				{
					this.gotoAndStop(enemyType + "_move_left");
					x -= speed * Player.speedMult;
				}
				break;

				case "right":
				if (returnToStart)
				{
					this.gotoAndStop(enemyType + "_move_left");
					x -= speed * Player.speedMult;
				}
				else if (!returnToStart)
				{
					this.gotoAndStop(enemyType + "_move_right");
					x += speed * Player.speedMult;
				}
				break;

				case "down":
				if (returnToStart)
				{
					this.gotoAndStop(enemyType + "_move_up");
					y -= speed * Player.speedMult;
				}
				else if (!returnToStart)
				{
					this.gotoAndStop(enemyType + "_move_down");
					y += speed * Player.speedMult;
				}
				break;

				case "up":
				if (returnToStart)
				{
					this.gotoAndStop(enemyType + "_move_down");
					y += speed * Player.speedMult;
				}
				else if (!returnToStart)
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
			patrolTimer.removeEventListener(TimerEvent.TIMER, patrolTimerTick)
		}
	}
}