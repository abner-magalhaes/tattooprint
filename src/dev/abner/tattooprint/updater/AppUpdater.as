package dev.abner.tattooprint.updater {
	import air.update.ApplicationUpdater;
	import air.update.events.DownloadErrorEvent;
	import air.update.events.StatusUpdateErrorEvent;
	import air.update.events.StatusUpdateEvent;
	import air.update.events.UpdateEvent;
	import flash.desktop.Updater;
	import flash.events.ErrorEvent;
	import flash.events.ProgressEvent;
	
	/**
	 * ...
	 * @author Abner Magalhães
	 */
	public class AppUpdater {
		
		private static var _updater:ApplicationUpdater;
		private static var _info:AppUpdaterInfo;
		
		public function AppUpdater() {
			
		}
		
		public static function search():void {
			
			_updater = new ApplicationUpdater();
			_updater.updateURL = "https://abner.dev/tattoo-print/releases/update.xml";
			
			_updater.addEventListener(UpdateEvent.INITIALIZED,		updateInitialized);
			_updater.addEventListener(UpdateEvent.CHECK_FOR_UPDATE,	checkForUpdateHandler);
			_updater.addEventListener(ErrorEvent.ERROR,				errorHandler);
			_updater.initialize();
			
		}
		
		private static function updateInitialized(e:UpdateEvent):void {
			
			trace("updater initialized");
			
			_updater.checkNow();
			
		}
		
		private static function checkForUpdateHandler(e:UpdateEvent):void {
			
			trace("checking for updates");
			
			// cancel auto-update
			e.preventDefault();
			
			_updater.addEventListener(StatusUpdateEvent.UPDATE_STATUS,		updateStatusHandler);
			_updater.addEventListener(StatusUpdateErrorEvent.UPDATE_ERROR,	updateStatusErrorHandler);
			_updater.checkForUpdate();
			
		}
		
		private static function updateStatusHandler(e:StatusUpdateEvent):void {
			
			_info = new AppUpdaterInfo((e.target as ApplicationUpdater).updateDescriptor);
			
			// stop the event from triggering the update download/install by itself
			e.preventDefault();
			
			if (e.available) 
				startDownloadUpdate();
			else 
				noUpdate();
			
		}
		
		private static function startDownloadUpdate():void {
			
			if (_info.required && Updater.isSupported) {
				
				_updater.addEventListener(UpdateEvent.DOWNLOAD_START,			downloadStartHandler);
				_updater.addEventListener(ProgressEvent.PROGRESS,				progressHandler);
				_updater.addEventListener(UpdateEvent.DOWNLOAD_COMPLETE,		downloadCompleteHandler);
				_updater.addEventListener(DownloadErrorEvent.DOWNLOAD_ERROR,	downloadErrorHandler);
				_updater.downloadUpdate();
				
			}
			
		}
		
		private static function downloadStartHandler(e:UpdateEvent):void {
			trace("updater download started");
		}
		
		private static function progressHandler(e:ProgressEvent):void {
			trace("updater download progress " + e.bytesLoaded + "/" + e.bytesTotal);
		}
		
		private static function downloadCompleteHandler(e:UpdateEvent):void {
			trace("updater download complete");
		}
		
		private static function downloadErrorHandler(e:DownloadErrorEvent):void {
			log("updater download error " + e.toString());
		}
		
		private static function noUpdate():void {
			
		}
		
		private static function updateStatusErrorHandler(e:StatusUpdateErrorEvent):void {
			
		}
		
		private static function errorHandler(e:ErrorEvent):void {
			
		}
		
	}

}