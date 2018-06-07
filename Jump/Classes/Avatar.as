package
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	public class Avatar extends MovieClip
	{
		var ducked:Boolean;
		var myArena;
		var isDead;
		var wide;
		var high;
		public var yspeed:Number = 0;
		public var xspeed:Number = 0;
		public function Avatar(col:Number, row:Number, lvl:Arena)
		{
			wide = 15;
			high = 30;
			x = col*30+7.5;
			y = row*30;
			ducked = false;
			isDead = false;
			gotoAndStop(1);
			myArena = lvl;
		}
		public function duck():void
		{
			if(ducked == false)
			{
				gotoAndStop(currentFrame+3);
			}
			ducked = true;
		}
		public function distanceToLeftWall():Number
		{
			var smallest:Number = 0;
			var go:Boolean = false;
			for each(var item:Object in myArena.levelStuff)
			{
				if(item is Platform)
				{
					if(item.tangible() == true)
					{
						var dist:Number = x-item.x-item.width;
						var wy:Number = y;
						if(ducked)
							wy+=15;
						if(dist >= 0 && wy+height > item.y && wy<item.height+item.y)
						{
							if(!go)
							{
								smallest = dist;
								go = true;
							}
							else if(smallest > dist)
							{
								smallest = dist;
							}
						}
					}
				}
			}
			return smallest;
		}
		public function distanceToRightWall():Number
		{
			var smallest:Number = 0;
			var go:Boolean = false;
			for each(var item:Object in myArena.levelStuff)
			{
				if(item is Platform)
				{
					if(item.tangible() == true)
					{
						var dist:Number = item.x-x-width;
						var wy:Number = y;
						if(ducked)
							wy+=15;
						if(dist >= 0 && wy+height > item.y && wy<item.height+item.y)
						{
							if(!go)
							{
								smallest = dist;
								go = true;
							}
							else if(smallest > dist)
							{
								smallest = dist;
							}
						}
					}
				}
			}
			return smallest;
		}
		public function distanceToFloor():Number
		{
			var smallest:Number = 0;
			var go:Boolean = false;
			for each(var item:Object in myArena.levelStuff)
			{
				if(item is Platform)
				{
					if(item.tangible() == true)
					{
						var dist:Number = item.y-y-height;
						if(ducked)
							dist -= 15;
						if(dist >= 0 && x+width > item.x && x<item.width+item.x)
						{
							if(!go)
							{
								smallest = dist;
								go = true;
							}
							else if(smallest > dist)
							{
								smallest = dist;
							}
						}
					}
				}
			}
			return smallest;
		}
		public function distanceToCeiling():Number
		{
			var smallest:Number = 0;
			var go:Boolean = false;
			for each(var item:Object in myArena.levelStuff)
			{
				if(item is Platform)
				{
					if(item.tangible() == true)
					{
						var dist:Number = y-item.y-item.height;
						if(ducked)
							dist += 15;
						if(dist >= 0 && x+width > item.x && x<item.width+item.x)
						{
							if(!go)
							{
								smallest = dist;
								go = true;
							}
							else if(smallest > dist)
							{
								smallest = dist;
							}
						}
					}
				}
			}
			return smallest;
		}
		public function die():void
		{
			myArena.runner.restartLevel();
		}
		public function act():void
		{
			for each(var item:Object in myArena.levelStuff)
			{
				if(item is Spike)
				{
					
				}
			}
			//keyListeners
			if(myArena.runner.keys[Keyboard.UP])
			{
				if(distanceToFloor() == 0 && yspeed == 1)
				{
					yspeed = -10;
				}
			}
			if(myArena.runner.keys[Keyboard.SHIFT])
			{
				duck();
				height = 15;
			}
			else if(ducked)
			{
				if(distanceToCeiling() >= 15)
				{
					ducked = false;
					gotoAndStop(currentFrame - 3);
				}
			}
			if(myArena.runner.keys[Keyboard.LEFT])
			{
				if(xspeed > -5 && !myArena.runner.keys[Keyboard.RIGHT])
					xspeed -= 2;
			}
			else if(myArena.runner.keys[Keyboard.RIGHT])
			{
				if(xspeed < 5)
					xspeed += 2;
				if(ducked)
					gotoAndStop(6);
				else
					gotoAndStop(3);
			}
			//falling or jumping
			if(yspeed > distanceToFloor())
			{
				y+=distanceToFloor();
				yspeed = 0;
			}
			else if(-1*yspeed > distanceToCeiling())
			{
				y-=distanceToCeiling();
				yspeed = 0;
			}
			else
				y += yspeed;
			yspeed++;
			//horizontal movement
			if(!ducked)
			{
				if(-1*xspeed > distanceToLeftWall())
				{
					x-=distanceToLeftWall();
					xspeed = 0;
				}
				else if(xspeed > distanceToRightWall())
				{
					x+=distanceToRightWall();
					xspeed = 0;
				}
				else
					x += xspeed;
			}
			else
			{
				var halfSpeed = xspeed/2;
				if(-1*halfSpeed > distanceToLeftWall())
				{
					x-=distanceToLeftWall();
					halfSpeed = 0;
					xspeed = 0;
				}
				else if(halfSpeed > distanceToRightWall())
				{
					x+=distanceToRightWall();
					halfSpeed = 0;
					xspeed = 0;
				}
				else
					x += halfSpeed;
			}
			//frame choices
			if(xspeed > 0)
			{
				xspeed--;
				if(ducked)
					gotoAndStop(6);
				else
					gotoAndStop(3);
			}
			else if(xspeed < 0)
			{
				xspeed++;
				if(ducked)
					gotoAndStop(5);
				else
					gotoAndStop(2);
			}
			else
			{
				if(ducked)
					gotoAndStop(4);
				else
					gotoAndStop(1);
			}
		}
	}
}