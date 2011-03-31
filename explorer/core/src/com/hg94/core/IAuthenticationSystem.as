// Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
// NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the Mozilla Public License (MPL) v1.1.

package com.hg94.core
{
	import flash.events.IEventDispatcher;
	
	import mx.rpc.http.HTTPService;

	public interface IAuthenticationSystem extends IEventDispatcher
	{
		function authenticate(urlRoot:String, provider:String):void;
		
		function prepareHTTPService(httpService:HTTPService):void;
		
		function logout():void;
	}
}