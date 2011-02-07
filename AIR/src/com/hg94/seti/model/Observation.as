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
		
		
		/** Url the observation is based on.
		 */
		
		protected var _baseUrl:String;
		
		
		/** Target in the sky
		 */
		
		protected var _target:Target;
		
		
		
		// Getters and setters
		
		
		/** Date of the observation
		 */
		
		public function get date():Date {
			return this._date;
		}
		
		public function get baseUrl():String
		{
			return _baseUrl;
		}
		public function set baseUrl(value:String):void
		{
			_baseUrl = value;
		}
		
		public function get waterfallTiles():ArrayCollection
		{
			return this._waterfallTiles;
		}

		
		public function get target():Target {
			return this._target;
		}
		
		public function get averageWavelength():int {
			return Math.round((this._maxWavelength + this._minWavelength) / 2); 
		}
		
		
		
		// Constructor
		

		public function Observation(date:Date, target:Target) {
			this._date = date;
			this._waterfallTiles = new ArrayCollection();
			this._target = target;
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