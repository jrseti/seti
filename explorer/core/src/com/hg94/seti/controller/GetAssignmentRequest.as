package com.hg94.seti.controller {

	import com.hg94.seti.model.Assignment;
	import com.hg94.seti.model.Observation;
	import com.hg94.seti.model.ObservationRange;
	import com.hg94.seti.model.Target;
	
	import flash.events.EventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class GetAssignmentRequest extends EventDispatcher {
		
		private var httpService:HTTPService;
		
		public var assignment:Assignment;
		
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
			var target:Target = new Target(targetXML.name);
			target.rightAscension = targetXML["right-ascension"];
			target.declination = targetXML["declination"];
			trace("Assigned to target:" + target.friendlyName);
			var observation:Observation = new Observation(new Date(), target);
			var observationRange:ObservationRange = new ObservationRange(observation);
			this.assignment = new Assignment(observationRange);
			this.dispatchEvent(event.clone());
		}
		
		public function getAssignment():void {
			this.httpService = new HTTPService();
			this.httpService.url = "/assignments/current_assignment_for_user.xml";
			this.httpService.resultFormat = HTTPService.RESULT_FORMAT_E4X;
			this.httpService.method = "GET" // Shouldn't I reference a static constant here?
			this.httpService.addEventListener(ResultEvent.RESULT, this.onHTTPServiceResult);
			this.httpService.addEventListener(FaultEvent.FAULT, this.onHTTPServiceFault);
			this.httpService.send();
		}
	}
}