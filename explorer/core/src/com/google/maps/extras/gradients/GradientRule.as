/**
* Copyright 2009 Google Inc. 
* Licensed under the Apache License, Version 2.0:
*  http://www.apache.org/licenses/LICENSE-2.0
*/

package com.google.maps.extras.gradients {
  import com.google.maps.Color;
  import flash.utils.getQualifiedClassName;

  /** 
  * GradientRule is a basic building block for gradient configurations.
  * One GradientRule object corresponds to a gradient transition
  * between two color values. Together with other GradientRule objects,
  * it sholud be contained in GradientRuleList to form a full gradient config.
  *   
  * @author Simon Ilyushchenko
  */  

  public class GradientRule extends Range {

    public function GradientRule() {
      super(this);
    }

    /** 
    * Create a new instance of this class from an XML config
    *
    * @param xml An XML configuration specifying gradient config
    */  
    public static function fromXML(xml:XML):GradientRule {
      var result:GradientRule = new GradientRule();
      if (xml.minPercent != undefined) {
        result.minPercent = xml.minPercent;
      }
      if (xml.maxPercent != undefined) {
        result.maxPercent = xml.maxPercent;
      }
      if (xml.minValue != undefined) {
       result.minValue = xml.minValue;
      }
      if (xml.maxValue != undefined) {
        result.maxValue = xml.maxValue;
      }
      if (xml.minColor != undefined) {
        result.minColor = xml.minColor;
      }
      if (xml.maxColor != undefined) {
        result.maxColor = xml.maxColor;
      }
      return result;
    }

    /**
    * Start of a percentage range. Values are forced to be greater than
    * MIN_PERCENT.
    */
    public override function set minPercent(value:Number):void {
      if (value < MIN_PERCENT) {
        value = MIN_PERCENT;
      }
      _minPercent = value;
    }

    /**
    * End of a percentage range. Values are forced to be less than
    * MAX_PERCENT.
    */
    public override function set maxPercent(value:Number):void {
      if (value > MAX_PERCENT) {
        value = MAX_PERCENT;
      }
      _maxPercent = value;
    }

   
    /** 
    * Create a new instance of this class from an XML config
    *
    * @param dataValues An array of numbers
    *
    * @return A new GradientControl objects with this object's
    * gradient config applied to the specified values
    */  
    public function applyGradientToValueList(dataValues:Array):GradientControl {
      var arrayMinMax:Array = GradientUtil.arrayMinMax(dataValues);
      if (arrayMinMax.length == 0) {
        return null;
      }
      minValue = arrayMinMax[0];
      maxValue = arrayMinMax[1];

      // TODO: should these be called twice?

      // Try reading values from children
      fillValueColorFromChildren();
      // If still unfilled, try reading values from the siblings
      fillValueColorFromSiblings();
      // If still unfilled, try reading values from the parent
      fillValueColorFromParent(this);

      var gradients:Array = createValueColorGradients(this);
      return new GradientControl(gradients);
    }

    // Nothing to do - these are leaf objects.
    function fillValueColorFromChildren():void {
    }
    function fillValueColorFromSiblings():void {
    }
    function fillValueColorFromParent(parent:GradientRule):void {
    }   

    // If min or max absolute values are not specified,
    // calculate them based on the percentage values
    // and on the min/max values taken from the parent.
    function createValueColorGradients(parent:Range): Array {
      var percentRangeDict:Object = {
        'min': 0,
        'max': 100
      }
      var flatGradient:ValueColorGradient = createFlatGradient();
      var dstDict:Object = {
        'min': parent.minValue,
        'max': parent.maxValue
      }
      if (isNaN(flatGradient.minValue)) {
        flatGradient.minValue = GradientUtil.linearScale(
            percentRangeDict, dstDict, minPercent);
      }
      if (isNaN(flatGradient.maxValue)) {
        flatGradient.maxValue = GradientUtil.linearScale(
            percentRangeDict, dstDict, maxPercent);
      }

      return [flatGradient];
    }

    // Create a gradient with absolute values for use in a GradientControl.
    protected function createFlatGradient(): ValueColorGradient {
      var result:ValueColorGradient = new ValueColorGradient();
      result.minValue = this.minValue;
      result.maxValue = this.maxValue;
      result.minColor = this.minColor;
      result.maxColor = this.maxColor;
      return result;
    }   
 
    // Duplicate the min values of another GradientRule object 
    function fillMin(other:GradientRule):void {
      if (isNaN(minValue)) {
        minValue = other.minValue;
      }
      if (isNaN(minColor)) {
        minColor = other.minColor;
      }
      // Do not transfer percentage between levels
    }

    // Duplicate the max values of another GradientRule object 
    function fillMax(other:GradientRule):void {
      if (isNaN(maxValue)) {
        maxValue = other.maxValue;
      }
      if (isNaN(maxColor)) {
        maxColor = other.maxColor;
      }
      // Do not transfer percentage between levels
    }

    // Duplicate the max values of another GradientRule object 
    // as the min values for this object
    function fillFromPrev(
        prev:GradientRule, fillPercent:Boolean=true):void {
      if (isNaN(minPercent) && fillPercent) {
        //minValue won't be overriden by this
        minPercent = prev.maxPercent;
      }
      if (isNaN(minValue)) {
        minValue = prev.maxValue;
      }
      if (isNaN(minColor)) {
        minColor = prev.maxColor;
      }
    }

    // Duplicate the min values of another GradientRule object 
    // as the max values for this object
    function fillFromNext(
        next:GradientRule, fillPercent:Boolean=true):void {
      if (isNaN(maxPercent) && fillPercent) {
        //maxValue won't be overriden by this
        maxPercent = next.minPercent;
      }
      if (isNaN(maxValue)) {
        maxValue = next.minValue;
      }

      if (isNaN(maxColor)) {
        maxColor = next.minColor;
      }
    }
  }
}
