package com.hg94.seti.controller
{
	import com.hg94.seti.model.Observation;
	import com.hg94.seti.model.WaterfallTile;

	public class ObservationRequest extends RemoteCall implements IRemoteCall
	{
		import flash.events.Event;
		
		private static const REQUEST_URL_SUFFIX:String = "/getimages.php";
		
		public function ObservationRequest()
		{
			super();
		}
		
		// private members
		
		private var _baseUrl:String;
		
		private var _imageUrls:Array;
		
		private var _observation:Observation;
		
		// public functions
		
		public function get imageUrls():Array
		{
			return _imageUrls;
		}
		
		public function set observation(value:Observation):void
		{
			_observation = value;
			_baseUrl = _observation.baseUrl;
		}
		public function get observation():Observation
		{
			return _observation;
		}
		
		override public function execute():void
		{
			requestUrl = _baseUrl + REQUEST_URL_SUFFIX;
			
			// we call super.execute last, because we need to set things up before we do.
			super.execute();
		}
		
		override public function result(event:Event):void
		{
			var rawData:String = _baseUrl + "/" + event.target.data.toString();
			rawData = rawData.replace(new RegExp("\n", "g"), ("\n" + _baseUrl + "/") );
			
			_imageUrls = rawData.split("\n");
			
			dispatchEvent(event.clone());
		}
	}
}