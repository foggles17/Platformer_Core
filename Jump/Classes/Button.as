package
{
	import flash.display.*;
	import flash.events.*;
	public class Button extends MovieClip implements Circuitry
	{
		public var active = false;
		public var myArena:Arena;
		public var col;
		public var row;
		public function Button(Column:Number, Row:Number, lvl:Arena)
		{
			x = Column*30;
			y = Row*30;
			col = Column;
			row = Row;
			myArena = lvl;
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
				if(item is Circuitry && !(item is Button))
				{
					if(item.getColumn() == col)
					{
						if(item.getRow() == row+1 || item.getRow() == row-1)
						{
							output.push(item);
						}
					}
					else if(item.getRow() == row)
					{
						if(item.getColumn() == col+1 || item.getColumn() == col-1)
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
				gotoAndStop(2)
				active = true;
				for each(var item:MovieClip in getAdjacentCircuitry())
				{
					if(item is Wire || item is Door)
					{
						if(item.col - col > 0)
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
				gotoAndStop(1)
				active = false;
				for each(var box:MovieClip in getAdjacentCircuitry())
				{
					if(box is Circuitry && !(box is Button))
					{
						if(box.col > col && box.powerDir == 0)
						{
							box.deactivate();
						}
						else if(box.col < col && box.powerDir == 2)
						{
							box.deactivate();
						}
						else if(box.row > row && box.powerDir == 1)
						{
							box.deactivate();
						}
						else if(box.row < row && box.powerDir == 3)
						{
							box.deactivate();
						}
					}
				}
			}
		}
	}
}