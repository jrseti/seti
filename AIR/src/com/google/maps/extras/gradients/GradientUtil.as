/**
* Copyright 2009 Google Inc. 
* Licensed under the Apache License, Version 2.0:
*  http://www.apache.org/licenses/LICENSE-2.0
*/

package com.google.maps.extras.gradients {
  import flash.errors.IllegalOperationError;

  /** 
  * GradientUtil contains low-level functions for calculating gradients.
  *   
  * @author Simon Ilyushchenko
  */  

  public class GradientUtil {
    /** Perform a linear transformation of a number from one numerical range
    * to another. Both srcDict and dstDict should contain keys 'min' and 'max'
    * with numerical values. The min values can be greater than the max value
    * in one or both dictionaries.
    *
    * @param srcDict A dictionary defining the source range 
    * @param dstDict A dictionary defining the destination range 
    * @param src A number to scale from the source range 
    * @param dstStepCount An optional parameter that "snaps"
    * the result of the scaling to a grid dividing the destination range
    * into this number of steps.
    *
    * return: The number in the destination range corresponding to the
    * specified number in the source range.
    *
    * @throws flash.errors.IllegalOperationError When srcDict or dstDict
    * do not contain both 'min' and 'max' entries.
    */
    public static function linearScale(
        srcDict:Object, dstDict:Object, src:Number,
        dstStepCount:int=0):Number {

      if (! 'min' in srcDict || ! 'max' in srcDict) {
        throw new IllegalOperationError(
            "The srcDict dictionary should contain 'min' and 'max' entries.");
      }
      if (! 'min' in dstDict || ! 'max' in dstDict) {
        throw new IllegalOperationError(
            "The dstDict dictionary should contain 'min' and 'max' entries.");
      }
      var minSrc:Number = srcDict['min'];
      var maxSrc:Number = srcDict['max'];
      var minDst:Number = dstDict['min'];
      var maxDst:Number = dstDict['max'];

      var srcNorm:Number = src;
      var dst:Number;
      if (minSrc == maxSrc) {
        dst = minDst;
      } else {
        dst = minDst + (
            (srcNorm - minSrc) / (maxSrc - minSrc) * (maxDst - minDst));
      }
      var result:Number = NaN;
      if (minDst < maxDst) {
        result = Math.min(Math.max(minDst, dst), maxDst);
      } else {
        result = Math.max(Math.min(minDst, dst), maxDst);
      }
      if (dstStepCount == 0) {
        return result;
      } else if (dstStepCount < 0) {
        throw new IllegalOperationError(
            "The value of destStepCount should be non-negative.");
      } else {
        var step:Number = (maxDst - minDst) / (dstStepCount + 0.0);
        var stepNum:int = Math.round(linearScale(
            dstDict, {'min': 0, 'max': dstStepCount}, result));
        return minDst + stepNum * step;
      }
    }

    /** Calculate the min and max values of an array.
    *
    * @param values An array of numbers
    *
    * @return A two-element array with the min and max values of the input array
    */
    public static function arrayMinMax(values:Array): Array {
      if (values.length == 0) { 
        return [];
      }   
      var overallMinValue:Number = values[0];
      var overallMaxValue:Number = values[0];
      for each(var v:Number in values) {
        if (v < overallMinValue) {
          overallMinValue = v;
        }   
        if (v > overallMaxValue) {
          overallMaxValue = v;
        }   
      }   

      return [overallMinValue, overallMaxValue];
    }
  }
}
