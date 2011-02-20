package com.hg94.seti.model {
    import flash.utils.describeType;

    public class Assignment {
        public function Assignment() {
        }

        public var user:User;

        public var frequencyRange:Array = [];

        public var dateAssigned:String;

        public var dateUpdated:String;

        public var dateComplete:String;

        protected var _status:String = AssignmentStatus.NASCENT;

        public function get startFrequency():Number {
            return frequencyRange[0];
        }

        public function set startFrequency(value:String):void {
            frequencyRange[0] = value;
        }

        public function get endFrequency():Number {
            return frequencyRange[1];
        }

        public function set endFrequency(value:String):void {
            frequencyRange[1] = value;
        }

        public function set status(value):void {
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