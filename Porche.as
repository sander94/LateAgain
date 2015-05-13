package
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Porche extends MovieClip
	{
		private var curScene;
		
		public function Porche(scene)
		{
			curScene = scene;
			
			var _randomNumber:Number = Math.ceil(Math.random() * 10);
			//trace("randomNumber: " + _randomNumber);
			
			if(_randomNumber < 5)
				this.gotoAndStop("audi_drive");
			else if(_randomNumber >= 5 && _randomNumber < 6)
				this.gotoAndStop("porche_drive");
			else if(_randomNumber >= 6 && _randomNumber < 9)
				this.gotoAndStop("taxi_drive");
			else if(_randomNumber >= 9)
				this.gotoAndStop("cop_drive");
			
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
				x -= 8;
			}
		}

		public function removeEventListeners()
		{
			removeEventListener(Event.ENTER_FRAME, PorcheMove)
		}
	}
}