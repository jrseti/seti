/*
 * ArcGIS for Google Maps Flash API
 *
 * License http://www.apache.org/licenses/LICENSE-2.0
 */
 /**
 * @author nianwei at gmail dot com
 */ 
package com.google.maps.extras.arcgislink {

  public class ResultSet {
    public var displayFieldName:String;
    public var features:Array=[];
    public var fieldAliases:*;
    public var geometryType:String;
    public var spatialReference:SpatialReference;
	/* AGS 10 */
	public var fields:Array=[];
	

    public function ResultSet(params:*=null, ovOpts:OverlayOptions=null) {
      if (params) {
        if (params.features) {
          var res:*=params.features;
          for (var i:int=0; i < res.length; i++) {
            var r:* = res[i];
            features.push(new Feature(r, ovOpts,ArcGISUtil.getAttributeValue(r.attributes, params.displayFieldName)));
          }
        }
		if (params.spatialReference && params.spatialReference.wkid){
			spatialReference = SpatialReferences.getSpatialReference(params.spatialReference.wkid)
				||new SpatialReference(params.spatialReference);
		}
      
        ArcGISUtil.augmentObject(params, this, false);
      }
    }

  }
}