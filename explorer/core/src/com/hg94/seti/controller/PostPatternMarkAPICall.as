package com.hg94.seti.controller {
	import com.hg94.core.IAuthenticationSystem;
	import com.hg94.seti.model.Assignment;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class PostPatternMarkAPICall extends APICall {
		
		public var assignment:Assignment;
		
		public var mhz:Number;
		
		public var category:String;

		public function PostPatternMarkAPICall(urlRoot:String, authenticationSystem:IAuthenticationSystem, model:Object) {
			super(urlRoot, authenticationSystem, model);
			this._method = "GET"
		}
		
		override protected function get _urlPath():String {
			return "/pattern_marks/mark_pattern.xml";
		}
		
		override protected function get _params():Object {
			var params:Object = new Object();
			params["pattern_mark[category]"] = this.category;
			if (!isNaN(this.mhz)) {
				params["pattern_mark[mhz]"] = this.mhz.toString();
			}
			params["pattern_mark[assignment_id]"] = this.assignment.id.toString();
			return params;
		}

		override protected function handleResult(resultXML:XML):void {
			
		}
	}
}