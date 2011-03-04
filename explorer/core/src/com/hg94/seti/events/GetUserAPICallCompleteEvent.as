package com.hg94.seti.events {
	import flash.events.Event;
	
	public class GetUserAPICallCompleteEvent extends Event {
		
		
		public static var GET_USER_API_CALL_COMPLETE:String = "getUserAPICallComplete";
		
		public var isLoggedIn:Boolean;
		
		public function GetUserAPICallCompleteEvent(type:String = null, bubbles:Boolean=false, cancelable:Boolean=false) {
			if (type == null) {
				type = GetUserAPICallCompleteEvent.GET_USER_API_CALL_COMPLETE;
			}
			super(type, bubbles, cancelable);
		}
		
		public static function getEvent():GetUserAPICallCompleteEvent {
			return new GetUserAPICallCompleteEvent();
		}
	}
}