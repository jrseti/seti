package com.hg94.seti.model {
	import com.google.maps.LatLng;
	
	
	/** Represents a position in outer space, and does coordinate transformations
	 */
	
	public class Target {


		
		// Private variable declarations
		
		
		/** Celestial coordinates
		 * 	We will reverse the sign on the declination provided by SETIQuest, to make it the same as Wikipedia and Google Earth
		 */
		
		protected var _rightAscension:Number;
		protected var _declination:Number;
		
		
		/** The name of the target
		 */
	
		protected var _friendlyName:String
		
		
		/** The default observation, typically the most recent
		 */
		
		protected var _defaultObservation:Observation;
		
		
		
		// Getters and Setters

		
		public function get rightAscension():Number {
			return this._rightAscension;
		}
		
		public function get declination():Number {
			return this._declination;
		}
		
		public function get friendlyName():String {
			return this._friendlyName;
		}
		
		public function set defaultObservation(defaultObservation:Observation):void {
			this._defaultObservation = defaultObservation;
		}
		

		
		// Constructor
		
		function Target(friendlyName:String):void {
			this._friendlyName = friendlyName;
		}
		
		

		// Public methods
		
		
		/** For some reason, SETI Institute uses an incorrectly signed declination number in the metadata files
		 */
		
		public function setSETICoordinates(rightAscension:Number, declination:Number):void {
			this._rightAscension = rightAscension;
			this._declination = 0.0 - declination;
		}
		
		
		/** Perform the conversion to the coordinates used by Google Sky.
		 * 	Assumes rightAscension and declination have been set
		 */
		
		public function getGoogleSkyCoordinates():LatLng { 
			var latitude:Number = this._declination;  // Note we have already adjusted the sign
			var longitude:Number = 180.0 - (this._rightAscension/24.0)*360.0
			var latLng:LatLng = new LatLng(latitude, longitude);
			return latLng;
		}
	}
}