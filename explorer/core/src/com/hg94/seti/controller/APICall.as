package com.hg94.seti.controller {
	
	import com.hg94.core.IAuthenticationSystem;
	
	import flash.events.EventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	
	
	
	/** Base class for all API calls
	 */
	
	
	public class APICall extends EventDispatcher {
		
		protected var _httpService:HTTPService;
		
		protected var _urlRoot:String;
		
		protected var _authenticationSystem:IAuthenticationSystem;
		
		protected var _model:Object;
		
		protected var _method:String = "GET";  // Shouldn't I reference a static constant here?
		
		public function APICall(urlRoot:String, authenticationSystem:IAuthenticationSystem, model:Object) {
			this._urlRoot = urlRoot;
			this._authenticationSystem = authenticationSystem;
			this._model = model;
			super();
		}
		
		public function execute():void {
			this._httpService = new HTTPService();
			this._httpService.url = this._urlRoot + this._urlPath;
			this._httpService.resultFormat = HTTPService.RESULT_FORMAT_E4X;
			this._httpService.method = this._method
			this._httpService.addEventListener(ResultEvent.RESULT, this.httpServiceResultHandler);
			this._httpService.addEventListener(FaultEvent.FAULT, this.httpServiceFaultHandler);
			this._authenticationSystem.prepareHTTPService(this._httpService);
			trace("Calling " + this._httpService.url);
			this._httpService.send(this._params);
		}
		
		protected function get _urlPath():String {
			return "";
		}
		
		protected function get _params():Object {
			return null;
		}
		
		private function httpServiceFaultHandler(event:FaultEvent):void {
			event.target.removeEventListener(ResultEvent.RESULT, this.httpServiceResultHandler);
			event.target.removeEventListener(FaultEvent.FAULT, this.httpServiceFaultHandler);
			this._model.errorMessage = event.message;
			this.dispatchEvent(event.clone());
		}
		
		private function httpServiceResultHandler(event:ResultEvent):void {
			event.target.removeEventListener(ResultEvent.RESULT, this.httpServiceResultHandler);
			event.target.removeEventListener(FaultEvent.FAULT, this.httpServiceFaultHandler);
			this.handleResult(event.result as XML);
		}
		
		protected function handleResult(resultXML:XML):void {}
	}
}