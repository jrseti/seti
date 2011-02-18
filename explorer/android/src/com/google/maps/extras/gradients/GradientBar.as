/**
* Copyright 2009 Google Inc. 
* Licensed under the Apache License, Version 2.0:
*  http://www.apache.org/licenses/LICENSE-2.0
*/

package com.google.maps.extras.gradients {
  import mx.core.UIComponent;

  import com.google.maps.extras.gradients.GradientRule;

  /**
  * UI element that draws a horizontal box with one or more 
  * color gradients.
  * 
  * @author Simon Ilyushchenko
  */

  public class GradientBar extends UIComponent
  {
    // List of Numbers with absolute values for borders between gradients.
    public var borders:Array = [];

    public function GradientBar() {
     super();
    }

    /**
    * Draw the map legend with the specified gradientRule
    * 
    * @param gradientRule The Gradient Rule to draw
    */ 
    public function drawGradientRule(gradientRule:GradientRule): void {
      var gradientControl:GradientControl = 
          gradientRule.applyGradientToValueList([0, width]);
      for (var i:Number=0; i<borders.length-1; i++) {
        var borderValue:Number = borders[i];
        var nextBorderValue:Number = borders[i+1];
        var colors:Array = [
            gradientControl.colorForValue(borderValue),
            gradientControl.colorForValue(nextBorderValue)
        ];
        var coordinate:Number = valueToCoordinate(borderValue);
        var nextCoordinate:Number = valueToCoordinate(nextBorderValue);
        var matrix:Object = horizontalGradientMatrix(
            coordinate, 0, nextCoordinate - coordinate, this.height);
        drawRoundRect(
            coordinate, 0, nextCoordinate - coordinate, this.height, 
            null, colors, alpha, matrix);
      }
    }

    // Translate the coordinate of a border into a color
    private function valueToCoordinate(value:Number):Number {
      var srcDict:Object = {
        'min': borders[0], 
        'max': borders[borders.length-1]
      };
      var dstDict:Object = {
        'min': 0,
        'max': width
      };
      return GradientUtil.linearScale(srcDict, dstDict, value);  
    }


}
}
