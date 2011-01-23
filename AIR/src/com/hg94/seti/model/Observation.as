package com.hg94.seti.model {
	import mx.collections.ArrayCollection;
	
	
	
	/** Represents an observation of a single Target on a single day
	 */
	
	public class Observation {
		
		
		
		// Protected variable declarations
		
		
		/** Date of the observation
		 */
		
		protected var _date:Date;
		
		
		/** Lowest wavelength represented (in MHz)
		 */
		
		protected var _minWavelength:Number;
		
		
		/** Highest wavelength represented (in MHz)
		 */
	
		protected var _maxWavelength:Number;
		
		
		/** Set of waterfall tile URLs
		 */
		
		protected var _waterfallTiles:ArrayCollection;
		
		
		
		
		// Getters and setters
		
		
		/** Date of the observation
		 */
		
		public function get date():Date {
			return this._date;
		}
		
		
		
		// Constructor
		

		public function Observation(date:Date) {
			this._date = date;
			this._waterfallTiles = new ArrayCollection();
		}
		
		
		
		// Public methods
		
		
		/** Adds a waterfall tile to the observation
		 * 	Assumes it's next in order
		 * 	TODO: Update min and max wavelength for the observation
		 * 	TODO: Add a sort
		 */
		
		public function addWaterfallTile(waterfallTile:WaterfallTile):void {
			this._waterfallTiles.addItem(waterfallTile);
		}
	}
}