package dev.abner.tattooprint.display 
{
	import dev.abner.tattooprint.events.CornersEvent;
	import dev.abner.tattooprint.utils.MouseController;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.MouseCursor;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class Corners extends Sprite {
		
		private var _tl:Corner;
		private var _tr:Corner;
		private var _bl:Corner;
		private var _br:Corner;
		
		private var _intialRect:Rectangle;
		private var _finalRect:Rectangle;
		private var _size:Number = 10;
		private var _allowSelfResize:Boolean = false;
		private var _selfResizeBounds:Rectangle = null;
		
		public function Corners(size:Number = 10) {
			
			_size = size;
			
			this.mouseEnabled = false;
			
			_tl = createCorner(CornerType.TOP_LEFT);
			_tr = createCorner(CornerType.TOP_RIGHT);
			_bl = createCorner(CornerType.BOTTOM_LEFT);
			_br = createCorner(CornerType.BOTTOM_RIGHT);
			
		}
		
		public function set enabled(b:Boolean):void {
			
			_tl.visible = b;
			_tr.visible = b;
			_bl.visible = b;
			_br.visible = b;
			
		}
		
		public function set allowSelfResize(b:Boolean):void {
			_allowSelfResize = b;
		}
		
		public function set selfResizeBounds(r:Rectangle):void {
			
			_selfResizeBounds = r;
			/*if (r) {
				
				_selfResizeBounds = 
				
			}*/
			
		}
		
		private function createCorner(type:String):Corner {
			
			var c:Corner = new Corner(type, _size);
			
			c.addEventListener(MouseEvent.MOUSE_DOWN,		downCorner);
			c.addEventListener(MouseEvent.MOUSE_UP,			upCorner);
			c.addEventListener(MouseEvent.RELEASE_OUTSIDE,	upCorner);
			
			this.addChild(c);
			
			return c;
			
		}
		
		public function fitTo(rect:Rectangle):void {
			
			this.x = rect.x;
			this.y = rect.y;
			
			_tl.x = 0;
			_tl.y = 0;
			
			_tr.x = rect.width - _tr.width;
			_tr.y = 0;
			
			_bl.x = 0;
			_bl.y = rect.height - _tr.height;
			
			_br.x = rect.width - _br.width;
			_br.y = rect.height - _br.height;
			
		}
		
		private function downCorner(e:MouseEvent):void {
			
			dispatchEvent(new CornersEvent(CornersEvent.START_RESIZE, e.currentTarget.type));
			
			if (_allowSelfResize) {
				
				_intialRect = new Rectangle(this.x, this.y, _br.x + _br.width, _bl.y + _bl.height);
				
				e.currentTarget.startDrag();
				e.currentTarget.addEventListener(Event.ENTER_FRAME, moveCorner);
			}
			
		}
		
		private function upCorner(e:MouseEvent):void {
			
			dispatchEvent(new CornersEvent(CornersEvent.STOP_RESIZE, e.currentTarget.type));
			
			if (e.currentTarget.hasEventListener(Event.ENTER_FRAME)) {
				
				_intialRect = null;
				fitTo(_finalRect);
				_finalRect = null;
				
				e.currentTarget.stopDrag();
				e.currentTarget.removeEventListener(Event.ENTER_FRAME, moveCorner);
			}
			
		}
		
		private function moveCorner(e:Event):void {
			
			_finalRect = new Rectangle();
			
			switch(e.currentTarget.type) {
				
				case CornerType.TOP_LEFT:
					
					_finalRect.x = _intialRect.x + _tl.x;
					_finalRect.y = _intialRect.y + _tl.y;
					_finalRect.width = _intialRect.width + ( - _tl.x);
					_finalRect.height = _intialRect.height + ( - _tl.y);
					
					break;
					
				case CornerType.TOP_RIGHT:
					
					_finalRect.x = _intialRect.x;
					_finalRect.y = _intialRect.y + _tr.y;
					_finalRect.width = _tr.x + _tr.width;
					_finalRect.height = _intialRect.height + ( - _tr.y);
					
					break;
					
				case CornerType.BOTTOM_LEFT:
					
					_finalRect.x = _intialRect.x + _bl.x;
					_finalRect.y = _intialRect.y;
					_finalRect.width = _intialRect.width + ( - _bl.x);
					_finalRect.height = _bl.y + _bl.height;
					
					break;
					
				case CornerType.BOTTOM_RIGHT:
					
					_finalRect.x = _intialRect.x;
					_finalRect.y = _intialRect.y;
					_finalRect.width = _br.x + _br.width;
					_finalRect.height = _br.y + _br.height;
					
					break;
					
				default:
					throw new Error("corner not recognized");
					break;
					
			}
			
			dispatchEvent(new CornersEvent(CornersEvent.RESIZING, e.currentTarget.type, _finalRect));
			
		}
		
	}

}