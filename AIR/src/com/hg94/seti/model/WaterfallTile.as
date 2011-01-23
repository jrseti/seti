package com.hg94.seti.model {
	
	
	
	/** Represents a single waterfall tile image and its metadata
	 */
	
	
	public class WaterfallTile {
		
		
		
		// Protected variable declarations
		
		
		/** Lowest wavelength
		 */
		
		protected var _minWavelength:Number;
		
		
		/** Highest wavelength
		 */
		
		protected var _maxWavelength:Number;
		
		
		/** URL of the tile image
		 */
		
		protected var _imageURL:String;
		
	
		
		// Constructor
		
		
		public function WaterfallTile(minWavelength:Number, maxWavelength:Number, imageURL:String) {
			this._minWavelength = minWavelength;
			this._maxWavelength = maxWavelength;
			this._imageURL = imageURL;
		}
	}
}