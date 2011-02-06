package com.hg94.seti.controller.remote
{
	import flash.events.Event;

	public interface IRemoteCall
	{
		function execute():void;
		
		function result(event:Event):void;
	}
}