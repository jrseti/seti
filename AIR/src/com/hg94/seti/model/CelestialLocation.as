package com.hg94.seti.model {
	import com.google.maps.LatLng;
	
	
	/** Represents a position in outer space, and does coordinate transformations
	 */
	
	public class CelestialLocation {


		
		// Private variable declarations
		
		
		private var __rightAscension:Number;
		private var __declination:Number;
		
		
		
		// Getters and Setters

		
		public function get rightAscension():Number {
			return this.__rightAscension;
		}
		
		public function get declination():Number {
			return this.__declination;
		}
		

		

		// Public methods
		
		
		/** For some reason, SETI Institute uses an incorrectly signed declination number in the metadata files
		 */
		
		public function setSETICoordinates(rightAscension:Number, declination:Number):void {
			this.__rightAscension = rightAscension;
			this.__declination = 0.0 - declination;
		}
		
		
		/** Perform the conversion to the coordinates used by Google Sky.
		 * 	Assumes rightAscension and declination have been set
		 */
		
		public function getGoogleSkyCoordinates():LatLng { 
			var latitude:Number = this.__declination;  // Note we have already adjusted the sign
			var longitude:Number = 180.0 - (this.__rightAscension/24.0)*360.0
			var latLng:LatLng = new LatLng(latitude, longitude);
			return latLng;
		}
	}
}