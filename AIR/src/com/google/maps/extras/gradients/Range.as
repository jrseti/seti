/**
* Copyright 2009 Google Inc. 
* Licensed under the Apache License, Version 2.0:
*  http://www.apache.org/licenses/LICENSE-2.0
*/

package com.google.maps.extras.gradients {
  import flash.errors.IllegalOperationError;
  import com.google.maps.Color;

  /** 
  * A Range is an abstract class that stores three numerical ranges
  * representing colors, absolute values and percentages.
  *   
  * @author Simon Ilyushchenko
  */  

  public class Range {
    // Use this value if the start of a range is undefined.
    protected static var MIN_PERCENT:Number = 0;
    // Use this value if the end of a range is undefined.
    protected static var MAX_PERCENT:Number = 100;

    // Start of a range
    public var minValue:Number = NaN;
    // End of a range
    public var maxValue:Number = NaN;

    // Start of a color range
    public var minColor:Number = NaN;
    // Start of a color range
    public var maxColor:Number = NaN;

    // Access to min/maxPercent will be overridden in subclasses,
    // hence they are not public.
    protected var _minPercent:Number = NaN; /** Backing for minPercent. */
    protected var _maxPercent:Number = NaN; /** Backing for maxPercent. */

    /**
    * Class constructor
    * 
    * @param self The instance of the child being constructed
    *
    * @throws flash.errors.IllegalOperationError If this abstract class is
    *   instantiated directly.
    */
    public function Range(self:Range) {
      //only a subclass can pass a valid reference to self
      if (self != this) {
        throw new IllegalOperationError(
            "Abstract class did not receive reference to self. " +
            "MyAbstractType cannot be instantiated directly.");
      }
    }

    /**
    * Start of a percentage range.
    */
    public function get minPercent():Number {
      return _minPercent;
    }   
    public function set minPercent(someValue:Number):void {
      _minPercent = someValue;
    }   

    /**
    * End of a percentage range.
    */
    public function get maxPercent():Number {
      return _maxPercent;
    }   
    public function set maxPercent(someValue:Number):void {
      _maxPercent = someValue;
    }

   /**
    * String representation of this object
    */
    public function toString():String {
      return ([
        "Range: ",
        "value: " + minValue.toString() + " - " + maxValue.toString(),
        "percent: " + minPercent.toString() + " - " + maxPercent.toString(),
        "color: " + rgbColorDictString()
      ]).join(", ");
    }

    /**
    * String representation of the color ranges of this object
    */
    public function rgbColorDictString():String {
      var rgbColorDict:Object = getRgbColorDict();
      var result:Array = [];
      result.push(
          "Start: " + rgbColorDict['r']['min'].toString() + "," +
          rgbColorDict['g']['min'].toString() + ", " + 
          rgbColorDict['b']['min'].toString());
      result.push(
          "End: " + rgbColorDict['r']['max'].toString() + "," +  
          rgbColorDict['g']['max'].toString() + ", " + 
          rgbColorDict['b']['max'].toString());
      return result.join(', ');
    }

    function getValueDict():Object {
      return {
          'min': minValue,
          'max': maxValue
      }
    }

    function getRgbColorDict():Object {
      var result:Object = {};
      var minColorObj:Color = new Color(minColor);
      var maxColorObj:Color = new Color(maxColor);
      result['r'] = {
          'min': minColorObj.r,
          'max': maxColorObj.r
      }
      result['g'] = {
          'min': minColorObj.g,
          'max': maxColorObj.g
      }
      result['b'] = {
          'min': minColorObj.b,
          'max': maxColorObj.b
      }
      return result;
    }
  }
}
