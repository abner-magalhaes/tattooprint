package dev.abner.tattooprint.ui 
{
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import dev.abner.tattooprint.display.Corners;
	import dev.abner.tattooprint.events.CornersEvent;
	import dev.abner.tattooprint.utils.Image;
	import dev.abner.tattooprint.utils.MouseController;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.ui.MouseCursor;
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class Sheet extends Sprite
	{
		
		private var _vertical:Boolean = true;
		private var _background:Sprite = new Sprite();
		
		public function Sheet() {
			
			this.addChild(_background);
			update();
			
		}
		
		public function get vertical():Boolean {
			return _vertical;
		}
		
		public function set vertical(b:Boolean):void {
			_vertical = b;
			TweenMax.to(this, 0.2, { alpha: 0, onComplete: showSheet });
		}
		
		private function showSheet():void {
			
			update();
			
			dispatchEvent(new Event(Event.CHANGE));
			
			TweenMax.to(this, 0.2, { alpha: 1, delay: 0.3 });
			
		}
		
		public function update():void {
			
			_background.graphics.clear();
			_background.graphics.beginFill(0xFFFFFF, 1);
			
			if (_vertical) {
				_background.graphics.drawRect(0, 0, 2480, 3508);
			}
			else {
				_background.graphics.drawRect(0, 0, 3508, 2480);
			}
			
			_background.graphics.endFill();
			
		}
		
	}

}