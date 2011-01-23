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
  import com.google.maps.MapTypeOptions;
  public class ArcGISMapTypeOptions extends MapTypeOptions
  {
    
    
    public var name:String;
    public var projection:ArcGISTileConfig;
        
    public function ArcGISMapTypeOptions(opts:*=null)
    {
      //super(opts);
      // note augment object will fail if 
      if (opts) {
        ArcGISUtil.augmentObject(opts, this);
      }
    }

  }
}