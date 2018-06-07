package
{
	import flash.display.*;
	import flash.events.*;
	public class Spike extends MovieClip
	{
		var col:int;
		var row:int;
		public function Spike(Col:Number, Row:Number, dir:Number)
		{
			x = Col*30;
			y = Row*30;
			col = Col;
			row = Row;
			gotoAndStop(dir+1);
		}
	}
}