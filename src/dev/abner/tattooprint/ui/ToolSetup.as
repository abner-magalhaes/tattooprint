package dev.abner.tattooprint.ui 
{
	import dev.abner.tattooprint.utils.Color;
	import dev.abner.tattooprint.utils.Image;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ...
	 */
	public class ToolSetup extends Sprite
	{
		
		public static var tool:ToolSetup = new ToolSetup();
		
		private var _textBox:Text = new Text("", 12, new Color(0xFFFFFF));
		
		public function ToolSetup() {
			
			this.addChild(_textBox);
			_textBox.fitToText = true;
			
		}
		
		public function updatePageInfo(pageInfo:PageInfo):void {
			
			var sheetInfo:String = pageInfo.sheetSize.x.toFixed() + " x " + pageInfo.sheetSize.y.toFixed() + " cm";
			var imageInfo:String = pageInfo.imageSize ? pageInfo.imageSize.x.toFixed(1) + " x " + pageInfo.imageSize.y.toFixed(1) + " cm" : "0 cm";
			
			_textBox.put("Folha " + sheetInfo + " | Imagem " + imageInfo);
			
		}
		
	}

}