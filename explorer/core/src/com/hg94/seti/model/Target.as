package com.hg94.seti.model {
    import com.google.maps.LatLng;
    import com.google.maps.extras.gradients.Range;


    /** Represents a position in outer space, and does coordinate transformations
     */

    [Bindable] public class Target {

        public var rightAscension:Number;

        public var declination:Number;

        public var name:String

        public var description:String;



        /** Perform the conversion to the coordinates used by Google Sky.
         * 	Assumes rightAscension and declination have been set
         */

        public function getGoogleSkyCoordinates():LatLng {
            var latitude:Number = this.declination;
            var longitude:Number = 180.0-(this.rightAscension/24.0)*360.0
            var latLng:LatLng = new LatLng(latitude,longitude);
            return latLng;
        }
    }
}