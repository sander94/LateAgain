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

			addEventListener(Event.ENTER_FRAME, PorcheMove,false,0,true)
		}
		
		private function PorcheMove(e:Event)
		{
			if (x < -30)
			{
				curScene.objects.shift();
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