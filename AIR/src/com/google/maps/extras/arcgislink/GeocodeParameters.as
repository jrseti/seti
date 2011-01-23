/*
 * ArcGIS for Google Maps Flash API
 *
 * License http://www.apache.org/licenses/LICENSE-2.0
 */
 /**
 * @author nianwei at gmail dot com
 */ 

package com.google.maps.extras.arcgislink
{
  import com.google.maps.extras.arcgislink.ArcGISUtil;
  
  public class GeocodeParameters
  {
    public var f:String;
    public var inputs:*;
    public var outFields:Array;
    public function GeocodeParameters(params:*=null)
    {
      if (params){
        ArcGISUtil.augmentObject(params, this, false);
      }
    }

  }
}