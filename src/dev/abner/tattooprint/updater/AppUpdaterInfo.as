package dev.abner.tattooprint.updater {
	
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class AppUpdaterInfo {
		
		private var _required:Boolean = false;
		
		public function AppUpdaterInfo(descriptor:XML) {
			
			var ns:Namespace = descriptor.namespace();
			_required = descriptor.ns::required == "true";
			
		}
		
		public function get required():Boolean {
			return _required;
		}
		
	}

}