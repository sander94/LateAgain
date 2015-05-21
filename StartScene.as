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
		
		public function StartScene(passedClass:GameState, stageRef:Stage)
		{
			key = new KeyObject(stageRef);
			_gameState = passedClass;
			this.stageRef = stageRef;
			
			_gameState.volume.volume = 0.3;
			_gameState.musicChannel.stop()
			_gameState.musicChannel = _gameState.introMusic.play(0, 10, _gameState.volume);
			
			addEventListener(Event.ENTER_FRAME, mainLoop);
		}

		private function mainLoop(e:Event)
		{
			root.scrollRect = new Rectangle(0, 0, stageRef.stageWidth, stageRef.stageHeight);

			if (key.isDown(key.SPACE))
			{
				removeEventListener(Event.ENTER_FRAME, mainLoop)
				//_gameState.introChannel.stop()
				_gameState.homeScene();
			}
		}
		
	}
}