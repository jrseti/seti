package com.hg94.seti.model
{
	

	public class Range
	{
		public var observation:Observation;
		
		public var minWavelength:Number;
		public var maxWavelength:Number;
		
		public var imageUrls:Array = [];
		
		public function Range(observation:Observation)
		{
			this.observation = observation;
		}
	}
}