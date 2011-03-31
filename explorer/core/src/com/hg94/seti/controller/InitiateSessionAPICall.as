// Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
// NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the Mozilla Public License (MPL) v1.1.

package com.hg94.seti.controller
{
	import com.hg94.core.IAuthenticationSystem;
	
	public class InitiateSessionAPICall extends APICall
	{
		public function InitiateSessionAPICall(urlRoot:String, authenticationSystem:IAuthenticationSystem, model:Object)
		{
			//TODO: implement function
			super(urlRoot, authenticationSystem, model);
		}

		protected function get _urlPath():String {
			return "";
		}
		

	}
}