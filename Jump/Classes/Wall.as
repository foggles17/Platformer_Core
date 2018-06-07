package
{
	import flash.display.*;
	import flash.events.*;
	public class Wall extends MovieClip implements Platform
	{
		public function Wall(ex:Number, wy:Number, w:Number, h:Number)
		{
			height = h;
			width = w;
			x = ex;
			y = wy;
		}
		public function tangible():Boolean
		{
			return true;
		}
	}
}