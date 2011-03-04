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