package dev.abner.tattooprint.utils 
{
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class ColorState
	{
		
		public static const MENU_BUTTONS:ColorState = new ColorState(new Color(0x999999, 0.5), new Color(0xFFFFFF, 0.5), new Color(0x555555, 0.5));
		
		public var active:Color;
		public var over:Color;
		public var release:Color;
		
		public function ColorState(active:Color, over:Color, release:Color) {
			this.active		= active;
			this.over		= over;
			this.release	= release;
		}
		
	}

}