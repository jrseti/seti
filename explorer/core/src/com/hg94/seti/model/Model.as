package com.hg94.seti.model
{
	import flash.events.EventDispatcher;

	[Bindable] public class Model extends EventDispatcher {
		
		public var currentAssignment:Assignment;
				
		public var currentMHzMidpoint:Number;
		
		public var splashMessage:String; 
		
		public function Model()
		{
		}
	}
}