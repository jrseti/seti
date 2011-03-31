// Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
// NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the Mozilla Public License (MPL) v1.1.

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