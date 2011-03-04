package com.hg94.seti.controller {

	import com.hg94.core.IAuthenticationSystem;
	import com.hg94.core.android.AndroidSessionIDManager;
	import com.hg94.seti.model.Assignment;
	import com.hg94.seti.model.Model;
	import com.hg94.seti.model.Observation;
	import com.hg94.seti.model.ObservationRange;
	import com.hg94.seti.model.Target;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class GetAssignmentAPICall extends APICall {
		
		public function GetAssignmentAPICall(urlRoot:String, authenticationSystem:IAuthenticationSystem, model:Object) {
			super(urlRoot, authenticationSystem, model);
		}
		
		override protected function get _urlPath():String {
			return "/assignments/current_assignment_for_user.xml";
		}
		
		override protected function handleResult(resultXML:XML):void {
			var assignmentXML:XML = resultXML;
			var observationRangeXML:XML = assignmentXML["observation-range"][0];
			var observationXML:XML = observationRangeXML["observation"][0];
			var targetXML:XML = observationXML["target"][0];
			var target:Target = new Target();
			target.id = targetXML["id"];
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
			for each (var urlPart:String in observationRangeXML["url-part-list"][0].split("\n")) {
				observationRange.filenameCollection.addItem(baseURL + "/" + urlPart);
			}
			var assignment:Assignment = new Assignment();
			assignment.id = assignmentXML["id"];
			assignment.observationRange = observationRange;
			this._model["currentAssignment"] = assignment;
		}
	}
}