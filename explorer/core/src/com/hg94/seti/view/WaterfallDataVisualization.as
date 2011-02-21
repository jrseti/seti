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

	import com.hg94.seti.controller.ObservationRequest;
	import com.hg94.seti.model.Observation;
	import com.hg94.seti.model.Target;
	
	import components.DataVizTileListPlaceholder;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;

	public class WaterfallDataVisualization {
/*
		[Bindable]
		internal var target:Target;
*/		
		[Bindable]
		internal var observation:Observation;
		
		[Bindable]
		protected var observationImages:ArrayCollection;
		
		[Bindable]
		protected var _midFrequency:String;
		
		public var visualizationTileList:VisualizationTileList;
		
		public function WaterfallDataVisualization(dataVizTileListPlaceholder:DataVizTileListPlaceholder) {
			this.visualizationTileList = new VisualizationTileList();
			dataVizTileListPlaceholder.addElement(this.visualizationTileList);
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
		
		public function set target(target:Target):void {
			var request:ObservationRequest = new ObservationRequest();
			request.addEventListener(Event.COMPLETE, onObservationLoadComplete);
			this.observation = target.defaultObservation;
			request.observation = target.defaultObservation;
			request.execute();
			/*
			}
			super.data = value;
			*/
		}
		
		private function onObservationLoadComplete(event:Event):void {
			//currentState = "exploring";
			
			event.currentTarget.removeEventListener(event.type, onObservationLoadComplete);
			
			var request:ObservationRequest = event.target as ObservationRequest;
			
			this.visualizationTileList.dataProvider = new ArrayCollection(request.imageUrls);
			
		}
	}
}
/**
		]]>
	</fx:Script>

</s:View>
*/