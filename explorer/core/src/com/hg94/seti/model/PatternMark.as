package com.hg94.seti.model {

    public class PatternMark {
        public var signal:Pattern;

        public var date:String; //use epoch time

        protected var _category:String;

        public var description:String;

        public var approxFreqency:Number;

        public var assignment:Assignment;

        public function set category(value:String):void {
            if(PatternMarkCategory.isValid(value)) {
                _category = value;
            } else {
                throw new Error("Invalid category set on SignalMark");
            }
        }

        public function get category():String {
            return _category;
        }
    }
}