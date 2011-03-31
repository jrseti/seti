// Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
// NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the Mozilla Public License (MPL) v1.1.

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
		
		public function get imageURL():String
		{
			return this._imageURL;
		}
	}
}