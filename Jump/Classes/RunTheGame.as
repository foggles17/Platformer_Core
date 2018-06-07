package
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	public class RunTheGame extends MovieClip
	{
		public var game:Arena;
		public var pauseMenu:PauseMenu;
		public var mainMenu:MainMenu;
		public var level:int = 0;
		public var holdP:Boolean = false;
		public var holdR:Boolean = false;
		public var keys:Array = new Array(128);
		public var returnTo:int = 0;
		public var numLevels = 25;
		public var levelMake:Array = new Array();
		public function RunTheGame()
		{
			for(var i = 0; i < numLevels; i++)
			{
				levelMake.push(new Array());
			}
			levelMake[0].push(new Array(1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1));
			levelMake[0].push(new Array(1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1));
			levelMake[0].push(new Array(1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1));
			levelMake[0].push(new Array(1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1));
			levelMake[0].push(new Array(1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1));
			levelMake[0].push(new Array(1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 10, -2,1.1));
			levelMake[0].push(new Array(1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 10,  0,1.1));
			levelMake[0].push(new Array(1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 10,  2,1.1));
			levelMake[0].push(new Array(1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 10,  5,1.1));
			levelMake[0].push(new Array(1,  0, 11, 11, 15,  6, 13,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 10,  0,1.1));
			levelMake[0].push(new Array(1,  0,  7,  0,  4,  0,  3,  2,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 10,  2,1.1));
			levelMake[0].push(new Array(1,  0,  7,  0, 11,  0,  3,  6,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 10,  5,1.1));
			levelMake[0].push(new Array(1,  0, 11,  0,  0,  0,  0,  0,  7,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 10,  0,1.1));
			levelMake[0].push(new Array(1,  0,  0,  0,  0,  0,  0,  0,  7, 13,  0,  0,  0,  0,  0,  0,  0,  0,  0, 10,  2,1.1));
			levelMake[0].push(new Array(1,  1, 14,  0,  0,  0,  0,  0, 14, 10,  0,  0,  0,  0,  0,  0,  0,  0,  0, 10,  5,1.1));
			levelMake[0].push(new Array(1,  0,  0,  0,  0,  0,  0,  0,  7,  3, -1, -2,0.1, -4,  0,  0, -3,  0,  0,  3,  0,1.1));
			levelMake[0].push(new Array(1,  1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1));
			
			game = new Arena(levelMake[0], this);
			addChild(game);
			game.visible = false;
			
			pauseMenu = new PauseMenu();
			addChild(pauseMenu);
			pauseMenu.visible = false;
			
			mainMenu = new MainMenu();
			addChild(mainMenu);
			mainMenu.visible = false;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
			stage.addEventListener(Event.ENTER_FRAME, go);
		}
		
		//keyListeners
		public function onKeyPress(event:KeyboardEvent):void
		{
			var key = event.keyCode;
			keys[key] = true;
		}
		public function onKeyRelease(event:KeyboardEvent):void
		{
			var key = event.keyCode;
			keys[key] = false;
		}
		public function restartLevel()
		{
			removeChild(game);
			game = new Arena(levelMake[0], this);
			addChild(game);
		}
		public function go(event:Event):void
		{
			if(keys[80])
			{
				if(!holdP)
				{
					if(level > -1)
					{
						returnTo = level;
						level = -1;
					}
					else
					{
						level = returnTo;
					}
					holdP = true;
				}
			}
			else
			{
				holdP = false;
			}
			if(keys[82])
			{
				if(!holdR)
				{
					restartLevel();
					holdR = true;
				}
			}
			else
			{
				holdR = false;
			}
			if(level >= 0)
			{
				pauseMenu.visible = false;
				mainMenu.visible = false;
				game.visible = true;
				game.run(event);
			}
			else if(level == -1)
			{
				pauseMenu.visible = true;
				mainMenu.visible = false;
				
			}
			else if(level == -2)
			{
				mainMenu.visible = true;
				game.visible = false;
				pauseMenu.visible = false;
				
			}
		}
	}
}