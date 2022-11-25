package dev.abner.tattooprint.ui 
{
	import dev.abner.tattooprint.utils.Color;
	import dev.abner.tattooprint.utils.ColorState;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class Button extends Sprite
	{
		
		private var _icon:Bitmap;
		private var _colors:ColorState;
		
		public function Button(icon:Bitmap, colors:ColorState) {
			
			_icon = icon;
			_colors = colors;
			
			setColor(_colors.active);
			
			this.addChild(_icon);
			
			this.addEventListener(MouseEvent.MOUSE_OVER,		over);
			this.addEventListener(MouseEvent.MOUSE_UP,			over);
			this.addEventListener(MouseEvent.MOUSE_OUT,			out);
			this.addEventListener(MouseEvent.MOUSE_DOWN,		down);
			this.addEventListener(MouseEvent.RELEASE_OUTSIDE,	out);
			
			this.buttonMode = true;
			this.useHandCursor = true;
			
		}
		
		private function over(e:MouseEvent):void {
			setColor(_colors.over);
		}
		
		private function out(e:MouseEvent):void {
			setColor(_colors.active);
		}
		
		private function down(e:MouseEvent):void {
			setColor(_colors.release);
		}
		
		private function setColor(color:Color):void {
			
			var data:BitmapData = _icon.bitmapData;
			
			for (var i:int = 0; i < data.width; i++) {
				for (var j:int = 0; j < data.height; j++) {
					data.setPixel(i, j, color.hex);
				}
			}
			
			_icon.alpha = color.alpha;
			
		}
		
	}

}