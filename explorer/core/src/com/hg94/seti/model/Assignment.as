package com.hg94.seti.model {
    import flash.utils.describeType;

    [Bindable] public class Assignment {
        public var user:User;

        public var dateAssigned:String;

        public var dateUpdated:String;

        public var dateComplete:String;
		
		public var observationRange:ObservationRange;

        protected var _status:String = AssignmentStatus.NASCENT;

		public function Assignment(observationRange:ObservationRange) {
			this.observationRange = observationRange;
		}
		

        public function set status(value:String):void {
            if(AssignmentStatus.isValid(value)) {
                _status = value;
            } else {
                throw new Error("Invalid status set on Assignment");
            }
        }

        public function get status():String {
            return _status;
        }
    }
}