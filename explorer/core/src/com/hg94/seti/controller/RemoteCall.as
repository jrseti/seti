package com.hg94.seti.controller
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class RemoteCall extends EventDispatcher implements IRemoteCall
	{
		public function RemoteCall()
		{
			_dataLoader = new URLLoader();
			
			addEventListeners();
		}
		
		protected function addEventListeners():void
		{
			_dataLoader.addEventListener(Event.COMPLETE, result);
		}
		
		// private members
		
		private var _dataLoader:URLLoader;
		
		private var _requestUrl:String;
		
		internal function set requestUrl(value:String):void
		{
			_requestUrl = value;
		}
		
		// public functions
		
		public function execute():void
		{
			_dataLoader.load(new URLRequest( _requestUrl ));
		}
		
		public function result(event:Event):void 
		{
			
		}
	}
}