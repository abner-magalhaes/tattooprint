package dev.abner.tattooprint.utils 
{
	import dev.abner.tattooprint.events.ImageLoaderEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class ImageLoader extends EventDispatcher
	{
		
		private var _file:File = new File();
		
		public function ImageLoader() {
			_file.addEventListener(Event.SELECT, select);
		}
		
		public function browse():void {
			_file.browseForOpen("Abrir Imagem...", [new FileFilter("Imagens", "*.jpg;*.jpeg;*.png")]);
		}
		
		private function select(e:Event):void {
			
			var ba:ByteArray = new ByteArray();
			
			var fs:FileStream = new FileStream();
			fs.open(_file, FileMode.READ);
			fs.readBytes(ba);
			fs.close();
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
			loader.loadBytes(ba);
			
		}
		
		private function complete(e:Event):void {
			
			var loader:LoaderInfo = e.currentTarget as LoaderInfo;
			var bitmap:Bitmap = loader.content as Bitmap;
			
			dispatchEvent(new ImageLoaderEvent(ImageLoaderEvent.ADD_IMAGE, bitmap));
			
		}
		
		private function error(e:IOErrorEvent):void {
			trace("error");
		}
		
	}

}