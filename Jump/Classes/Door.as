package
{
	import flash.display.*;
	import flash.events.*;
	public class Door extends MovieClip implements Platform, Circuitry
	{
		public var active;
		public var powerDir:int;
		public var connections:Array;
		public var myArena:Arena;
		public var col;
		public var row;
		public function Door(Column:Number, Row:Number, lvl:Arena)
		{
			x = Column*30;
			y = Row*30;
			col = Column;
			row = Row;
			myArena = lvl;
			active = false;
			gotoAndStop(1);
		}
		public function getColumn():int
		{
			return col;
		}
		public function getRow():int
		{
			return row;
		}
		public function getAdjacentCircuitry():Array
		{
			var output = new Array();
			for each(var item:MovieClip in myArena.levelStuff)
			{
				if(item is Circuitry && !(item is Door))
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
		public function activate():void
		{
			if(!active)
			{
				gotoAndStop(2);
				active = true;
			}
		}
		public function deactivate():void
		{
			if(active)
			{
				powerDir = -1;
				gotoAndStop(1);
				active = false;
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
		public function isActive():Boolean
		{
			return active;
		}
		public function tangible():Boolean
		{
			return !active;
		}
	}
}