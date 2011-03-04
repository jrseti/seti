package com.hg94.core
{
	import flash.events.Event;
	
	public class AuthenticationEvent extends Event
	{
		
		public static var AUTHENTICATION_COMPLETE:String = "authenticationComplete";
		
		public function AuthenticationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public static function getCompleteEvent():AuthenticationEvent {
			return new AuthenticationEvent(AuthenticationEvent.AUTHENTICATION_COMPLETE);
		}
	}
}