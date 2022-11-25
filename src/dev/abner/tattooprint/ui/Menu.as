package dev.abner.tattooprint.ui 
{
	import dev.abner.tattooprint.display.Container;
	import dev.abner.tattooprint.utils.ColorState;
	import dev.abner.tattooprint.utils.MouseController;
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class Menu extends Container
	{
		
		[Embed(source = "../../../../../assets/images/menu_close.png")]
		private var MenuButtonClose:Class;
		
		[Embed(source = "../../../../../assets/images/menu_minimize.png")]
		private var MenuButtonMinimize:Class;
		
		[Embed(source = "../../../../../assets/images/menu_scaleminus.png")]
		private var MenuButtonScaleMinus:Class;
		
		[Embed(source = "../../../../../assets/images/menu_scaleplus.png")]
		private var MenuButtonScalePlus:Class;
		
		private var _menuButtonClose:Button			= new Button(new MenuButtonClose(), ColorState.MENU_BUTTONS);
		private var _menuButtonMinimize:Button 		= new Button(new MenuButtonMinimize(), ColorState.MENU_BUTTONS);
		private var _menuButtonScaleMinus:Button	= new Button(new MenuButtonScaleMinus(), ColorState.MENU_BUTTONS);
		private var _menuButtonScalePlus:Button 	= new Button(new MenuButtonScalePlus(), ColorState.MENU_BUTTONS);
		
		public function Menu() 
		{
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			
			this.addChild(_menuButtonClose);
			this.addChild(_menuButtonMinimize);
			this.addChild(_menuButtonScaleMinus);
			this.addChild(_menuButtonScalePlus);
			
			_menuButtonClose.addEventListener(MouseEvent.CLICK, clickClose);
			_menuButtonMinimize.addEventListener(MouseEvent.CLICK, clickMinimize);
			_menuButtonScalePlus.addEventListener(MouseEvent.CLICK, clickScale);
			_menuButtonScaleMinus.addEventListener(MouseEvent.CLICK, clickScale);
			
			_menuButtonScaleMinus.visible = false;
			
		}
		
		private function clickScale(e:MouseEvent):void {
			
			if (e.currentTarget == _menuButtonScaleMinus) {
				stage.nativeWindow.restore();
				_menuButtonScaleMinus.visible = false;
			}
			else {
				stage.nativeWindow.maximize();
				_menuButtonScaleMinus.visible = true;
			}
			
			_menuButtonScalePlus.visible = !_menuButtonScaleMinus.visible;
			
		}
		
		private function clickClose(e:MouseEvent):void {
			NativeApplication.nativeApplication.exit();
		}
		
		private function clickMinimize(e:MouseEvent):void {
			stage.nativeWindow.minimize();
		}
		
		private function mouseDown(e:MouseEvent):void {
			if(Mouse.cursor != MouseController.RESIZE_TOP_RIGHT) stage.nativeWindow.startMove();
		}
		
		override public function resize():void {
			
			super.resize();
			
			var margin:Number = 25;
			
			_menuButtonClose.y = (this.height - _menuButtonClose.height) / 2;
			_menuButtonClose.x = this.width - margin - _menuButtonClose.width;
			
			_menuButtonScalePlus.x = _menuButtonClose.x - margin - _menuButtonScalePlus.width;
			_menuButtonScalePlus.y = _menuButtonClose.y;
			
			_menuButtonScaleMinus.x = _menuButtonScalePlus.x;
			_menuButtonScaleMinus.y = _menuButtonScalePlus.y;
			
			_menuButtonMinimize.x = _menuButtonScalePlus.x - margin - _menuButtonMinimize.width;
			_menuButtonMinimize.y = _menuButtonScalePlus.y;
			
		}
		
	}

}