package
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	
	public class InstructionsButton extends SimpleButton
	{
		public function InstructionsButton(upState:DisplayObject=null, overState:DisplayObject=null, downState:DisplayObject=null, hitTestState:DisplayObject=null)
		{
			super(upState, overState, downState, hitTestState);
		}
	}
}