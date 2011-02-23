package com.hg94.seti.model {
	import mx.collections.ArrayCollection;

    [Bindable] public class ObservationRange {
		
		public var observation:Observation;
		
		public var loMHz:Number;
		
		public var hiMHz:Number;
		
		public var filenameCollection:ArrayCollection;
		
		protected var _status:String = ObservationRangeStatus.NASCENT;

		public function ObservationRange(observation:Observation) {
			this.observation = observation;
        }

		
		
        public function set status(value:String):void {
            if(ObservationRangeStatus.isValid(value)) {
                _status = value;
            } else {
                throw new Error("Invalid status set on Range");
            }
        }

        public function get status():String {
            return _status;
        }
    }
}