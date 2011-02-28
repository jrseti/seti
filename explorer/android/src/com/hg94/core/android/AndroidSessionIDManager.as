package com.hg94.core.android {
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.rpc.http.HTTPService;
	
	public class AndroidSessionIDManager {
		public function AndroidSessionIDManager() {
			var directory:File = File.applicationStorageDirectory;
			var file:File = directory.resolvePath("session.txt");
			if (file.exists) {
				trace("Reading session id from file");
				var fileStream:FileStream = new FileStream();
				fileStream.open(file, FileMode.READ);
				this.sessionID = fileStream.readUTF();
				fileStream.close(); 
			} else {
				this.sessionID = "";
			}
			trace("Session ID is " + this.sessionID);
		}
		
		private static var queryParameterName:String = "_session_id";
		
		private static var _instance:AndroidSessionIDManager;
		
		public var sessionID:String;
		
		public static function get instance():AndroidSessionIDManager {
			if (!AndroidSessionIDManager._instance) {
				AndroidSessionIDManager._instance = new AndroidSessionIDManager();
			}
			return AndroidSessionIDManager._instance;
		}
		
		/** We're cheating and assuming that session id is the ONLY query parameter!
		 * TODO: Use a RegExp for this!!
		 */
		
		public function parseSessionIDFromURLString(urlString:String):void {
			var offset:int = urlString.indexOf(AndroidSessionIDManager.queryParameterName);
			
			// Add one for the equals
			var session_id:String = urlString.substr(offset + AndroidSessionIDManager.queryParameterName.length+1);
			trace("Session ID is " + session_id);
			this.sessionID = session_id;
			this.saveSessionID();
		}
		
		public function addCookieToHTTPService(httpService:HTTPService):void {
			var headers:Object = httpService.headers;
			headers["Cookie"] = AndroidSessionIDManager.queryParameterName + "=" + this.sessionID;
		}
		
		private function saveSessionID():void {
			var directory:File = File.applicationStorageDirectory;
			var file:File = directory.resolvePath("session.txt");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTF(this.sessionID);
			fileStream.close(); 
		}
	}
}