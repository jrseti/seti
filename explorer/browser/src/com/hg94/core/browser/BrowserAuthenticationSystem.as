// Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
// NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the Mozilla Public License (MPL) v1.1.


package com.hg94.core.browser
{
	import com.hg94.core.IAuthenticationSystem;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	import mx.rpc.http.HTTPService;
	
	public class BrowserAuthenticationSystem implements IAuthenticationSystem
	{
		public function BrowserAuthenticationSystem()
		{
			//TODO: implement function
		}
		
		
		/** Web app should make sure we are logged in; just throw an error if we aren't.
		 */
		
		public function authenticate(urlRoot:String, provider:String):void
		{
			this.dispatchEvent(new ErrorEvent(ErrorEvent.ERROR))
		}
		
		public function prepareHTTPService(httpService:HTTPService):void
		{
			//TODO: implement function
		}
		
		public function logout():void
		{
			//TODO: implement function
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			//TODO: implement function
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			//TODO: implement function
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function hasEventListener(type:String):Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function willTrigger(type:String):Boolean
		{
			//TODO: implement function
			return false;
		}
	}
}