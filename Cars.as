package
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Cars extends MovieClip
	{
		public function Cars(driveDirection)
		{
			var typeRandomNumber:Number = Math.ceil(Math.random() * 10);
			trace("randomNumber: " +typeRandomNumber)
			
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
			if (x < -40)
			{
				removeEventListener(Event.ENTER_FRAME, carMove);
				this.parent.removeChild(this);
			}
			else
			{
				x -= 8 * Player.speedMult;
			}
		}

		public function removeEventListeners()
		{
			removeEventListener(Event.ENTER_FRAME, carMove);
		}
	}
}