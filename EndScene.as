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
		private var line:String;
		private var scoresArray:Array;
		private var namesArray:Array;
		private var tempArray:Array; //used for matching sorting

		public function EndScene(passedClass:GameState, stageRef:Stage)
		{
			trace("EndScene");
			topScores = topScores.resolvePath("LateAgainScores/TopScores.txt"); //creates a LateAgainScores in Documents folder
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			gameState = passedClass;
			inputField.maxChars = 15; //maximum name length
			scoresArray = new Array;
			namesArray = new Array;
			tempArray = new Array;

			//create file if missing
			if (!topScores.exists)
			{
				fileStream.open(topScores, FileMode.WRITE);
				fileStream.close();
			}

			populateArrays();

			addEventListener(Event.ENTER_FRAME, mainLoop);
			addEventListener(MouseEvent.CLICK, inputFieldClicked);
		}

		//add currently existing scores and names to arrays
		private function populateArrays()
		{
			var i:int = 1;
			var namesInteger = 0;
			var scoresInteger = 0;

			fileStream.open(topScores, FileMode.READ);
			while(fileStream.bytesAvailable)
			{
				line = fileStream.readUTFLine();
				//every second line is score or name, assing them to correct arrays
				switch (i)
				{
					case 1:
					namesArray[namesInteger] = line;
					namesInteger++
					i = 2;
					break;

					case 2:
					scoresArray[Number(scoresInteger)] = line;
					scoresInteger++
					i = 1;
					break;
				}
			}
			fileStream.close();
			organizeArrays();
		}

		//sort scores in order from big to small
		private function organizeArrays()
		{
			while (scoresArray.length < namesArray.length)
			{
				namesArray.pop();
			}

			tempArray = scoresArray.slice(0, scoresArray.length); //clones scoresArray to tempArray
			tempArray.sort(Array.DESCENDING | Array.NUMERIC) //sorts tempArray in decending order, this is used as a refence in the actual sorting progress

			for (var j:int = 0; j < scoresArray.length; j++)
			{
				while (scoresArray[j] != tempArray[j])
				{
					scoresArray.push(scoresArray.splice(j, 1));
					namesArray.push(namesArray.splice(j, 1));
				}
			}

			//if more than 10 names and scores, remove rest
			while (scoresArray.length > 10)
			{
				scoresArray.pop();
				namesArray.pop();
			}

			writeToFile();
		}

		//writes the arrays to file
		private function writeToFile()
		{
			fileStream.open(topScores, FileMode.WRITE);

			for (var f = 0; f < scoresArray.length; f++)
			{
				line = namesArray[f];
				fileStream.writeUTFBytes(line + File.lineEnding);
				line = scoresArray[f];
				fileStream.writeUTFBytes(line + File.lineEnding);
			}
			fileStream.close();

			writeToScreen();
		}

		//print out the contnents of TopScores.txt
		private function writeToScreen()
		{
			scoreboard.text = "";
			var curPosition:int = 1;

			fileStream.open(topScores, FileMode.READ);
			while(fileStream.bytesAvailable)
			{
				line = fileStream.readUTFLine();
				scoreboard.appendText(curPosition + ". " + line + "  ---  ");
				line = fileStream.readUTFLine();
				scoreboard.appendText(line + "\n");
				curPosition++
			}
			fileStream.close();
		}

		//checks when player has clicked the input field
		private function inputFieldClicked(e:Event)
		{
			if (e.target == inputField)
			{
				inputField.text = "";
				addEventListener(KeyboardEvent.KEY_UP, keyPressed);
				removeEventListener(MouseEvent.CLICK, inputFieldClicked);
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
				namesArray.push(inputField.text);
				scoresArray.push(gameState.gameTimeRemaining);
				removeEventListener(KeyboardEvent.KEY_UP, keyPressed);
				organizeArrays();
			}
		}
	}
}