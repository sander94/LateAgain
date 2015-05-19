package
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Cars extends MovieClip
	{
		private var driveDirection:String;
		
		public function Cars(carDirection)
		{
			driveDirection = carDirection;
			var typeRandomNumber:Number = Math.ceil(Math.random() * 10);
			//trace("randomNumber: " +typeRandomNumber)
			
			if(typeRandomNumber < 4)
				this.gotoAndStop("audi_drive_" + driveDirection);
			else if(typeRandomNumber >= 4 && typeRandomNumber < 5)
				this.gotoAndStop("porche_drive_" + driveDirection);
			else if(typeRandomNumber >= 5 && typeRandomNumber < 7)
				this.gotoAndStop("pickup_drive_" + driveDirection);
			else if(typeRandomNumber >= 7 && typeRandomNumber < 9)
				this.gotoAndStop("taxi_drive_" + driveDirection);
			else if(typeRandomNumber >= 9 && typeRandomNumber <= 10)
				this.gotoAndStop("cop_drive_" + driveDirection);
			
			addEventListener(Event.ENTER_FRAME, carMove,false,0,true)
		}
		
		private function carMove(e:Event)
		{
			if (x < -40 && driveDirection == "left")
			{
				removeEventListener(Event.ENTER_FRAME, carMove);
				this.parent.removeChild(this);
			}
			else if (driveDirection == "left")
			{
				x -= 8 * Player.speedMult;
			}
			
			if (x > 1100 && driveDirection == "right")
			{
				removeEventListener(Event.ENTER_FRAME, carMove);
				this.parent.removeChild(this);
			}
			else if (driveDirection == "right")
			{
				x += 8 * Player.speedMult;
			}
		}

		public function removeEventListeners()
		{
			removeEventListener(Event.ENTER_FRAME, carMove);
		}
	}
}