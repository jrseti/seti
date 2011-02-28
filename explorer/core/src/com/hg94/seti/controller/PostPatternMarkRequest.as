package com.hg94.seti.controller
{
	import com.hg94.core.android.AndroidSessionIDManager;
	import com.hg94.seti.model.Assignment;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class PostPatternMarkRequest extends EventDispatcher
	{
		
		protected var _apiUrlRoot:String;
		
		protected var _httpService:HTTPService;

		public function PostPatternMarkRequest(apiUrlRoot:String) {
			this._apiUrlRoot = apiUrlRoot;
		}
		
		public function postPatternMark(assignment:Assignment, mhz:Number):void {
			this._httpService = new HTTPService();
			this._httpService.url = this._apiUrlRoot + "/pattern_marks.xml";
			this._httpService.resultFormat = HTTPService.RESULT_FORMAT_E4X;
			this._httpService.method = "POST" // Shouldn't I reference a static constant here?
			this._httpService.addEventListener(ResultEvent.RESULT, this.onHTTPServiceResult);
			this._httpService.addEventListener(FaultEvent.FAULT, this.onHTTPServiceFault);
			AndroidSessionIDManager.instance.addCookieToHTTPService(this._httpService);
			var params:Object = new Object();
			params["pattern_mark[category]"] = "CATEGORY";
			if (!isNaN(mhz)) {
				params["pattern_mark[mhz]"] = mhz.toString();
			}
			params["pattern_mark[assignment_id]"] = assignment.id.toString();
			this._httpService.send(params);
		}
		
		private function onHTTPServiceFault(event:FaultEvent):void {
			this._httpService.removeEventListener(ResultEvent.RESULT, this.onHTTPServiceResult);
			this._httpService.removeEventListener(FaultEvent.FAULT, this.onHTTPServiceFault);
			trace("FAULT");
		}
		private function onHTTPServiceResult(event:ResultEvent):void {
			this._httpService.removeEventListener(ResultEvent.RESULT, this.onHTTPServiceResult);
			this._httpService.removeEventListener(FaultEvent.FAULT, this.onHTTPServiceFault);
			trace("SUCCESS");
		}
	}
}