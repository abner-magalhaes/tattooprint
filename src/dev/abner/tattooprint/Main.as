package dev.abner.tattooprint
{
	import dev.abner.tattooprint.display.Corners;
	import dev.abner.tattooprint.events.CornersEvent;
	import dev.abner.tattooprint.events.ImageLoaderEvent;
	import dev.abner.tattooprint.events.ToolsEvent;
	import dev.abner.tattooprint.ui.Background;
	import dev.abner.tattooprint.ui.Mask;
	import dev.abner.tattooprint.ui.Menu;
	import dev.abner.tattooprint.ui.Page;
	import dev.abner.tattooprint.ui.SheetOrientation;
	import dev.abner.tattooprint.ui.ToolSetup;
	import dev.abner.tattooprint.ui.Tools;
	import dev.abner.tattooprint.utils.Image;
	import dev.abner.tattooprint.utils.ImageLoader;
	import dev.abner.tattooprint.utils.MouseController;
	import dev.abner.tattooprint.utils.Printer;
	import flash.display.NativeWindowDisplayState;
	import flash.display.NativeWindowResize;
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowBoundsEvent;
	import flash.events.NativeWindowDisplayStateEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.printing.PrintJobOrientation;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.ui.MouseCursorData;
	
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class Main extends Sprite 
	{
		
		private var container:Sprite		= new Sprite();
		private var containerMask:Mask		= new Mask();
		private var background:Background	= new Background();
		private var page:Page				= new Page();
		private var tools:Tools				= new Tools();
		private var toolSetup:ToolSetup		= ToolSetup.tool;
		private var menu:Menu				= new Menu();
		private var corners:Corners			= new Corners();
		
		private var loader:ImageLoader		= new ImageLoader();
		
		public function Main() 
		{
			
			MouseController.register(stage);
			
			stage.nativeWindow.x = ((Screen.mainScreen.bounds.width - stage.nativeWindow.width) / 2) - 100;
			stage.nativeWindow.y = ((Screen.mainScreen.bounds.height - stage.nativeWindow.height) / 2);
			stage.nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, displayChange);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE, resize);
			
			container.addChild(background);
			container.addChild(page);
			container.addChild(toolSetup);
			container.addChild(menu);
			container.addChild(tools);
			
			this.addChild(container);
			this.addChild(containerMask);
			this.addChild(corners);
			
			corners.addEventListener(CornersEvent.START_RESIZE, startResize);
			
			containerMask.cacheAsBitmap = true;
			container.mask = containerMask;
			
			tools.addEventListener(ToolsEvent.ADD_IMAGE, addImage);
			tools.addEventListener(ToolsEvent.CHANGE_ORIENTATION, changeOrientation);
			tools.addEventListener(ToolsEvent.PRINT, printHandler);
			
			page.sheet.addEventListener(Event.CHANGE, resize);
			
			loader.addEventListener(ImageLoaderEvent.ADD_IMAGE, addImageHandler);
			
		}
		
		private function startResize(e:CornersEvent):void {
			stage.nativeWindow.startResize(e.cornerType);
		}
		
		private function displayChange(e:NativeWindowDisplayStateEvent):void {
			corners.enabled = e.afterDisplayState == NativeWindowDisplayState.NORMAL;
		}
		
		private function addImage(e:ToolsEvent):void {
			loader.browse();
		}
		
		private function addImageHandler(e:ImageLoaderEvent):void {
			page.image = e.image;
		}
		
		private function changeOrientation(e:ToolsEvent):void {
			page.sheet.vertical = !page.sheet.vertical;
		}
		
		private function printHandler(e:ToolsEvent):void {
			Printer.print(page.pageToPrint(), page.sheet.vertical ? PrintJobOrientation.PORTRAIT : PrintJobOrientation.LANDSCAPE);
		}
		
		private function resize(e:Event = null):void {
			
			menu.width = stage.stageWidth;
			menu.height = 60;
			
			tools.width = 70;
			tools.height = stage.stageHeight;
			tools.x = 0;
			tools.y = 0;
			
			page.x = tools.x + tools.width;
			page.y = menu.y + menu.height;
			page.width = stage.stageWidth - page.x;
			page.height = stage.stageHeight - page.y;
			
			//toolSetup.x = page.x + ((page.width - toolSetup.width) / 2);
			//toolSetup.y = page.y - 25 - toolSetup.height;
			
			toolSetup.x = page.x + ((page.width - toolSetup.width) / 2);
			toolSetup.y = page.y;
			
			corners.fitTo(new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
			
		}
		
	}
	
}