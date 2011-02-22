package com.hg94.seti.model {
    import com.google.maps.LatLng;
    import com.google.maps.extras.gradients.Range;


    /** Represents a position in outer space, and does coordinate transformations
     */

    public class Target {

        public var observations:Vector.<Observation> = new Vector.<Observation>();




        /**********************************************************************************
         * Previously existing stuff where does this go?
         */



        // Private variable declarations


        /** Celestial coordinates
         */

        protected var _rightAscension:Number;

        protected var _declination:Number;


        /** The name of the target
         */

        protected var _friendlyName:String


        /** The default observation, typically the most recent
         */

        protected var _defaultObservation:Observation;


        public var description:String;


        // Getters and Setters


        [Bindable]
        public function get rightAscension():Number {
            return this._rightAscension;
        }

        public function set rightAscension(value:Number):void {
            _rightAscension = value;
        }

        [Bindable]
        public function get declination():Number {
            return this._declination;
        }

        public function set declination(value:Number):void {
            _declination = value;
        }


        public function get coordinateString():String {
            return 'RA: '+Math.round(this.rightAscension*1000)/1000+', Decl: '+Math.round(this.declination*1000)/1000
        }


        public function get friendlyName():String {
            return this._friendlyName;
        }

        [Bindable]
        public function set defaultObservation(defaultObservation:Observation):void {
            this._defaultObservation = defaultObservation;
        }

        public function get defaultObservation():Observation {
            return this._defaultObservation;
        }

        // Constructor

        function Target(friendlyName:String):void {
            this._friendlyName = friendlyName;
        }



        // Public methods


        /** No longer reversing the sign. Let's get it right in our database.
         */

        public function setSETICoordinates(rightAscension:Number,declination:Number):void {
            this._rightAscension = rightAscension;
            this._declination = declination;
        }


        /** Perform the conversion to the coordinates used by Google Sky.
         * 	Assumes rightAscension and declination have been set
         */

        public function getGoogleSkyCoordinates():LatLng {
            var latitude:Number = this._declination; // Note we have already adjusted the sign
            var longitude:Number = 180.0-(this._rightAscension/24.0)*360.0
            var latLng:LatLng = new LatLng(latitude,longitude);
            return latLng;
        }
    }
}