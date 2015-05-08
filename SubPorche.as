package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import SuburbScene;
	
	public class SubPorche extends MovieClip
	{
		public function SubPorche()
		{
			addEventListener(Event.ENTER_FRAME, PorcheMove,false,0,true)
		}
		
		private function PorcheMove(e:Event)
		{
			if (x < -30)
			{
				//trace("Porche REMOVE")
				SuburbScene.carList.shift();
				removeEventListener(Event.ENTER_FRAME, PorcheMove);
				this.parent.removeChild(this);
				//trace(SuburbScene.carList)
			}
			else
			{
				x -= 8;
			}
		}
	}
}