package com.hg94.seti.model {
    import flash.utils.describeType;

    public class PatternMarkCategory {
        public static const LOCAL:String = "LOCAL";

        public static const DIAGONAL:String = "DIAGONAL";

        public static const SQUIGGLE:String = "SQUIGGLE";

        public static const PULSE:String = "PULSE";

        public static const BROADBAND:String = "BROADBAND";

        public static const MODULATION:String = "MODULATION";

        public static const RADAR:String = "RADAR";

        public static const UNKNOWN:String = "UNKNOWN";


        public static function valuesToArray():Array {
            var coll:Array = new Array();
            var classInfo:XML = describeType(PatternMarkCategory);
            var constants:XMLList = classInfo..constant;
            var i:uint = 0;
            var l:uint = constants.length();
            for(i = 0;i<l;++i) {
                var constant:XML = constants[i] as XML;
                var constantName:String = constant.@name.toString();
                var constantValue:String = PatternMarkCategory[constantName] as String;
                coll.push(constantValue);
            }
            coll.sort(Array.CASEINSENSITIVE);
            return coll;
        }

        public static function isValid(value:String):Boolean {
            var coll:Array = PatternMarkCategory.valuesToArray();
            for each(var item:String in coll) {
                if(item==value) {
                    return true;
                }
            }
            return false;
        }
    }
}