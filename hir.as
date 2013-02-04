package  {
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import gs.TweenLite;
	import gs.TweenLite;
	
	public class hir extends MovieClip {
		
		
		public function hir(xx:Number, yy:Number, rad:Number, pos:Number) {
			// constructor code
			var col:uint = new uint();
			col = stat.bitmapData.getPixel(xx, yy);
			/*if(col == 0x000000)
			{
				if(stat.hh != 0)
				{
					if(xx <= (stat.hh/2))
					{
						col = 0xFFFFFF;
					}
 				}
				if(stat.ww != 0)
				{
					if(yy <= (stat.ww/2))
					{
						col = 0xFFFFFF;
					}
 				}
			}*/
			this.graphics.beginFill(col);
			this.graphics.drawCircle(xx, yy, rad);
			this.graphics.endFill();
			
			if(pos == 1)
			{
				this.x += rad;
				this.y += rad;
			}
			else if(pos == 2)
			{
				this.x -= rad;
				this.y += rad;
			}
			else if(pos == 3)
			{
				this.x += rad;
				this.y -= rad;
			}
			else if(pos == 4)
			{
				this.x -= rad;
				this.y -= rad;
			}

			
			this.alpha = 0;
			
			stat.stageMain.addChild(this);
			if(pos == 1)
			{
				TweenLite.to(this, 0.5, {alpha:1, x:(x - rad), y:(y - rad)}); 
			}
			else if(pos == 2)
			{
				TweenLite.to(this, 0.5, {alpha:1, x:(x + rad), y:(y - rad)}); 
			}
			else if(pos == 3)
			{
				TweenLite.to(this, 0.5, {alpha:1, x:(x - rad), y:(y + rad)}); 
			}
			else if(pos == 4)
			{
				TweenLite.to(this, 0.5, {alpha:1, x:(x + rad), y:(y + rad)}); 
			}
			else
			{
				TweenLite.to(this, 0.5, {alpha:1});
			}
			
		}
	}
	
}
