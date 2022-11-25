package dev.abner.tattooprint.ui 
{
	import dev.abner.tattooprint.display.Container;
	import dev.abner.tattooprint.events.ToolsEvent;
	import dev.abner.tattooprint.utils.Color;
	import dev.abner.tattooprint.utils.ColorState;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class Tools extends Container
	{

		[Embed(source = "../../../../../assets/images/tools/add-image.png")]
		private var AddImageIcon:Class;
		
		[Embed(source = "../../../../../assets/images/tools/vert-hori.png")]
		private var OrientationVIcon:Class;
		
		[Embed(source = "../../../../../assets/images/tools/hori-vert.png")]
		private var OrientationHIcon:Class;
		
		[Embed(source = "../../../../../assets/images/tools/printing.png")]
		private var PrintIcon:Class;
		
		[Embed(source = "../../../../../assets/images/tools/settings.png")]
		private var MenuButtonConfig:Class;
		
		private var _shadow:Sprite = new Sprite();
		
		private var _addImageButton:Button		= new Button(new AddImageIcon(), ColorState.MENU_BUTTONS);
		private var _orientationVButton:Button	= new Button(new OrientationVIcon(), ColorState.MENU_BUTTONS);
		private var _orientationHButton:Button 	= new Button(new OrientationHIcon(), ColorState.MENU_BUTTONS);
		private var _printButton:Button		 	= new Button(new PrintIcon(), ColorState.MENU_BUTTONS);
		private var _configButton:Button 		= new Button(new MenuButtonConfig(), ColorState.MENU_BUTTONS);
		
		private var _textVersion:Text			= new Text("V1.0b", 10, new Color(0x999999));
		
		private var _buttonsContainer:Container = new Container(_addImageButton, _orientationVButton, _orientationHButton, _printButton, _textVersion);
		
		public function Tools() {
			
			_textVersion.center = true;
			
			_orientationHButton.visible = false;
			
			this.addChild(_shadow);
			this.addChild(_buttonsContainer);
			
			_addImageButton.addEventListener(MouseEvent.CLICK, clickAddImage);
			_orientationHButton.addEventListener(MouseEvent.CLICK, clickChangeOrientation);
			_orientationVButton.addEventListener(MouseEvent.CLICK, clickChangeOrientation);
			_printButton.addEventListener(MouseEvent.CLICK, clickPrint);
			
		}
		
		private function clickPrint(e:MouseEvent):void {
			dispatchEvent(new ToolsEvent(ToolsEvent.PRINT));
		}
		
		private function clickChangeOrientation(e:MouseEvent):void {
			dispatchEvent(new ToolsEvent(ToolsEvent.CHANGE_ORIENTATION));
		}
		
		private function clickAddImage(e:MouseEvent):void {
			dispatchEvent(new ToolsEvent(ToolsEvent.ADD_IMAGE));
		}
		
		public override function resize():void {
			
			var margin:Number = 20;
			
			_buttonsContainer.width = this.width;
			
			_addImageButton.y = 0;
			_orientationVButton.y = _addImageButton.height + margin;
			_orientationHButton.y = _orientationVButton.y;
			_printButton.y = _orientationVButton.y + _orientationVButton.height + margin;
			
			_textVersion.width = this.width - margin;
			_textVersion.height = 20;
			_textVersion.x = margin/2;
			_textVersion.y = this.height - _textVersion.height - (margin * 2);
			//_configButton.y = _textVersion.y - _configButton.height - margin;
			
			center(_addImageButton);
			center(_orientationHButton);
			center(_orientationVButton);
			center(_printButton);
			//center(_configButton);
			center(_textVersion);
			
			//_buttonsContainer.height = _buttonsContainer.childHeight;
			_buttonsContainer.height = this.height;
			_buttonsContainer.y = margin;
			
			_shadow.graphics.clear();
			_shadow.graphics.beginFill(0x000000, 0.5);
			_shadow.graphics.drawRect(0, 0, this.width, this.height);
			_shadow.graphics.endFill();
			
		}
		
		private function center(ob:Sprite):void {
			ob.x = (this.width - ob.width) / 2;
		}
		
	}

}