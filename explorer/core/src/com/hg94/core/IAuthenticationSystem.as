package com.hg94.core
{
	import flash.events.IEventDispatcher;
	
	import mx.rpc.http.HTTPService;

	public interface IAuthenticationSystem extends IEventDispatcher
	{
		function authenticate(urlRoot:String):void;
		
		function prepareHTTPService(httpService:HTTPService):void;
		
		function logout():void;
	}
}