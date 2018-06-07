package
{
	import flash.display.*;
	import flash.events.*;
	public class Goal extends MovieClip implements Platform
	{
		var col, row, myArena;
		public function Goal(Col:Number, Row:Number, lvl:Arena)
		{
			col = Col;
			row = Row;
			x = col*30;
			y = row*30;
			myArena = lvl;
		}
		public function tangible():Boolean
		{
			return true;
		}
	}
}