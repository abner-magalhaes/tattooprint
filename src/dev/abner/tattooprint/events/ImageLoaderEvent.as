package dev.abner.tattooprint.events 
{
	import dev.abner.tattooprint.utils.Image;
	import flash.display.Bitmap;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class ImageLoaderEvent extends Event 
	{
		
		public static const ADD_IMAGE:String = "addImage";
		
		private var _image:Image = null;
		
		public function ImageLoaderEvent(type:String, image:Bitmap = null) {
			_image = new Image(image);
			super(type, bubbles, cancelable);
		}
		
		public function get image():Image {
			return _image;
		}
		
		public override function toString():String { 
			return formatToString("ImageLoaderEvent", "type", "image"); 
		}
		
	}
	
}