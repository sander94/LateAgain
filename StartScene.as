package
{
	import KeyObject;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class StartScene extends MovieClip
	{
		private var _gameState:GameState;
		private var stageRef:Stage;
		private var key:KeyObject;
		
		private var introMusic:Sound = new MusicIntro;							// reference to imported music in Flash library
		private var volume:SoundTransform = new SoundTransform(0.2, 0);			// volume control and panning
		private var introChannel:SoundChannel = new SoundChannel;				// needed to control sound beyond the basic .play() command
		
		public function StartScene(passedClass:GameState, stageRef:Stage)
		{
			key = new KeyObject(stageRef);
			_gameState = passedClass;
			this.stageRef = stageRef;
			
			introChannel = introMusic.play(0, 10, volume);
			
			addEventListener(Event.ENTER_FRAME, mainLoop);
		}

		private function mainLoop(e:Event)
		{
			root.scrollRect = new Rectangle(0, 0, stageRef.stageWidth, stageRef.stageHeight);

			if (key.isDown(key.SPACE))
			{
				removeEventListener(Event.ENTER_FRAME, mainLoop)
				introChannel.stop()
				_gameState.homeScene();
			}
		}
		
	}
}