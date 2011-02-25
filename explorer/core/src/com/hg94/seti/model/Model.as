package com.hg94.seti.model
{
	import flash.events.EventDispatcher;

	[Bindable] public class Model extends EventDispatcher {
		
		public var currentAssignment:Assignment;
				
		private var _currentMHzMidpoint:Number;
		
		public function set currentMHzMidpoint(currentMHzMidpoint:Number):void {
			this._currentMHzMidpoint = currentMHzMidpoint;
		}
		
		public function get currentMHzMidpoint():Number {
			return this._currentMHzMidpoint;
		}
		
		public function Model()
		{
		}
	}
}