package
{
	import flash.display.*;
	import flash.events.*;
	public class Wire extends MovieClip implements Circuitry
	{
		public var active = false;
		public var powerDir:int;
		public var myArena:Arena;
		public var col;
		public var row;
		public function Wire(Column:Number, Row:Number, lvl:Arena)
		{
			x = Column*30;
			y = Row*30;
			col = Column;
			row = Row;
			myArena = lvl;
			gotoAndStop(1);
			powerDir = -1;
			alpha = .25;
		}
		public function getColumn():int
		{
			return col;
		}
		public function getRow():int
		{
			return row;
		}
		public function connections():Array
		{
			var connect:Array = new Array(false,false,false,false);
			for each(var thing:MovieClip in myArena.levelStuff)
			{
				if(thing is Circuitry)
				{
					if(thing.col == col)
					{
						if(thing.row == row-1)
							connect[1] = true;
						else if(thing.row == row+1)
							connect[3] = true;
					}
					if(thing.row == row)
					{
						if(thing.col == col-1)
							connect[0] = true;
						else if(thing.col == col+1)
							connect[2] = true;
					}
				}
			}
			return connect;
		}
		public function changeFrame():void
		{
			var cons = connections();
			if(cons[0])
			{
				if(cons[1])
				{
					if(cons[2])
					{
						if(cons[3])
							gotoAndStop(16);
						else
							gotoAndStop(13);
					}
					else if(cons[3])
						gotoAndStop(12);
					else
						gotoAndStop(8);
				}
				else if(cons[2])
				{
					if(cons[3])
						gotoAndStop(15);
					else
						gotoAndStop(6);
				}
				else if(cons[3])
					gotoAndStop(11);
				else
					gotoAndStop(2);
			}
			else if(cons[1])
			{
				if(cons[2])
				{
					if(cons[3])
						gotoAndStop(14);
					else
						gotoAndStop(9);
				}
				else if(cons[3])
					gotoAndStop(7);
				else
					gotoAndStop(3);
			}
			else if(cons[2])
			{
				if(cons[3])
					gotoAndStop(10);
				else
					gotoAndStop(4);
			}
			else if(cons[3])
				gotoAndStop(5);
			else
				gotoAndStop(1);
		}
		public function getAdjacentCircuitry():Array
		{
			var output = new Array();
			for each(var item:MovieClip in myArena.levelStuff)
			{
				if(item is Circuitry && !(item is Button))
				{
					if(item.getColumn() == getColumn() && !item.isActive() == active)
					{
						if(item.getRow() == getRow()+1 || item.getRow() == getRow()-1)
						{
							output.push(item);
						}
					}
					else if(item.getRow() == getRow() && !item.isActive() == active)
					{
						if(item.getColumn() == getColumn()+1 || item.getColumn() == getColumn()-1)
						{
							output.push(item);
						}
					}
				}
			}
			return output;
		}
		public function isActive():Boolean
		{
			return active;
		}
		public function activate():void
		{
			if(!active)
			{
				active = true;
				alpha = .75;
				for each(var item:MovieClip in getAdjacentCircuitry())
				{
					if(item is Wire || item is Door)
					{
						if(item.col > col)
							item.powerDir = 0;
						else if(item.col < col)
							item.powerDir = 2;
						else if(item.row > row)
							item.powerDir = 1;
						else
							item.powerDir = 3;
						item.activate();
					}
				}
			}
		}
		public function deactivate():void
		{
			if(active)
			{
				powerDir = -1;
				active = false;
				alpha = .25;
				for each(var box:MovieClip in getAdjacentCircuitry())
				{
					if(box is Wire || box is Door)
					{
						if(box.col > col && box.powerDir == 0)
							box.deactivate();
						else if(box.col < col && box.powerDir == 2)
							box.deactivate();
						else if(box.row > row && box.powerDir == 1)
							box.deactivate();
						else if(box.row < row && box.powerDir == 3)
							box.deactivate();
					}
				}
				for each(var thing:MovieClip in getAdjacentCircuitry())
				{
					if(thing is Wire || thing is Button)
					{
						if(thing.isActive())
						{
							if(thing.col > col)
								powerDir = 2;
							else if(thing.col < col)
								powerDir = 0;
							else if(thing.row > row)
								powerDir = 3;
							else
								powerDir = 1;
							activate();
						}
					}
				}
			}
		}
	}
}