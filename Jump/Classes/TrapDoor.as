package
{
	public class TrapDoor extends Door
	{
		public function TrapDoor(Column:Number, Row:Number, lvl:Arena)
		{
			super(Column, Row, lvl);
		}
		public function isTangible():Boolean
		{
			return active;
		}
	}
}