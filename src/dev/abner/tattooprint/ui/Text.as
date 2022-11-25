package dev.abner.tattooprint.ui 
{
	import dev.abner.tattooprint.utils.Color;
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class Text extends Sprite
	{
		
		/*[Embed(source="AndBasR.ttf", fontName = "myFont", mimeType = "application/x-font", advancedAntiAliasing="true", embedAsCFF="false")]
		private var myEmbeddedFont:Class;*/
		
		private var _field:TextField = new TextField();
		
		private var _text:String;
		private var _size:int;
		private var _color:Color;
		
		public var fitToText:Boolean = false;
		
		public function Text(text:String = "", size:Number = 12, color:Color = null) {
			
			_text = text;
			_size = size;
			_color = color;
			
			this.addChild(_field);
			
			_field.selectable 		= false;
			_field.antiAliasType 	= AntiAliasType.ADVANCED;
			_field.sharpness		= 400;
			_field.embedFonts		= false;
			
			update();
			
		}
		
		public function set center(b:Boolean):void {
			var df:TextFormat = defaultFormat;
			df.align = b ? TextFormatAlign.CENTER : TextFormatAlign.LEFT;
			_field.setTextFormat(df);
			_field.defaultTextFormat = df;
		}
		
		public function put(text:String):void {
			_text = text;
			update();
		}
		
		private function update():void {
			
			_field.text	= _text;
			_field.textColor = _color.hex;
			_field.alpha = _color.alpha;
			
			var tf:TextFormat = defaultFormat;
			
			_field.defaultTextFormat = tf;
			_field.setTextFormat(tf);
			
			if (fitToText) _field.width = _field.textWidth + 5;
			
		}
		
		private function get defaultFormat():TextFormat {
			var textFormat:TextFormat = new TextFormat("Lucida Console", _size, _color.hex);
			return textFormat;			
		}
		
		override public function get width():Number {
			return _field.width;
		}
		
		override public function set width(value:Number):void {
			_field.width = value;
		}
		
		override public function get height():Number {
			return _field.height;
		}
		
		override public function set height(value:Number):void {
			_field.height = value;
		}
		
	}

}