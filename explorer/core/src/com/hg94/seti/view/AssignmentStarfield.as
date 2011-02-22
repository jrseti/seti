/**
	<?xml version="1.0" encoding="utf-8"?>
<s:View xmlns:fx="http://ns.adobe.com/mxml/2009" 
		xmlns:s="library://ns.adobe.com/flex/spark"
		xmlns:components="components.*"
		title="Stars" 
		actionBarVisible="false"
		creationComplete="view1_creationCompleteHandler(event)" xmlns:skinnablecomponents="com.hg94.seti.skinnablecomponents.*">
	<s:states>
	</s:states>
	<fx:Script>
		<![CDATA[
		 */

package com.hg94.seti.view {

	import com.google.maps.LatLng;
	import com.google.maps.Map3D;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.extras.planetary.Sky;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.styles.FillStyle;
	import com.hg94.seti.controller.TargetListRequest;
	import com.hg94.seti.model.Observation;
	import com.hg94.seti.model.Target;
	import com.hg94.seti.model.TargetSet;
	
	import components.AssignmentStarfieldPlaceholder;
	import components.StarfieldTargetMarkerSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.events.FlexEvent;
	
	public class AssignmentStarfield {
			
		//private static const HATHERSAGE_MAP_API_KEY:String = "ABQIAAAAEwk3rg5igZgbfHAAaPpdnhS3hwEVAxBLwgX-yCFBjg8qlFo5UxTVUCdE50GpyF9WvX4b62ZJcx0ASA";
		private static const HATHERSAGE_MAP_API_KEY:String = "ABQIAAAAvfCXHyG3_fr2KItfFudhNhRu45k_GoSHRmy8AvsVANhoXVrYpRRD4K1belmVZubunzBgbbEjN4EtwQ";
		
		protected var _targetSet:TargetSet;
		protected var _targetArray:Array = [];

		
		private var map:Map3D;
		
		public var target:Target;
		
		public function AssignmentStarfield(placeholder:AssignmentStarfieldPlaceholder) {
			//this.starfieldSkin.zoomInButton.addEventListener(MouseEvent.CLICK, this.zoomInButton_clickHandler);
			//this.starfieldSkin.zoomOutButton.addEventListener(MouseEvent.CLICK, this.zoomOutButton_clickHandler);
			
			map = new Map3D();
			map.key=HATHERSAGE_MAP_API_KEY;
			map.url="http://seti.hg94.com"
			map.sensor="false"
			map.percentWidth=100;
			map.percentHeight=100;
			map.addEventListener(MapEvent.MAP_PREINITIALIZE,onMapPreinitialize);
			map.addEventListener(MapEvent.MAP_READY,onMapReady);
			
			placeholder.addElement(map);
		}

		protected function loadTargetList():void 
		{
			var targetRequest:TargetListRequest = new TargetListRequest();
			targetRequest.addEventListener(Event.COMPLETE, onTargetLoadComplete);
			targetRequest.execute();
		}
		
		private function onTargetLoadComplete(event:Event):void 
		{
			event.currentTarget.removeEventListener(event.type, onTargetLoadComplete);
			_targetSet = (event.currentTarget as TargetListRequest).targetSet;
			
			for each (var target:Target in this._targetSet.targetArray) {
				_targetArray.push(target.getGoogleSkyCoordinates());
				if (false)
				{
					addMarkerForTarget( target );
				}
			}
			
			goToAssignment();
		}
		
		private function addMarkerForTarget(target:Target):void
		{
			var marker:Marker = new Marker(target.getGoogleSkyCoordinates());
			marker.addEventListener(MapMouseEvent.CLICK, onMarkerInteraction);
			var markerOptions:MarkerOptions = marker.getOptions();
			markerOptions.icon = new StarfieldTargetMarkerSkin();
			markerOptions.iconOffset = new Point(-8,-8); 
			marker.setOptions(markerOptions);
			map.addOverlay(marker);
		}
		
		private function onMapPreinitialize(event:Event):void 
		{
			var opts:MapOptions = new MapOptions();
			opts.mapTypes = [Sky.VISIBLE_MAP_TYPE];
			opts.zoom = 2;
			opts.backgroundFillStyle = new FillStyle();
			opts.backgroundFillStyle.color = 0x000000;
			event.target.setInitOptions(opts);
		}
		
		private function onMapReady(event:MapEvent):void
		{
			loadTargetList();
		}
		
		private function goToAssignment():void
		{
			var assignmetIndex:int = int(Math.round((Math.random() * _targetSet.targetArray.length)));
			var assignment:Target = _targetSet.targetArray.getItemAt( assignmetIndex ) as Target;
			this.target = assignment;
			trace("Assigning " + target.friendlyName);
			addMarkerForTarget( assignment );
			map.flyTo(assignment.getGoogleSkyCoordinates(), map.getZoom() + 3, map.getAttitude(), 3);
		}
		
		private function onMarkerInteraction(event:MapMouseEvent):void
		{
			var currentLatLng:LatLng = event.latLng;
			var currentPoint:Point = map.fromLatLngToPoint(event.latLng);
			this.target = this._targetSet.getTargetByGoogleSkyCoordinates(currentLatLng);
			//navigator.pushView(com.hg94.seti.views.WaterfallExplorerView, this.target);
		}
		
		[Bindable (event="click")]
		private function get rightAscension():String 
		{
			return this.target.rightAscension.toString();
		}
		
		[Bindable (event="click")]
		private function get declination():String 
		{
			return this.target.declination.toString();
		}
		
		[Bindable (event="click")]
		private function get friendlyName():String
		{
			return this.target.friendlyName;
		}
		
		protected function get maxZoomLevel():Number
		{
			return map.getMaxZoomLevel();
		}

		protected function zoomInButton_clickHandler(event:MouseEvent):void
		{
			if (map.getZoom() < maxZoomLevel){
				this.map.zoomIn();
			}
		}
		
		protected function zoomOutButton_clickHandler(event:MouseEvent):void
		{
			if (map.getZoom() > map.getMinZoomLevel()){
				this.map.zoomOut();
			}
		}
	}
}
/**			
		]]>
	</fx:Script>
	<fx:Declarations>
		<!-- Place non-visual elements (e.g., services, value objects) here -->
	</fx:Declarations>
	<s:Group width="100%" height="100%">
		<s:Group id="mapGroup" width="100%" height="100%"/>
		<!--<components:StarfieldSkin id="starfieldSkin"/>-->
	</s:Group>
</s:View>
*/