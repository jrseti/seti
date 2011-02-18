/**
* Copyright 2009 Google Inc. 
* Licensed under the Apache License, Version 2.0:
*  http://www.apache.org/licenses/LICENSE-2.0
*/

package com.google.maps.extras.gradients {
  import com.google.maps.Color;
  import com.google.maps.Map;
  import com.google.maps.MapMouseEvent;
  import com.google.maps.overlays.Polygon;
  import com.google.maps.overlays.PolygonOptions;

  /**
  * ThematicOverlay is a convenience class for drawing thematic maps.
  *
  * @author Simon Ilyushchenko
  */


  public class ThematicOverlay {
    // Default transparency factor to use when drawing geometries.
    public var alpha: Number = 0.7;
    // Gradient rule to use for calculating colors.
    public var gradientRule:GradientRule;

    private var map:Map;
    private var polygonsWithValues:Object;

    /** 
    * Class constructor
    *
    * @param map A Flash API Map object
    * @param gradientRule The gradient rule or list of rules to use
    * @param polygonsWithValues The list of MultiPolygonWithValues to draw
    */  
    public function ThematicOverlay(
          map:Map, gradientRule:GradientRule, polygonsWithValues:Object) {
      this.map = map;
      this.gradientRule = gradientRule;
      this.polygonsWithValues = polygonsWithValues;

      for each(var p:MultiPolygonWithValue in this.polygonsWithValues) {
        p.addToMap(map); 
      }
    }
    
    /** 
    * Draw this overlay on the map, coloring all geometries
    * in appropriate colors
    */
    public function draw():void {
      var values:Array = [];
      for each(var p:MultiPolygonWithValue in polygonsWithValues) {
        values.push(p.amount);
      }

      var gradientControl:GradientControl = 
          gradientRule.applyGradientToValueList(values);

      for each(p in polygonsWithValues) {
        var options:Object = {};
        if (isNaN(p.amount)) {
          options.alpha = 0.0;
        } else {
          var color:Number = gradientControl.colorForValue(p.amount);
          options.color = color;
          options.alpha = alpha;
        }
 
        p.setOptions(new PolygonOptions({fillStyle: options})); 
      }
    }
  }
}
