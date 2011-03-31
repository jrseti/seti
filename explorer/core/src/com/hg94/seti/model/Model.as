// Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
// NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the Mozilla Public License (MPL) v1.1.

package com.hg94.seti.model
{
	import flash.events.EventDispatcher;

	[Bindable] public class Model extends EventDispatcher {
		
		public var currentAssignment:Assignment;
				
		public var currentMHzMidpoint:Number;
		
		public var splashMessage:String; 
		
		public var session_id:String;
		
		public var errorMessage:String;
		
		public var user:User;
	}
}