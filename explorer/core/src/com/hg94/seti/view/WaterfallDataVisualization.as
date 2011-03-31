// Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
// NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the Mozilla Public License (MPL) v1.1.


package com.hg94.seti.view {

	//import com.hg94.seti.controller.ObservationRequest;
	import com.hg94.seti.model.Assignment;
	import com.hg94.seti.model.Model;
	import com.hg94.seti.model.Observation;
	import com.hg94.seti.model.Target;
	
	import components.DataVizTileListPlaceholder;
	
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;

	public class WaterfallDataVisualization {
/*
		[Bindable]
		internal var target:Target;
*/		
		[Bindable]
		internal var observation:Observation;
		
		[Bindable]
		protected var observationImages:ArrayCollection;
		
		//[Bindable]
		//public var midFrequency:String;
		
		[Bindable]
		protected var _model:Model;
		
		public var visualizationTileList:VisualizationTileList;
		
		public function WaterfallDataVisualization(dataVizTileListPlaceholder:DataVizTileListPlaceholder, model:Model) {
			this._model = model;
			this.visualizationTileList = new VisualizationTileList();
			dataVizTileListPlaceholder.addElement(this.visualizationTileList);
			BindingUtils.bindSetter(this.setAssignment, model, ["currentAssignment"]);
			//BindingUtils.bindProperty(model, "currentMHzMidpoint", this.visualizationTileList, "midFrequency");
			ChangeWatcher.watch(this.visualizationTileList, "percentScrolled", this.visualizationTileListPercentScrolledChangeHandler)
			//BindingUtils.bindSetter(this.setPercentScrolled, this.visualizationTileList, "percentScrolled");
			//this.visualizationTileList.addEventListener(FlexEvent.CREATION_COMPLETE, onCC);
			//BindingUtils.bindProperty(this.visualizationTileList, "dataProvider", model, ["assignment", "observationRange", "filenameArray"]);
		}
		
		protected function visualizationTileListPercentScrolledChangeHandler(event:PropertyChangeEvent):void {
			var percentScrolled:Number = event.newValue as Number;
			//trace("Updating to " + percentScrolled);
			if (!isNaN(percentScrolled)) {
				var loMHz:Number = this._model.currentAssignment.observationRange.loMHz;
				var hiMHz:Number = this._model.currentAssignment.observationRange.hiMHz;
				this._model.currentMHzMidpoint = loMHz + percentScrolled * (hiMHz - loMHz);
			}
		}
		
		protected function setAssignment(assignment:Assignment):void {
			if (assignment) {
				this.visualizationTileList.dataProvider = assignment.observationRange.filenameCollection;
			}
		}
	}
}
