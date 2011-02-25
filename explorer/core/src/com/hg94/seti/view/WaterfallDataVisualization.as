/**
 * <?xml version="1.0" encoding="utf-8"?>
<s:View xmlns:fx="http://ns.adobe.com/mxml/2009" 
		xmlns:s="library://ns.adobe.com/flex/spark"
		xmlns:skinnablecomponents="com.hg94.seti.skinnablecomponents.*" 
		xmlns:components="com.hg94.seti.views.components.*"
		actionBarVisible="false" 
		currentState="loading"
		creationComplete="view1_creationCompleteHandler(event)">
	<s:states>
		<s:State name="loading"/>
		<s:State name="exploring"/>
	</s:states>
	<fx:Declarations>
		<!-- Place non-visual elements (e.g., services, value objects) here -->
	</fx:Declarations>
	<!--
	<skinnablecomponents:DataVizSkinnableComponent id="skinLayer" 
												   skinClass="components.DataVizSkin"
												   targetName="{this.target.friendlyName}"
												   observationDate="{this.observation.date.toDateString()}"
												   observationFrequency="{this.observation.averageWavelength}" 
												   observationCoordinates="{this.target.coordinateString}"
												   targetDescription="{this.target.description}"
												   />
	-->
	
	<s:Group width="100%" height="100%">
		<s:layout>
			<s:VerticalLayout horizontalAlign="center" verticalAlign.loading="middle" verticalAlign.exploring="top"/>
		</s:layout>

		
		<s:BusyIndicator includeIn="loading" />
		
		<components:VisualizationTileList id="visualizationTileList" top="41" width="100%" includeIn="exploring"/>
		<components:FrequencyMarker id="freqMarker" frequency="{visualizationTileList.midFrequency}" includeIn="exploring" />


	</s:Group>
	<fx:Script>
		<![CDATA[
*/

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
			trace("Updating to " + percentScrolled);
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
		
		private function onSkyButtonInteraction(event:Event):void
		{
			//this.visualizationTileList.waterfallContentCache.removeAllCacheEntries();
			//navigator.popView();
		}
		
		
		protected function skinLayer_creationCompleteHandler(event:FlexEvent):void
		{
			//this.skinLayer.starNameText.text = observation.target.friendlyName;
		}
		
		
		protected function view1_creationCompleteHandler(event:FlexEvent):void
		{
			//this.skinLayer.controlBar.starfieldButton.addEventListener(MouseEvent.CLICK, this.onSkyButtonInteraction);
		}

		/**
		override public function set data(value:Object):void
		{
			if (value is Target)
			{
				target = value as Target;
				*/
		/**
		public function set target(target:Target):void {
			var request:ObservationRequest = new ObservationRequest();
			request.addEventListener(Event.COMPLETE, onObservationLoadComplete);
			this.observation = target.defaultObservation;
			request.observation = target.defaultObservation;
			request.execute();
			
			}
			super.data = value;
			
		}
		 */
		//public function showObservationRange():void {
		/**
		private function onObservationLoadComplete(event:Event):void {
			//currentState = "exploring";
			
			event.currentTarget.removeEventListener(event.type, onObservationLoadComplete);
			
			var request:ObservationRequest = event.target as ObservationRequest;
			
			*/
			//this.visualizationTileList.dataProvider = this._model.currentAssignment.observationRange.filenameCollection;
		//}
			
	}
}
/**
		]]>
	</fx:Script>

</s:View>
*/