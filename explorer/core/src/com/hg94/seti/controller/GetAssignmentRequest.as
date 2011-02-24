package com.hg94.seti.controller {

	import com.hg94.seti.model.Assignment;
	import com.hg94.seti.model.Observation;
	import com.hg94.seti.model.ObservationRange;
	import com.hg94.seti.model.Target;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class GetAssignmentRequest extends EventDispatcher {
		
		private var httpService:HTTPService;
		
		public var assignment:Assignment;
		
		protected var _apiUrlRoot:String;
		
		public function GetAssignmentRequest(apiUrlRoot:String) {
			this._apiUrlRoot = apiUrlRoot;
		}
		
		public function getAssignment():void {
			this.httpService = new HTTPService();
			this.httpService.url = this._apiUrlRoot + "/assignments/current_assignment_for_user.xml";
			this.httpService.resultFormat = HTTPService.RESULT_FORMAT_E4X;
			this.httpService.method = "GET" // Shouldn't I reference a static constant here?
			this.httpService.addEventListener(ResultEvent.RESULT, this.onHTTPServiceResult);
			this.httpService.addEventListener(FaultEvent.FAULT, this.onHTTPServiceFault);
			this.httpService.send();
		}
		
		private function onHTTPServiceFault(event:FaultEvent):void {
			this.httpService.removeEventListener(ResultEvent.RESULT, this.onHTTPServiceResult);
			this.httpService.removeEventListener(FaultEvent.FAULT, this.onHTTPServiceFault);
			trace("FAULT");
		}
		private function onHTTPServiceResult(event:ResultEvent):void {
			this.httpService.removeEventListener(ResultEvent.RESULT, this.onHTTPServiceResult);
			this.httpService.removeEventListener(FaultEvent.FAULT, this.onHTTPServiceFault);
			var assignmentXML:XML = event.result as XML;
			var observationRangeXML:XML = assignmentXML["observation-range"][0];
			var observationXML:XML = observationRangeXML["observation"][0];
			var targetXML:XML = observationXML["target"][0];
			var target:Target = new Target();
			target.name = targetXML["name"];
			target.description = targetXML["description"];
			target.rightAscension = targetXML["right-ascension"];
			target.declination = targetXML["declination"];
			trace("Assigned to target:" + target.name);
			var observationDateString:String = observationXML["date"];
			var observationDateArray:Array = observationDateString.split("-");
			var observationDate:Date = new Date(observationDateArray[0], int(observationDateArray[1]) - 1, observationDateArray[2]);
			var observation:Observation = new Observation(observationDate, target);
			var observationRange:ObservationRange = new ObservationRange(observation);
			observationRange.loMHz = observationRangeXML["lo-mhz"];
			observationRange.hiMHz = observationRangeXML["hi-mhz"];
			observationRange.filenameCollection = new ArrayCollection();
			var baseURL:String = observationXML["base-url"];
			for each (var urlPart:String in observationRangeXML["url-part-list"][0].split("\r\n")) {
				observationRange.filenameCollection.addItem(baseURL + "/" + urlPart);
			}
			this.assignment = new Assignment(observationRange);
			this.dispatchEvent(event.clone());
		}
	}
}