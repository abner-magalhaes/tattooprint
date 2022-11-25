package dev.abner.tattooprint.utils 
{
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class Color 
	{
		
		private var _hex:uint;
		private var _alpha:Number;
		
		public function Color(hex:uint = 0x00000, alpha:Number = 1) {
			_hex = hex;
			_alpha = alpha;
		}
		
		public function get hex():uint {
			return _hex;
		}
		
		public function get alpha():Number {
			return _alpha;
		}
		
	}

}