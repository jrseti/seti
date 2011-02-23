package com.hg94.seti.controller
{
	import com.hg94.seti.model.Observation;
	import com.hg94.seti.model.Target;
	import com.hg94.seti.model.TargetSet;

	public class TargetListRequest extends RemoteCall implements IRemoteCall
	{
		import flash.events.Event;
		
//		private static const REQUEST_URL:String = "http://setiquest.dyndns.org/getobservations.php";
		private static const REQUEST_URL:String = "/assets/data/getobservations.txt";
		
		public function TargetListRequest() 
		{
			super();
			this.requestUrl = REQUEST_URL;
		}
		
		// private members
		
		private var _targetSet:TargetSet;
		
		// public functions
		
		public function get targetSet():TargetSet
		{
			return _targetSet;
		}
		
		override public function execute():void
		{
			super.execute();
		}
		
		override public function result(event:Event):void
		{
			_targetSet = new TargetSet();
			
			var rawDataString:String = event.target.data.toString();
			var rawResults:Array = rawDataString.split('\n');
			
			for each (var rawObservation:String in rawResults)
			{
				// observation parsing
				var dateString:String = rawObservation.split('"')[0].toString().replace(new RegExp(" ","g"),"");
				var friendlyName:String = rawObservation.split('"')[1];
				var baseUrl:String = "http://" + rawObservation.split('http://')[1].toString().split("	")[0];
				
				var radec:String = rawObservation.replace(new RegExp(" ","g"),"").split(baseUrl)[1];
				
				var ra:Number = parseFloat(radec.split(",")[0]);
				var dec:Number = Math.abs(parseFloat(radec.split(",")[1]));
				
				var target:Target = new Target();
				target.setSETICoordinates(ra, dec);
				
				var date:Date = new Date(dateString.split("-")[0], dateString.split("-")[1], dateString.split("-")[2]);
				
				
				var observation:Observation = new Observation(date, target);
				observation.baseUrl = baseUrl;
				
				target.defaultObservation = observation;
				
				observation.
				
				target.description = "[Description to be completed]";
				switch (target.name) {
					case "Gliese 581":
						target.description = "A red dwarf star with spectral type M3V, located 20.3 light years away from Earth in the constellation Libra."
						break;
					case "Tau Ceti":
						target.description = "A star in the constellation Cetus that is similar to the Sun in mass and spectral type."
						break;
				}
				
				_targetSet.addTarget( target );
			}
			
			dispatchEvent(event.clone());
		}
	}
}