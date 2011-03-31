// Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
// NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the Mozilla Public License (MPL) v1.1.

package com.hg94.seti.controller {
	
	import com.hg94.core.IAuthenticationSystem;
	import com.hg94.seti.events.GetUserAPICallCompleteEvent;
	import com.hg94.seti.model.Assignment;
	import com.hg94.seti.model.Model;
	import com.hg94.seti.model.Observation;
	import com.hg94.seti.model.ObservationRange;
	import com.hg94.seti.model.Target;
	import com.hg94.seti.model.User;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	
	/** Doesn't actually return the user object, but it could.
	 * 	For now just confirming that we have a complete connection to the API and a valid session
	 */
	
	[Event(name="getUserAPICallComplete", type="com.hg94.seti.events.GetUserAPICallCompleteEvent")]
	public class GetUserAPICall extends APICall {

		public function GetUserAPICall(urlRoot:String, authenticationSystem:IAuthenticationSystem, model:Object) {
			super(urlRoot, authenticationSystem, model);
		}
		
		override protected function get _urlPath():String {
			return "/users/show_self.xml";
		}
		
		override protected function handleResult(resultXML:XML):void {
			var event:GetUserAPICallCompleteEvent = new GetUserAPICallCompleteEvent();
			event.isLoggedIn = (resultXML.localName() == "user");
			if (event.isLoggedIn) {
				var user:User = new User();
				user.name = resultXML.name;
				user.role = resultXML.role;
				this._model["user"] = user;
			} else {
				this._model["user"] = null;
				this._authenticationSystem.logout();
			}
			this.dispatchEvent(event);
		}
	}
}