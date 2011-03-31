// Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
// NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the Mozilla Public License (MPL) v1.1.

package com.hg94.core.android
{
	import com.hg94.core.AuthenticationEvent;
	import com.hg94.core.IAuthenticationSystem;
	
	import flash.display.Stage;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.LocationChangeEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	
	import mx.rpc.http.HTTPService;
	
	import spark.primitives.Rect;
	
	public class AndroidAuthenticationSystem  extends EventDispatcher implements IAuthenticationSystem
	{

		protected static var sessionIDParameterName:String = "_session_id";
		
		protected static var roleParameterName:String = "role";
		
		protected static var authenticationPath:String = "/auth/";
		
		protected var rectangle:Rectangle;
		
		protected var stage:Stage;
		
		protected var stageWebView:StageWebView;
		
		protected var sessionID:String;
		
		public function AndroidAuthenticationSystem(rectangle:Rectangle, stage:Stage)
		{
			this.rectangle = rectangle;
			this.stage = stage;

			
			// Load session ID from file
			
			var directory:File = File.applicationStorageDirectory;
			var file:File = directory.resolvePath("session.txt");
			if (file.exists) {
				trace("Reading session id from file");
				var fileStream:FileStream = new FileStream();
				fileStream.open(file, FileMode.READ);
				this.sessionID = fileStream.readUTF();
				fileStream.close(); 
				trace("Session ID is " + this.sessionID);
			} else {
				this.sessionID = "";
			}
		}
		
		public function authenticate(urlRoot:String, provider:String):void {
			this.stageWebView = new StageWebView();
			this.stageWebView.stage = this.stage;
			this.stageWebView.viewPort = this.rectangle;
			this.stageWebView.addEventListener(Event.COMPLETE,completeHandler);
			this.stageWebView.addEventListener(ErrorEvent.ERROR,errorHandler);
			this.stageWebView.addEventListener(LocationChangeEvent.LOCATION_CHANGING,locationChangingHandler);
			this.stageWebView.addEventListener(LocationChangeEvent.LOCATION_CHANGE,locationChangeHandler);
			this.stageWebView.loadURL(urlRoot + AndroidAuthenticationSystem.authenticationPath + provider);
		}
		
		/**
		 * Dispatched when the page or web content has been fully loaded
		 * */
		private function completeHandler(event:Event):void {
			dispatchEvent(event.clone());
		}
		
		/**
		 * Dispatched when the location is about to change
		 * */
		private function locationChangingHandler(event:Event):void {
			dispatchEvent(event.clone());
		}
		
		/**
		 * Dispatched when the location has changed
		 * We're cheating and assuming that session id is the ONLY query parameter!
		 * TODO: Use a RegExp for this!!
		 */

		private function locationChangeHandler(event:LocationChangeEvent):void {
			if (event.location.indexOf("air_active") > 0) {
				
				
				// Get the query parameters as an object
				
				var query:String = event.location.split( "?" )[ 1 ];
				var argStrings:Array = query.split( "&" );
				var args:Object = {};
				while(argStrings.length) {
					var arg:Array = argStrings.shift().split("=");
					args[arg[0]] = arg[1];
				}

				
				// Use that to get the session ID
				
				this.sessionID = args[AndroidAuthenticationSystem.sessionIDParameterName];
				this.saveSessionID();
				this.stageWebView.dispose();
				this.dispatchEvent(AuthenticationEvent.getCompleteEvent());
			}
		}
		
		/**
		 * Dispatched when an error occurs
		 * */
		private function errorHandler(event:ErrorEvent):void {
			this.stageWebView.dispose();
			dispatchEvent(event.clone());
		}
		
		
		public function prepareHTTPService(httpService:HTTPService):void {
			var headers:Object = httpService.headers;
			headers["Cookie"] = AndroidAuthenticationSystem.sessionIDParameterName + "=" + this.sessionID;
		}
		
		protected function saveSessionID():void {
			var directory:File = File.applicationStorageDirectory;
			var file:File = directory.resolvePath("session.txt");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTF(this.sessionID);
			fileStream.close(); 
		}
		
		public function logout():void {
			this.sessionID = "";
			this.saveSessionID();
		}
	}
}