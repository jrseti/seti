/**
* Copyright 2009 Google Inc. 
* Licensed under the Apache License, Version 2.0:
* http://www.apache.org/licenses/LICENSE-2.0
*/

package com.google.maps.extras.gradients {
  import com.google.maps.Color;
  import com.google.maps.extras.gradients.GradientUtil;

  /** 
  * GradientRuleList is the top class for creating gradient configs.
  * It can be constructed from a list of GradientRule objects
  * or from an XML spec. When combined with a list of Numbers,
  * GradientRuleList produces a GradientControl for subsequent use.
  *   
  * @author Simon Ilyushchenko
  */  

  public class GradientRuleList extends GradientRule {
    // A list of tree nodes with either GradientRule
    // or GradientRuleList objects.
    private var ruleList:Array = [];

    /** 
    * Class constructor
    * 
    * @param ruleList The list of child gradient rules
    */  
    public function GradientRuleList(ruleList:Array):void {
      super();
      // Make sure they are sorted???
      this.ruleList = ruleList;
    }

    /** 
    * Create a new instance of this class from an XML config
    *
    * @param xml An XML configuration specifying gradient config
    */  
    public static function fromXML(xml:XML):GradientRuleList {
      var rules:Array = [];
      for each (var xmlRule:XML in xml.gradientRule) {
        for each (var gradient1:XML in xmlRule.gradient) {
          rules.push(GradientRule.fromXML(gradient1));
        }
        for each (var gradient2:XML in xmlRule.gradientRuleList) {
          rules.push(GradientRuleList.fromXML(gradient2));
        }
      }
      return new GradientRuleList(rules);
    }

    /** 
    * Return a string representation of this object
    *
    * @return A string
    */  
    public override function toString():String {
      var parentString:String = super.toString();
      var result:Array = [parentString];
      result.push('');
      result.push('Original gradients');
      for each(var g:GradientRule in ruleList) {
        result.push(g.toString());
      }
      return result.join("\n");
    }

    /** 
    * Quickly create a two-color GradientControl for the specified values
    *
    * @param minColor The start of the color range
    * @param minColor The end of the color range
    * @param values The list of Numbers whose min and max values define
    * the numerical range.
    *
    * @return A GradientControl
    */  
    public static function twoColorGradientControl(
        minColor:Number, maxColor:Number, values: Array):GradientControl {

      var g:GradientRule = new GradientRule();
      // 0 and 100 percent are defaults
      g.minColor = minColor;
      g.maxColor = maxColor;

      var creator:GradientRuleList = new GradientRuleList([g]);
      // This should associate 0 and 100 percent with the min and max
      // values in the array.
      return creator.applyGradientToValueList(values);
    }

    /** 
    * Quickly create a three-color GradientControl for the specified values
    *
    * @param minColor The start of the color range
    * @param midColor The middle of the color range
    * @param minColor The end of the color range
    * @param values The list of Numbers whose min and max values define
    * the numerical range.
    *
    * @return A GradientControl
    */  
 
    public static function threeColorGradientControl(
        minColor:Number, midColor:Number, maxColor:Number,
        values: Array):GradientControl {
      // 0 and 100 percent are defaults

      var g1:GradientRule = new GradientRule();
      g1.maxPercent = 50;
      g1.minColor = minColor;
      g1.maxColor = midColor;

      var g2:GradientRule = new GradientRule();
      // Previous gradient's maxPercent (50) will be used as minPercent here.
      g2.minColor = midColor;
      g2.maxColor = maxColor;

      var creator:GradientRuleList = new GradientRuleList([g1, g2]);
      // This should associate 0 and 100 percent with the min and max
      // values in the array.
      return creator.applyGradientToValueList(values);
    }

    // Read value and color borders from children
    override function fillValueColorFromChildren():void {
      // Depth first.
      for each(var g:GradientRule in ruleList) {
        g.fillValueColorFromChildren();
      }

      if (ruleList.length > 0) {
        fillMin(ruleList[0]);
        fillMax(ruleList[ruleList.length-1]);
      }
    }

    // Read value and color borders from the parent
    override function fillValueColorFromParent(
        parent:GradientRule):void {
      super.fillValueColorFromParent(parent);
      if (ruleList.length == 0) {
        return;
      }
      // Breadth first
      ruleList[0].fillMin(this);
      ruleList[ruleList.length-1].fillMax(this);

      for each(var g:GradientRule in ruleList) {
        g.fillValueColorFromParent(this);
      }
    }

    // Read value and color borders from the neighboring gradients.
    // Use 0% and 100% for the start and end of the ranges if not specified.
    override function fillValueColorFromSiblings():void {
      var fantomFirstEntry:GradientRule = new GradientRule();
      fantomFirstEntry.maxPercent = Range.MIN_PERCENT;

      var fantomLastEntry:GradientRule = new GradientRule();
      fantomLastEntry.minPercent = Range.MAX_PERCENT;

      var paddedGradientList:Array = 
          [fantomFirstEntry].concat(ruleList).concat([fantomLastEntry]);

      for (var i:int=1; i<paddedGradientList.length-1; i++) {
        var g:GradientRule = paddedGradientList[i];

        var prev:GradientRule = paddedGradientList[i-1];
        var next:GradientRule = paddedGradientList[i+1];

        g.fillFromPrev(prev);
        g.fillFromNext(next);
  
        g.fillValueColorFromSiblings();
      }
    }

    // Create a flat list of gradients to be used in a GradientControl.
    override function createValueColorGradients(parent:Range):Array {
      var oneGradientList:Array = super.createValueColorGradients(parent);
      var flatGradient:ValueColorGradient = oneGradientList[0];

      var flatGradientList:Array = [];

      for each(var g:GradientRule in ruleList) {
        var childFlatGradients:Array = g.createValueColorGradients(
            flatGradient);
        flatGradientList = flatGradientList.concat(childFlatGradients);

      }

      return flatGradientList;
    }
  }
}
