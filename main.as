package 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import gs.TweenLite;
	import flash.text.TextField;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	import flash.geom.Point;
	import flash.display.Graphics;

	public class main extends MovieClip
	{
		public function main()
		{
			// constructor code
			stat.stageMain = new MovieClip();
			
			var stageB:MovieClip = new MovieClip();
			stageB.visible = false;
			stat.stageMain.addChild(stageB);
			
			//Test BackGround Code
			
			this.addChild(stat.stageMain);
			//test(450, 450, 200);
			
			this.setChildIndex(stat.stageMain, 1);

			save_btn.visible = false;
			cb_btn.visible = false;
			picker.visible = false;

			var loader:Loader = new Loader();

			hiren1.addEventListener(MouseEvent.CLICK, browse);
			
			function browse(e:Event):void
			{

				var imagesFilter:FileFilter = new FileFilter("Images","*.jpg;*.gif;*.png");
				var myFileReference:FileReference = new FileReference();
				myFileReference.browse([imagesFilter]);
				myFileReference.addEventListener(Event.SELECT, selectedImage);

				function selectedImage(e:Event):void
				{
					myFileReference.load();
					myFileReference.addEventListener(Event.COMPLETE, completeImage);

					function completeImage(e:Event):void
					{
						var tempFileRef : FileReference = FileReference ( e.target ) ;
						loader.contentLoaderInfo.addEventListener ( Event.COMPLETE, _onImageLoaded ) ;
						loader.loadBytes ( tempFileRef.data );
						
						function _onImageLoaded(e:Event):void
						{
							trace("w00t");
							
							var scaleXX:Number = new Number();//700/loader.width;
							var scaleYY:Number = new Number();//700/loader.height;
							
							if(loader.width > loader.height)
							{
								stat.ww = loader.width - loader.height;
								stat.hh = 0;
							}
							else if(loader.height - loader.width)
							{
								stat.hh = loader.height - loader.width;
								stat.ww = 0;
							}
							else
							{
								stat.hh = 0;
								stat.ww = 0;
							}
							
							scaleXX = 700/(loader.width + stat.hh);
							scaleYY = 700/(loader.height + stat.ww);
								
							//trace(scaleYY+"   700  "+loader.height);
							
							stat.bitmapData = new BitmapData(loader.width,loader.height);
							stat.bitmapData.draw(loader);
							
							//trace(stat.hh+"   "+stat.ww+"  sfsd");
							
							
							//var scaleXX:Number = (700*(loader.width/loader.height))/loader.width;
							var matrix:Matrix = new Matrix();
							matrix.scale(scaleXX, scaleYY);
							matrix.translate((stat.hh/2)*scaleYY,(stat.ww/2)*scaleXX);
							
							//trace(loader.width);
							
							//matrix.tx += stat.hh/2;
							//matrix.ty += stat.ww/2;
							
							var smallBMD:BitmapData = new BitmapData(700, 700, true, 0xFFFFFF);
							smallBMD.draw(stat.bitmapData, matrix, null, null, null, true);
							
							trace(smallBMD.width+"  "+smallBMD.height);
								
							stat.bitmapData = smallBMD;
							
							var aaaa:Bitmap = new Bitmap(stat.bitmapData);
							//addChild(aaaa);
							
							hiren1.visible = false;
							save_btn.visible = true;
							cb_btn.visible = true;
							picker.visible = true;
							stageB.visible = true;
							test(350, 350, 350, 0);
						}
					}
				}

			}

			save_btn.addEventListener(MouseEvent.CLICK, savee);
			cb_btn.addEventListener(MouseEvent.CLICK, changeBack);
			remove_btn.addEventListener(MouseEvent.CLICK, removeBack);
			
			function savee(e:MouseEvent):void
			{
				var saveBitman:BitmapData = new BitmapData(700, 700, true, 0);
				saveBitman.draw(stat.stageMain, new Matrix());
				
				var byteArray:ByteArray = PNGEnc.encode(saveBitman);
				var fileSave:FileReference = new FileReference();
				fileSave.save(byteArray, "Photo.jpg");
			}
			
			
			function changeBack(e:MouseEvent):void
			{
				stageB.visible = true;
				var newuint = uint("0x"+picker.hexValue);
				
				stageB.graphics.beginFill(newuint);
				stageB.graphics.drawRect(0, 0, 700, 700);
				stageB.graphics.endFill();
				
			}
			
			function removeBack(e:MouseEvent):void
			{
				stageB.visible = false;
			}

		}

		private function test(xx:Number,yy:Number, rad:Number, pos:Number):void
		{
			var ff:hir = new hir(xx,yy,rad,pos);

			ff.addEventListener(MouseEvent.MOUSE_OUT, doo);

			function doo(e:MouseEvent):void
			{
				rad = rad / 2;
				stat.stageMain.removeChild(ff);
				test(xx - rad, yy - rad, rad, 1);
				test(xx + rad, yy - rad, rad, 2);
				test(xx - rad, yy + rad, rad, 3);
				test(xx + rad, yy + rad, rad, 4);
				TweenLite.to(ff, 0.5, {alpha:0, onComplete:myFunction});
				function myFunction():void
				{
					ff.removeEventListener(MouseEvent.MOUSE_OUT, doo);
				}
			}
		}



	}

}