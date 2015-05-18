package
{
	import KeyObject;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.filesystem.*;
	
	public class EndScene extends MovieClip
	{
		private var key:KeyObject;
		private var stageRef:Stage;
		private var gameState:GameState;
		private var topScores:File = File.documentsDirectory;
		private var fileStream:FileStream = new FileStream();

		public function EndScene(passedClass:GameState, stageRef:Stage)
		{
			trace("EndScene");
			topScores = topScores.resolvePath("LateAgain/TopScores.txt");
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			gameState = passedClass;

			if (!topScores.exists)
			{
				fileStream.open(topScores, FileMode.WRITE);
				fileStream.writeUTFBytes("This is my text file.");
				fileStream.close();
			}

			addEventListener(KeyboardEvent.KEY_UP, keyPressed);
		}

		private function keyPressed(e:Event)
		{
			if (key.isDown(key.ENTER))
			{
				fileStream.open(topScores, FileMode.READ);
				trace(fileStream.readUTF())
				//scoreboard.text = fileStream.readUTF();
				fileStream.close();
			}
		}
	}
}