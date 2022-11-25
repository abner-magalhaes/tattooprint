package dev.abner.tattooprint.ui 
{
	import dev.abner.tattooprint.display.Container;
	import dev.abner.tattooprint.display.Corners;
	import dev.abner.tattooprint.events.CornersEvent;
	import dev.abner.tattooprint.utils.Image;
	import dev.abner.tattooprint.utils.ImageSelection;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * @author Abner de Oliveira Magalhães
	 */
	public class Page extends Container
	{
		
		private static var _page:Page;
		
		private var _pageContainer:Sprite = new Sprite();
		
		private var _sheet:Sheet = new Sheet();
		private var _imageContainer:Container = new Container();
		private var _imageMask:Sprite = new Sprite();
		private var _image:Image;
		private var _imageCorners:Corners = new Corners(100);
		
		public function Page() {
			
			_page = this;
			
			_pageContainer.addChild(_sheet);
			_pageContainer.addChild(_imageContainer);
			_pageContainer.addChild(_imageCorners);
			_pageContainer.addChild(_imageMask);
			
			_imageMask.graphics.beginFill(0, 1);
			_imageMask.graphics.drawRect(0, 0, 100, 100);
			_imageMask.graphics.endFill();
			
			_imageContainer.mask = _imageMask;
			
			this.addChild(_pageContainer);
			
			_imageCorners.allowSelfResize = true;
			_imageCorners.addEventListener(CornersEvent.RESIZING, resizingImage);
			
			resize();
			
		}
		
		public function pageToPrint():Bitmap {
			
			_pageContainer.scaleX = 1;
			_pageContainer.scaleY = 1;
			
			var bitmapData:BitmapData = new BitmapData(_pageContainer.width, _pageContainer.height, false);
			bitmapData.drawWithQuality(_pageContainer, null, null, null, null, null, StageQuality.BEST);
			
			resize();
			
			return new Bitmap(bitmapData, "auto", true);
			
		}
		
		public function get sheet():Sheet {
			return _sheet;
		}
		
		public function get image():Image {
			return _image;
		}
		
		public function set image(image:Image):void {
			
			if (_image) {
				
				_image.removeEventListener(MouseEvent.MOUSE_DOWN, downImage);
				_image.removeEventListener(MouseEvent.MOUSE_UP, upImage);
				_image.removeEventListener(MouseEvent.RELEASE_OUTSIDE, upImage);
				
				_imageContainer.removeChild(_image);
				
				_image = null;
				
			}
			
			_image = image;
			_image.addEventListener(MouseEvent.MOUSE_DOWN, downImage);
			_image.addEventListener(MouseEvent.MOUSE_UP, upImage);
			_image.addEventListener(MouseEvent.RELEASE_OUTSIDE, upImage);
			
			ImageSelection.setTo(_image);
			
			_imageContainer.addChild(_image);
			
			resize();
			
		}
		
		private function downImage(e:MouseEvent):void {
			_image.startDrag();
		}
		
		private function upImage(e:MouseEvent):void {
			_image.stopDrag();
			_imageCorners.fitTo(new Rectangle(_image.x, _image.y, _image.width, _image.height));
		}
		
		private function resizingImage(e:CornersEvent):void {
			
			var imageRect:Rectangle = e.rect;
			
			_image.x = imageRect.x;
			_image.y = imageRect.y;
			_image.width = imageRect.width;
			_image.height = imageRect.height;
			
			ToolSetup.tool.updatePageInfo(pageInfo);
			
		}
		
		override public function resize():void {
			
			_pageContainer.scaleX = 1;
			_pageContainer.scaleY = 1;
			
			var sheetSize:Point = new Point(this.width - 40, this.height - 40);
			
			if (sheetSize.x < 0 || sheetSize.y < 0) {
				return;
			}
			
			while (_pageContainer.width > sheetSize.x || _pageContainer.height > sheetSize.y) {
				_pageContainer.scaleX -= 0.001;
				_pageContainer.scaleY -= 0.001;
			}
			
			_pageContainer.x = (this.width - _pageContainer.width) / 2;
			_pageContainer.y = (this.height - _pageContainer.height) / 2;
			
			_sheet.update();
			
			_imageContainer.x = _sheet.x;
			_imageContainer.y = _sheet.y;
			_imageContainer.width = _sheet.width;
			_imageContainer.height = _sheet.height;
			
			_imageMask.x = _sheet.x;
			_imageMask.y = _sheet.y;
			_imageMask.width = _sheet.width;
			_imageMask.height = _sheet.height;
			
			if (_image) {
				_imageCorners.fitTo(new Rectangle(_image.x, _image.y, _image.width, _image.height));
			}
			
			ToolSetup.tool.updatePageInfo(pageInfo);
			
		}
		
		public function get pageInfo():PageInfo {
			
			var sheetSize:Point = _sheet.vertical ? new Point(21, 29) : new Point(29, 21);
			var imageSize:Point = null;
			
			if (_image) {
				
				imageSize = new Point();
				imageSize.x = (_image.width/_sheet.width) * sheetSize.x;
				imageSize.y = (_image.height/_sheet.height) * sheetSize.y;
				
			}
			
			var pinfo:PageInfo = new PageInfo(sheetSize, imageSize);
			
			return pinfo;
			
		}
		
	}

}