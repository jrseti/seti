package com.hg94.seti.model {
    import flash.utils.describeType;

    import mx.collections.ArrayCollection;

    public class RangeStatus {

        public static const NASCENT:String = "NASCENT";

        public static const IN_PROGRESS:String = "IN_PORGRESS";

        public static const COMPLETED:String = "COMPLETED";

        public static function valuesToArray():Array {
            var coll:Array = new Array();
            var classInfo:XML = describeType(RangeStatus);
            var constants:XMLList = classInfo..constant;
            var i:uint = 0;
            var l:uint = constants.length();
            for(i = 0;i<l;++i) {
                var constant:XML = constants[i] as XML;
                var constantName:String = constant.@name.toString();
                var constantValue:String = RangeStatus[constantName] as String;
                coll.push(constantValue);
            }
            coll.sort(Array.CASEINSENSITIVE);
            return coll;
        }

        public static function isValid(value:String):Boolean {
            var coll:Array = RangeStatus.valuesToArray();
            for each(var item:String in coll) {
                if(item==value) {
                    return true;
                }
            }
            return false;
        }
    }
}