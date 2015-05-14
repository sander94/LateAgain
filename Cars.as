package
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Cars extends MovieClip
	{
		private var curScene;
		
		public function Cars(scene)
		{
			curScene = scene;
			
			var _randomNumber:Number = Math.ceil(Math.random() * 10);
			//trace("randomNumber: " + _randomNumber);
			
			if(_randomNumber < 5)
				this.gotoAndStop("audi_drive_left");
			else if(_randomNumber >= 5 && _randomNumber < 6)
				this.gotoAndStop("porche_drive_left");
			else if(_randomNumber >= 6 && _randomNumber < 9)
				this.gotoAndStop("taxi_drive_left");
			else if(_randomNumber >= 9)
				this.gotoAndStop("cop_drive_left");
			
			addEventListener(Event.ENTER_FRAME, PorcheMove,false,0,true)
		}
		
		private function PorcheMove(e:Event)
		{
			if (x < -40)
			{
				//curScene.objects.
				removeEventListener(Event.ENTER_FRAME, PorcheMove);
				this.parent.removeChild(this);
			}
			else
			{
				x -= 8 * curScene.speedMult;
			}
		}

		public function removeEventListeners()
		{
			removeEventListener(Event.ENTER_FRAME, PorcheMove)
		}
	}
}