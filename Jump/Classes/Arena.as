package
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	public class Arena extends MovieClip
	{
		public var avatar:Avatar;
		public var levelStuff:Array = new Array(1);
		public var holdSpace:Boolean = false;
		public var runner:RunTheGame;
		public var yspeed:Number = 0;
		public var xspeed:Number = 0;
		public function Arena(levelItems:Array, master:RunTheGame)
		{
			runner = master;
			var avatarCol = 0;
			var avatarRow = 0;
			for(var i = 0; i < levelItems.length; i++)
			{
				for(var j = 0; j < levelItems[i].length; j++)
				{
					var current = levelItems[i][j];
					var num:int = Math.round(current);
					if(num == -5)
					{
						levelStuff.push(new Goal(j, i, this));
					}
					else if(current > -5 && current < -4)
					{
						levelStuff.push(new TrapDoor(j, i, this));
						current = 0;
					}
					else if(num == -4)
					{
						levelStuff.push(new TrapDoor(j, i, this));
					}
					else if(current > -4 && current < -3)
					{
						levelStuff.push(new Door(j, i, this));
						current = 0;
					}
					else if(num == -3)
					{
						levelStuff.push(new Door(j, i, this));
					}
					else if(num == -2)
					{
						levelStuff.push(new Button(j, i, this));
					}
					else if(num == -1)
					{
						avatarCol = j;
						avatarRow = i;
					}
					else if(num == 1)
					{
						levelStuff.push(new Wall(j*30,i*30,30,30));
					}
					else if(num == 2)
					{
						levelStuff.push(new Wall(j*30,i*30,15,15));
					}
					else if(num == 3)
					{
						levelStuff.push(new Wall(j*30+15,i*30,15,15));
					}
					else if(num == 4)
					{
						levelStuff.push(new Wall(j*30,i*30+15,15,15));
					}
					else if(num == 5)
					{
						levelStuff.push(new Wall(j*30+15,i*30+15,15,15));
					}
					else if(num == 6)
					{
						levelStuff.push(new Wall(j*30,i*30,30,15));
					}
					else if(num == 7)
					{
						levelStuff.push(new Wall(j*30,i*30,15,30));
					}
					else if(num == 8)
					{
						levelStuff.push(new Wall(j*30,i*30,15,15));
						levelStuff.push(new Wall(j*30+15,i*30+15,15,15));
					}
					else if(num == 9)
					{
						levelStuff.push(new Wall(j*30+15,i*30,15,15));
						levelStuff.push(new Wall(j*30,i*30+15,15,15));
					}
					else if(num == 10)
					{
						levelStuff.push(new Wall(j*30+15,i*30,15,30));
					}
					else if(num == 11)
					{
						levelStuff.push(new Wall(j*30,i*30+15,30,15));
					}
					else if(num == 12)
					{
						levelStuff.push(new Wall(j*30,i*30,30,15));
						levelStuff.push(new Wall(j*30,i*30+15,15,15));
					}
					else if(num == 13)
					{
						levelStuff.push(new Wall(j*30,i*30,30,15));
						levelStuff.push(new Wall(j*30+15,i*30+15,15,15));
					}
					else if(num == 14)
					{
						levelStuff.push(new Wall(j*30,i*30,15,15));
						levelStuff.push(new Wall(j*30,i*30+15,30,15));
					}
					else if(num == 15)
					{
						levelStuff.push(new Wall(j*30+15,i*30,15,15));
						levelStuff.push(new Wall(j*30,i*30+15,30,15));
					}
					else if(num >= 16 && num <= 19)
					{
						levelStuff.push(new Spike(j,i,num-16));
					}
					if(Math.abs(current) % 1 > 0)
					{
						levelStuff.push(new Wire(j,i, this));
					}
				}
			}
			
			for each(var item:MovieClip in levelStuff)
			{
				addChild(item);
				if(item is Wire)
				{
					item.changeFrame();
				}
			}
			
			avatar = new Avatar(avatarCol, avatarRow, this);
			addChild(avatar);
		}
		
		//main method type thing
		public function run(event:Event):void
		{
			if(runner.keys[Keyboard.SPACE])
			{
				if(!holdSpace)
				{
					for each(var item:MovieClip in levelStuff)
					{
						if(item is Button)
						{
							if(avatar.x+7.5>item.x && avatar.x+7.5<item.x+30 && avatar.y+15>item.y && avatar.y+15<item.y+30)
							{
								if(!item.isActive())
									item.activate();
								else
									item.deactivate();
							}
						}
					}
					holdSpace = true;
				}
			}
			else
			{
				holdSpace = false;
			}
			avatar.act();
			//pressing runner.keys
			x = -avatar.x+312.5;
			y = -avatar.y+165;
		}
	}
}