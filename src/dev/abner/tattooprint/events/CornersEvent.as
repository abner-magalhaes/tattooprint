package dev.abner.tattooprint.events 
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class CornersEvent extends Event 
	{
		
		public static const START_RESIZE:String = "startResize";
		public static const STOP_RESIZE:String = "stopResize";
		public static const RESIZING:String = "resizing";
		
		private var _cornerType:String;
		private var _rect:Rectangle;
		
		public function CornersEvent(type:String, cornerType:String, rect:Rectangle = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_cornerType = cornerType;
			_rect = rect;
		}
		
		public function get rect():Rectangle {
			return _rect;
		}
		
		public function get cornerType():String {
			return _cornerType;
		}
		
	}
	
}