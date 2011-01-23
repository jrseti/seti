/**
* Copyright 2009 Google Inc. 
* Licensed under the Apache License, Version 2.0:
* http://www.apache.org/licenses/LICENSE-2.0
*/

package com.google.maps.extras.gradients {
  import flash.utils.getQualifiedClassName;
  import com.google.maps.Color;
  import com.google.maps.extras.gradients.GradientUtil;

  /** 
  * GradientControl contains a list of gradient-calcaluting rules
  * applied to a specific numerical range.
  *   
  * @author Simon Ilyushchenko
  */  

  public class GradientControl extends ValueColorGradient {
    // A list of ValueColorGradients storing specific
    // gradient rules.
    private var flatGradientList:Array = [];

    /** 
    * Class constructor
    * 
    * @param flatFradientList The list of gradients to use
    */  
    public function GradientControl(flatGradientList:Array):void {
      super();
      // TODO: Make sure they are sorted???
      this.flatGradientList = flatGradientList;
    }

    // Return the number of gradients in this control
    protected override function numFlatGradients():int {
      return flatGradientList.length;
    } 

    // Return the gradient at the specified index
    protected override function flatGradientAt(i:int):ValueColorGradient {
      return flatGradientList[i];
    } 

    /** 
    * Find the gradient into whose range the specified value falls
    * and use it to calculate the color.
    * 
    * @param value A number to translate into a color.
    */  
    public override function colorForValue(value:Number):Number {
      for (var i:int=0; i<numFlatGradients(); i++) {
        var gradient:ValueColorGradient = flatGradientAt(i);
        if (gradient.containsValue(value)) {
          return gradient.colorForValue(value);
        }
      }
      // The value is greater than last gradient's max 
      // - delegate to last gradient.
      var lastGradient:ValueColorGradient = flatGradientAt(numFlatGradients()-1);
      return lastGradient.colorForValue(value);
    }
  
    /** 
    * Class constructor
    * 
    * @param flatFradientList The list of gradients to use
    */  
    public override function toString():String {
      var parentString:String = super.toString();
      var result:Array = [parentString];
      result.push('');
      result.push('Flat gradients');
      for (var j:int=0; j<numFlatGradients(); j++) {
        result.push(flatGradientAt(j).toString());
      }
      return result.join("\n");
    }
  }
}
