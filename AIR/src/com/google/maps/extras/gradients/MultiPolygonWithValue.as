/**
* Copyright 2009 Google Inc. 
* Licensed under the Apache License, Version 2.0:
*  http://www.apache.org/licenses/LICENSE-2.0
*/

package com.google.maps.extras.gradients {

  import com.google.maps.LatLng;
  import com.google.maps.Map;
  import com.google.maps.MapMouseEvent;
  import com.google.maps.overlays.EncodedPolylineData;
  import com.google.maps.overlays.Polygon;
  import com.google.maps.overlays.PolygonOptions;

  /** 
  * MultiPolygonWithValue is a wrapper class for Flash Maps API polygons
  * that associates a multipolygon geometry with a numerical value.
  *   
  * @author Simon Ilyushchenko
  */  
  public class MultiPolygonWithValue  {
    // The id associated with the object - usually the geometrry name.
    public var id:String = "";
    // The numerical value associated with the object,
    // to be used in gradient calculations.
    public var amount:Number = NaN;
    // List of Polygon objects comprising this object.
    private var polygons:Array = [];

    public function MultiPolygonWithValue() {
    }

    /** 
    * Add a Polygon to the current list of polygons.
    * 
    * @param points Array of LatLng coordinates
    * @param options PolygonOptions 
    */  
    public function addPolygonFromLatLng(
        points:Array, options:PolygonOptions = null):void {
      var p:Polygon = new Polygon(points, options);
      polygons.push(p);
    }
  
    /** 
    * Add a Polygon constructed from encoded polylines
    * 
    * @param points Array of encoded polylines
    * @param options PolygonOptions 
    */  
    public function addPolygonFromEncoded(
        polylineList:Array, options:PolygonOptions = null):void {
      var p:Polygon = Polygon.fromEncoded(polylineList, options);
      polygons.push(p);
    }
  
    /** 
    * Add a Polygon constructed from a geojson object
    * 
    * @param geojsonMultiPolygon A geojson object
    * @param options PolygonOptions 
    */  
    public function fromGeojsonMultiPolygon(
        geojsonMultiPolygon:Object, options:PolygonOptions = null):void {
      for each(var geojsonPolygon:Array in geojsonMultiPolygon) {
        for each(var geojsonPoints:Array in geojsonPolygon) {
          var vertices:Array = [];
          for each (var geojsonPoint:Array in geojsonPoints) {
            vertices.push(new LatLng(geojsonPoint[1], geojsonPoint[0]));
          }
          addPolygonFromLatLng(vertices, options);
        }
      }
    }

    /** 
    * Change polygon options on all constituent polygons
    */  
    public function setOptions(options:PolygonOptions):void {
      for each(var polygon:Polygon in polygons) {
        polygon.setOptions(options);
      }
    }

    /** 
    * Add an event listener to all constituent polygons
    */  
    public function addEventListener(eventType:String, f:Function):void {
      for each(var p:Polygon in polygons) {
        p.addEventListener(eventType, f);
      }
    }

    /** 
    * Remove an event listener from all constituent polygons
    */  
    public function removeEventListener(eventType:String, f:Function):void {
      for each(var p:Polygon in polygons) {
        p.removeEventListener(eventType, f);
      }
    }

    /** 
    * Add all constituent polygons to a map
    */  
    public function addToMap(map:Map): void {
      for each(var p:Polygon in polygons) {
        map.addOverlay(p);
      }
    }

    /** 
    * Remove all constituent polygons from a map
    */  
    public function removeFromMap(map:Map): void {
      for each(var p:Polygon in polygons) {
        map.removeOverlay(p);
      }
    }
  }
}
