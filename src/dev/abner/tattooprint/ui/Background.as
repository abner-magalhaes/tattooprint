package dev.abner.tattooprint.ui
{
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NativeWindowBoundsEvent;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class Background extends Sprite 
	{
		
		[Embed(source="../../../../../assets/images/wolf.png")]
		private var WolfImage:Class;
		private var wolfImage:Bitmap = new WolfImage();
		
		public function Background() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, added);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removed);
			this.addChild(wolfImage);
			wolfImage.alpha = 0;
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
			render();
		}
		
		public function render():void {
			
			this.graphics.clear();
			this.graphics.beginGradientFill(GradientType.LINEAR, [0x480744, 0x2f3755], [1, 1], [0, 255], new Matrix(0, 1, 1, 0));
			this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			this.graphics.endFill();
			
			wolfImage.x = 0;
			wolfImage.y = stage.stageHeight - wolfImage.height;
			
		}
		
	}

}