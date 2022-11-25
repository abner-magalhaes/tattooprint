package dev.abner.tattooprint.utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOrientation;
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class Printer 
	{

		private static var printer:PrintJob = new PrintJob();
		
		public function Printer() {
		}
		
		public static function print(object:DisplayObject, orientation:String):void {
			
			printer.orientation = orientation;
			
			var s:Sprite = new Sprite();
			s.addChild(object);
			s.width = printer.pageWidth;
			s.height = printer.pageHeight;
			
			try {
				printer.start();
				printer.addPage(s);
				printer.send();
			}
			catch (e:Error) {
				
			}
			
		}
		
	}

}