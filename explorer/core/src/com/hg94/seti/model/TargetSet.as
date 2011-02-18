package com.hg94.seti.model {
	import com.google.maps.LatLng;
	
	import mx.collections.ArrayCollection;
	
	
	/** Represents the whole set of Targets available to the user
	 */
	
	public class TargetSet {
		
	
		
		// Protected variable declarations
		
		
		/** Array of targets
		 */
		
		protected var _targetArray:ArrayCollection;
		
		
		/** Object that indexes the targets by lat/long
		 */

		protected var _targetIndex:Object;
		
		
		
		// Getters and setters
		
		
		/** Get the array to iterate through it
		 */
	
		public function get targetArray():ArrayCollection {
			return this._targetArray;
		}
		
		
		
		// Constructor
		
		public function TargetSet() {
			this._targetArray = new ArrayCollection();
			this._targetIndex = new Object();
		}
		
		
		
		// Public methods
		
		
		/** Add a Target to the set
		 */
		
		public function addTarget(target:Target):void {
			this._targetArray.addItem(target);
			var latLng:LatLng = target.getGoogleSkyCoordinates();
			this._targetIndex[latLng] = target;
		}
		
		
		/** Get a target for a lat and long, after user clicks
		 */
		
		public function getTargetByGoogleSkyCoordinates(latLng:LatLng):Target {
			return this._targetIndex[latLng];
		}
	}
}