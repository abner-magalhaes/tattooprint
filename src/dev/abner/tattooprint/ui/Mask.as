package dev.abner.tattooprint.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NativeWindowBoundsEvent;
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class Mask extends Sprite
	{
		
		public function Mask() {
			this.addEventListener(Event.ADDED_TO_STAGE, added);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removed);
		}
		
		private function added(e:Event):void {
			stage.nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZE, resize);
			stage.nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZING, resize);
		}
		
		private function removed(e:Event):void {
			stage.nativeWindow.removeEventListener(NativeWindowBoundsEvent.RESIZE, resize);
			stage.nativeWindow.removeEventListener(NativeWindowBoundsEvent.RESIZING, resize);
		}
		
		private function resize(e:NativeWindowBoundsEvent):void {
			this.graphics.clear();
			this.graphics.beginFill(0, 0);
			this.graphics.drawRoundRect(0, 0, stage.stageWidth, stage.stageHeight, 15, 15);
			this.graphics.endFill();
		}
		
	}

}