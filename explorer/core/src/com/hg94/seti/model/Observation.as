// Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
// NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the Mozilla Public License (MPL) v1.1.

package com.hg94.seti.model {
    import mx.collections.ArrayCollection;
    import mx.formatters.DateFormatter;



    /** Represents an observation of a single Target on a single day
     */

    [Bindable] public class Observation {

        public var target:Target;

        public var date:Date;

        /**********************************************************************************
         * Previously existing stuff where does this go?
         */



        // Protected variable declarations


        /** Date of the observation
         */

        protected var _date:Date;


        /** Set of waterfall tile URLs
         */

        protected var _waterfallTiles:ArrayCollection;


        /** Url the observation is based on.
         */

        protected var _baseUrl:String;


        /** Target in the sky
         */







        // Getters and setters


        /** Date of the observation
         */

        public function get baseUrl():String {
            return _baseUrl;
        }

        public function set baseUrl(value:String):void {
            _baseUrl = value;
        }

        public function get waterfallTiles():ArrayCollection {
            return this._waterfallTiles;
        }
		
		
		public function get friendlyDate():String {
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = "MMMM D, YYYY";
			return dateFormatter.format(this.date);
		}


        // Constructor


        public function Observation(date:Date,target:Target) {
            this.date = date;
            this._waterfallTiles = new ArrayCollection();
            this.target = target;
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