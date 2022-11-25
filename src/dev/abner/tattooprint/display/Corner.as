package dev.abner.tattooprint.display 
{
	import dev.abner.tattooprint.utils.MouseController;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.MouseCursor;
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class Corner extends Sprite
	{
		private var _type:String;
		
		public function Corner(type:String, size:Number) {
			
			_type = type;

			this.graphics.beginFill(0xFF0000, 0);
			this.graphics.drawRect(0, 0, size, size);
			this.graphics.endFill();
			
			this.addEventListener(MouseEvent.MOUSE_OVER,	overCorner);
			this.addEventListener(MouseEvent.MOUSE_OUT,		outCorner);
			
		}
		
		private function overCorner(e:MouseEvent):void {
			MouseController.setCursor(_type);
		}
		
		private function outCorner(e:MouseEvent):void {
			MouseController.setCursor(MouseCursor.AUTO);
		}
		
		public function get type():String {
			return _type;
		}
		
	}

}