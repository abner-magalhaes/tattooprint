package dev.abner.tattooprint.utils 
{
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.NativeWindowResize;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.ui.MouseCursorData;
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class MouseController
	{
		
		[Embed(source="../../../../../assets/images/cursor/resize-left.png")]
		private static var ResizeLeftBitmap:Class;
		
		[Embed(source="../../../../../assets/images/cursor/resize-right.png")]
		private static var ResizeRightBitmap:Class;
		
		public static const RESIZE_TOP_LEFT:String = NativeWindowResize.TOP_LEFT;
		public static const RESIZE_TOP_RIGHT:String = NativeWindowResize.TOP_RIGHT;
		public static const RESIZE_BOT_LEFT:String = NativeWindowResize.BOTTOM_LEFT;
		public static const RESIZE_BOT_RIGHT:String = NativeWindowResize.BOTTOM_RIGHT;
		
		private static var _stage:Stage;
		
		public function MouseController() {
			
		}
		
		public static function register(stage:Stage):void {
			
			generateCursor(new ResizeRightBitmap(),	RESIZE_TOP_RIGHT, new Point(8, 8));
			generateCursor(new ResizeLeftBitmap(),	RESIZE_TOP_LEFT, new Point(8, 8));
			generateCursor(new ResizeRightBitmap(),	RESIZE_BOT_LEFT, new Point(8, 8));
			generateCursor(new ResizeLeftBitmap(),	RESIZE_BOT_RIGHT, new Point(8, 8));
			
			_stage = stage;
			
		}
		
		public static function setCursor(name:String):void {
			Mouse.cursor = name;
		}
		
		private static function generateCursor(cursorBitmap:Bitmap, cursorName:String, point:Point):void {
			
			var cursorVector:Vector.<BitmapData> = new Vector.<BitmapData>();
			cursorVector.push(cursorBitmap.bitmapData);
			
			var cursorData:MouseCursorData = new MouseCursorData();
			cursorData.data = cursorVector;
			cursorData.hotSpot = point;
			
			Mouse.registerCursor(cursorName, cursorData);
			
		}
		
	}

}