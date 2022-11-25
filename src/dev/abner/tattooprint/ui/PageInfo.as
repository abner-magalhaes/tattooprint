package dev.abner.tattooprint.ui 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class PageInfo 
	{
		
		private var _sheetSize:Point;
		private var _imageSize:Point;
		
		public function PageInfo(sheetSize:Point, imageSize:Point) {
			_sheetSize = sheetSize;
			_imageSize = imageSize;
		}
		
		public function get sheetSize():Point {
			return _sheetSize;
		}
		
		public function get imageSize():Point {
			return _imageSize;
		}
		
	}

}