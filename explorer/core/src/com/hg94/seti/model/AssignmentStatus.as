package com.hg94.seti.model {
    import flash.utils.describeType;

    import mx.collections.ArrayCollection;

    public class AssignmentStatus {



        public static const NASCENT:String = "NASCENT";

        public static const IN_PROGRESS:String = "IN_PORGRESS";

        public static const COMPLETED:String = "COMPLETED";



        public static function valuesToArray():Array {
            var coll:Array = new Array();
            var classInfo:XML = describeType(AssignmentStatus);
            var constants:XMLList = classInfo..constant;
            var i:uint = 0;
            var l:uint = constants.length();
            for(i = 0;i<l;++i) {
                var constant:XML = constants[i] as XML;
                var constantName:String = constant.@name.toString();
                var constantValue:String = AssignmentStatus[constantName] as String;
                coll.push(constantValue);
            }
            coll.sort(Array.CASEINSENSITIVE);
            return coll;
        }

        public static function isValid(value:String):Boolean {
            var coll:Array = AssignmentStatus.valuesToArray();
            for each(var item:String in coll) {
                if(item==value) {
                    return true;
                }
            }
            return false;
        }
    }
}