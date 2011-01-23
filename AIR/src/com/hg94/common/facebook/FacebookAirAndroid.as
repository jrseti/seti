package com.hg94.common.facebook
{
	import com.facebook.graph.core.AbstractFacebook;
	import com.facebook.graph.data.FacebookSession;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class FacebookAirAndroid extends AbstractFacebook
	{
		private var appId : String;
		private var appUrl : String;
		private var appSecret : String;
				
		public function FacebookAirAndroid(appId : String, appUrl : String, appSecret : String)
		{
			this.appId = appId;
			this.appUrl = appUrl;
			this.appSecret = appSecret;
		}
		
		public function login(code:String):void
		{
			var url:String = "" +
				"https://graph.facebook.com/oauth/access_token?" +
				"client_id="+appId+"&" +
				"redirect_uri="+appUrl+"&" +
				"client_secret="+appSecret+"&" +
				"code="+ code+"";
			
			var req:URLRequest = new URLRequest(url);
			var loader:URLLoader = new URLLoader();
			
			loader.addEventListener(Event.COMPLETE, onUrlLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			
			loader.load(req);
		}
		
		private function onUrlLoaded(event:Event):void
		{
			var loader:URLLoader = event.currentTarget as URLLoader;
			var data:String = loader.data as String;
			var token:String = data.split("=")[1];
			token = token.split("&")[0];
			
			this.session = new FacebookSession();
			session.accessToken = token;
			session.secret = appSecret;
		}
		
		private function onIOError(event:Event):void {
			trace(event);
		}
	}
	
}