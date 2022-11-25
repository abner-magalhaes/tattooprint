package dev.abner.tattooprint.utils 
{
	import dev.abner.tattooprint.display.Container;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class ImageSelection extends Sprite
	{
		
		private var _image:Image;
		
		private var _tl:Sprite;
		private var _tr:Sprite;
		private var _bl:Sprite;
		private var _br:Sprite;
		
		private var _color:uint = 0xC300FF;
		
		public function ImageSelection(image:Image) {
			
			_image = image;
			
			_tl = createCorner();
			_tr = createCorner();
			_bl = createCorner();
			_br = createCorner();
			
			this.addChild(_tl);
			this.addChild(_tr);
			this.addChild(_bl);
			this.addChild(_br);
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.visible = false;
			
			if (_image.stage)
				_image.stage.addEventListener(MouseEvent.MOUSE_MOVE, move);
			else 
				_image.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
				
			_image.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			
		}
		
		private function removedFromStage(e:Event):void {
			
			_image.stage.removeEventListener(MouseEvent.MOUSE_MOVE, move);
			this.visible = false;
			
		}
		
		private function addedToStage(e:Event):void {
			_image.stage.addEventListener(MouseEvent.MOUSE_MOVE, move);
		}
		
		private function over():void {
			_image.stage.addChild(this);
		}
		
		
		private function out():void {
			this.visible = false;
			if(_image.stage.contains(this)) _image.stage.removeChild(this);
		}
		
		private function move(e:MouseEvent):void {
			
			if (_image.hitTestPoint(e.stageX, e.stageY)) {
				over();
				show();
			}
			else {
				out();
			}
			
		}
		
		private function get imageGlobal():Rectangle {
			return _image.getRect(stage);
		}
		
		private function show():void {
			
			this.x = imageGlobal.x;
			this.y = imageGlobal.y;
			
			this.graphics.clear();
			this.graphics.lineStyle(1, _color);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(imageGlobal.width, 0);
			this.graphics.lineTo(imageGlobal.width, imageGlobal.height);
			this.graphics.lineTo(0, imageGlobal.height);
			this.graphics.lineTo(0, 0);
			
			_tl.x = 0;
			_tl.y = 0;
			
			_tr.x = imageGlobal.width - _tr.width;
			_tr.y = 0;
			
			_bl.x = 0;
			_bl.y = imageGlobal.height - _bl.height;
			
			_br.x = imageGlobal.width - _br.width;
			_br.y = imageGlobal.height - _br.height;
			
			this.visible = true;
			
		}
		
		private function createCorner():Sprite {
			
			var c:Sprite = new Sprite();
			c.graphics.beginFill(_color, 1);
			c.graphics.drawRect(0, 0, 10, 10);
			c.graphics.endFill();
			
			return c;
			
		}
		
		public static function setTo(image:Image):void {
			new ImageSelection(image);
		}
		
	}

}