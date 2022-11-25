package dev.abner.tattooprint.utils 
{
	import dev.abner.tattooprint.display.Corners;
	import dev.abner.tattooprint.events.CornersEvent;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.FileFilter;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class Image extends Sprite
	{
		private var _bitmap:Bitmap;
		
		public function Image(bitmap:Bitmap) {
			_bitmap = bitmap;
			addChild(_bitmap);
		}
		
		public function get bitmap():Bitmap {
			return _bitmap;
		}
		
		public function get size():Point {
			return new Point(_bitmap.width, _bitmap.height);
		}
		
	}

}