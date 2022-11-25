package dev.abner.tattooprint.display 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class Container extends Sprite
	{
		
		private var _size:Point = new Point(100, 100);
		
		public function Container(...objects) {
			
			resize();
			
			if (objects) {
				for (var i:int = 0; i < objects.length; i++) {
					addChild(objects[i]);
				}
			}
			
		}
		
		override public function get width():Number 
		{
			return _size.x;
		}
		
		override public function set width(value:Number):void 
		{
			_size.x = value;
			resize();
		}
		
		override public function get height():Number 
		{
			return _size.y;
		}
		
		override public function set height(value:Number):void 
		{
			_size.y = value;
			resize();
		}
		
		public function resize():void {
			this.graphics.clear();
			this.graphics.beginFill(0, 0);
			this.graphics.drawRect(0, 0, _size.x, _size.y);
			this.graphics.endFill();
		}
		
	}

}