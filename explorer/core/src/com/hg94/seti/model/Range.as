package com.hg94.seti.model {

    public class Range {
        public function Range() {
        }

        public var observation:Observation;

        public var assignments:Vector.<Assignment> = new Vector.<Assignment>();

        public var frequencyRange:Array = [];

        protected var _status:String = RangeStatus.NASCENT;

        public function get startFrequency():Number {
            return range[0];
        }

        public function set startFrequency(value:String):void {
            range[0] = value;
        }

        public function get endFrequency():Number {
            return range[1];
        }

        public function set endFrequency(value:String):void {
            range[1] = value;
        }

        public function set status(value):void {
            if(RangeStatus.isValid(value)) {
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