package
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	
	public class StartButton extends SimpleButton
	{
		public function StartButton(upState:DisplayObject=null, overState:DisplayObject=null, downState:DisplayObject=null, hitTestState:DisplayObject=null)
		{
			super(upState, overState, downState, hitTestState);
		}
	}
}