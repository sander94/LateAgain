package
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	
	public class ExitButton extends SimpleButton
	{
		public function ExitButton(upState:DisplayObject=null, overState:DisplayObject=null, downState:DisplayObject=null, hitTestState:DisplayObject=null)
		{
			super(upState, overState, downState, hitTestState);
		}
	}
}