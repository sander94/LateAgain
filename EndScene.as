package
{
	import KeyObject;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.geom.Rectangle;
	import flash.filesystem.*;
	public class EndScene extends MovieClip
	{
		private var key:KeyObject;
		private var stageRef:Stage;
		private var gameState:GameState;
		private var topScores:File = File.documentsDirectory;
		private var fileStream:FileStreamWithLineReader = new FileStreamWithLineReader;

		public function EndScene(passedClass:GameState, stageRef:Stage)
		{
			trace("EndScene");
			topScores = topScores.resolvePath("LateAgainScores/TopScores.txt"); //creates a LateAgainScores in Documents folder
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			gameState = passedClass;
			inputField.maxChars = 25;

			if (!topScores.exists)
			{
				fileStream.open(topScores, FileMode.WRITE);
				fileStream.close();
			}

			fileStream.open(topScores, FileMode.READ);
			while(fileStream.bytesAvailable)
			{
				for(var i = 1; i <= 10; i++)
				{
				    var line:String = fileStream.readUTFLine();
				    scoreboard.appendText(line + "  ---  ");
				    line = fileStream.readUTFLine();
				    scoreboard.appendText(line + "\n");
				}
			}

			fileStream.close();

			addEventListener(Event.ENTER_FRAME, mainLoop);
			addEventListener(MouseEvent.CLICK, inputFieldClicked);
		}

		private function inputFieldClicked(e:Event)
		{
			if (e.target == inputField)
			{
				inputField.text = "";
				addEventListener(KeyboardEvent.KEY_UP, keyPressed);
			}
		}

		private function mainLoop(e:Event)
		{
			root.scrollRect = new Rectangle(0, 0, stageRef.stageWidth, stageRef.stageHeight); //needed to center the scene
		}

		private function keyPressed(e:Event)
		{
			if (key.isDown(key.ENTER))
			{
				fileStream.open(topScores, FileMode.APPEND);
				fileStream.writeUTFBytes(inputField.text + File.lineEnding);
				fileStream.writeUTFBytes(gameState.gameTimeRemaining + File.lineEnding);
				fileStream.close();
			}
		}
	}
}