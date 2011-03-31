// Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
// NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the Mozilla Public License (MPL) v1.1.

package com.hg94.seti.model {
    import flash.utils.describeType;

    import mx.collections.ArrayCollection;

    public class ObservationRangeStatus {

        public static const NASCENT:String = "NASCENT";

        public static const IN_PROGRESS:String = "IN_PORGRESS";

        public static const COMPLETED:String = "COMPLETED";

        public static function valuesToArray():Array {
            var coll:Array = new Array();
            var classInfo:XML = describeType(ObservationRangeStatus);
            var constants:XMLList = classInfo..constant;
            var i:uint = 0;
            var l:uint = constants.length();
            for(i = 0;i<l;++i) {
                var constant:XML = constants[i] as XML;
                var constantName:String = constant.@name.toString();
                var constantValue:String = ObservationRangeStatus[constantName] as String;
                coll.push(constantValue);
            }
            coll.sort(Array.CASEINSENSITIVE);
            return coll;
        }

        public static function isValid(value:String):Boolean {
            var coll:Array = ObservationRangeStatus.valuesToArray();
            for each(var item:String in coll) {
                if(item==value) {
                    return true;
                }
            }
            return false;
        }
    }
}