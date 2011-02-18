/**
* Copyright 2009 Google Inc. 
* Licensed under the Apache License, Version 2.0:
*  http://www.apache.org/licenses/LICENSE-2.0
*/

package com.google.maps.extras.gradients {
  import flash.errors.IllegalOperationError;
  import com.google.maps.Color;

  /**
  * ValueColorGradient is an internal class that's used by GradientControl
  * objects for storing final gradient lists. Certain functions are declared
  * public only so that the subclasses could have them public too.
  *
  * @author Simon Ilyushchenko
  */

  public class ValueColorGradient extends Range {

    /** 
    * Class constructor
    */  
    function ValueColorGradient() {
      super(this);
    }

    /**
    * Apply the scaling calculations to translate the specfied number
    * into a color within this object's range.
    */
    public function colorForValue(someValue:Number):Number  {
      var valueDict:Object = getValueDict();
      var rgbColorDict:Object = getRgbColorDict();
      var r:Number = GradientUtil.linearScale(
          valueDict, rgbColorDict['r'], someValue);
      var g:Number = GradientUtil.linearScale(
          valueDict, rgbColorDict['g'], someValue);
      var b:Number = GradientUtil.linearScale(
          valueDict, rgbColorDict['b'], someValue);
      var result:Color = new Color(0);
      result.setRGB(r, g, b); 
      return result.rgb;
    }   

    
    // Percentage values are not used with ValueColorGradients
    /**
     * @throws flash.errors.IllegalOperationError Always.
     */
    public override function get minPercent():Number {
      throw new IllegalOperationError(
          "ValueColorGradient can't specify percentages.");
    }   
    /**
     * @throws flash.errors.IllegalOperationError Always.
     */
    public override function set minPercent(someValue:Number):void {
      throw new IllegalOperationError(
          "ValueColorGradient can't specify percentages.");
    }   
    /**
     * @throws flash.errors.IllegalOperationError Always.
     */
    public override function get maxPercent():Number {
      throw new IllegalOperationError(
          "ValueColorGradient can't specify percentages.");
    }   
    /**
     * @throws flash.errors.IllegalOperationError Always.
     */
    public override function set maxPercent(someValue:Number):void {
      throw new IllegalOperationError(
          "ValueColorGradient can't specify percentages.");
    }

    function containsValue(someValue:Number):Boolean {
      return someValue < maxValue;
    }

    protected function numFlatGradients():int {
      return 1;
    }   

    protected function flatGradientAt(i:int):ValueColorGradient {
      return this;
    }  

    public override function toString():String {
      return ([
        "ValueColorGradient: ",
        "value: " + minValue.toString() + " - " + maxValue.toString(),
        "color: " + rgbColorDictString()
      ]).join(", ");
    }

  }
}
