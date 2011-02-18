/**
 * @name MarkerClusterer for Flash
 * @version 1.0
 * @author Xiaoxi Wu
 * @copyright (c) 2009 Xiaoxi Wu
 * @fileoverview
 * Ported from Javascript to Actionscript 3 by Sean Toru
 * Ported for use in Flex (removal of fl. libraries) by Ian Watkins
 * Reflectored for both Flash and Flex, 
 * and maintained by Juguang XIAO (juguang@gmail.com)
 * 
 * This actionscript library creates and manages per-zoom-level 
 * clusters for large amounts of markers (hundreds or thousands).
 * This library was inspired by the <a href="http://www.maptimize.com">
 * Maptimize</a> hosted clustering solution.
 * <br /><br/>
 * <b>How it works</b>:<br/>
 * The <code>MarkerClusterer</code> will group markers into clusters according to
 * their distance from a cluster's center. When a marker is added,
 * the marker cluster will find a position in all the clusters, and 
 * if it fails to find one, it will create a new cluster with the marker.
 * The number of markers in a cluster will be displayed
 * on the cluster marker. When the map viewport changes,
 * <code>MarkerClusterer</code> will destroy the clusters in the viewport 
 * and regroup them into new clusters.
 *
 */


/*
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.google.maps.extras.markerclusterer
{
import com.google.maps.LatLng;
import com.google.maps.LatLngBounds;
import com.google.maps.interfaces.IMap;
import com.google.maps.interfaces.IPane;

import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;

/**
 * This class is the entry to MarkerClusterer package, and the only class you as a developer should touch.
 * 
 * 
 * 
 */ 
public class MarkerClusterer
{
	private var _markers		: Array;
	private  var clusters_ 		: Array;
	private  var map_ 			: IMap;

	private  var leftMarkers_ 	: Array;
	private var _pane:IPane;
	public var options:MarkerClustererOptions;
	/**
	 * 
	 * @param pane.
	 * 
	 * @param markers An array of UnitMarker. 
	 * 
	 * @param options of MarkerClustererOptions
	 * 
	 */ 
	public function MarkerClusterer (pane: IPane, markers : Array, opts : MarkerClustererOptions = null)
	{
		_markers		= new Array();
		clusters_ 		= new Array();
		map_ 			= pane.map;
		leftMarkers_ 	= new Array();
		this._pane = pane; ///  map_.getPaneManager().createPane();
		
		if(opts == null)		opts = new MarkerClustererOptions;
		this.options = opts;

		
		if(options.styles.length == 0){
			var styles:Array		= new Array();
			for (var i:int = 1; i <= 5; ++i)
			{
				styles.push({'url': "assets/images/m" + i + ".png"});
			}
			options.styles = styles;
		}

		if (markers != null){
			addMarkers(markers);
		}
		
		map_.addEventListener("mapevent_moveend", mapMoved);
	}
	
	private function mapMoved (event : Event) :void
	{
		resetViewport();
	}
	
	private function addLeftMarkers () : void
	{
		var leftMarkers : Array = [];
		
		if (leftMarkers_.length < 1) {
			return;
		}
		
		for (var i:int = 0; i < leftMarkers_.length; ++i) {
			addMarker(leftMarkers_[i], true, false, null, true);
		}
		
		leftMarkers_ = leftMarkers;
	}
	
	public function getStyles () : Array
	{
		return this.options.styles; // (styles_);
	}
	
	public function clearMarkers () : void 
	{
		for each(var cluster:Cluster in listCluster()){
			cluster.clearMarkers();
		}	
	/* 
		for (var i:int = 0; i < clusters_.length; ++i)	{
			if (clusters_[i] != undefined && clusters_[i] != null)
			{
				clusters_[i].clearMarkers();
			}
		}
		 */
		clusters_ 		= new Array();;
		leftMarkers_ 	= new Array();
	}
	
	private function isMarkerInViewport_(marker : UnitMarker) : Boolean 
	{
		return map_.getLatLngBounds().containsLatLng(marker.getLatLng());
	}
	
	private function reAddMarkers_(markers : Array) : void
	{
	//	var len:int 		= markers.length;
		var clusters :Array	= new Array();
		var i:int = 0;
	//	for (var i:int = len - 1; i >= 0; --i) {
		for each(var marker:UnitMarker in markers){
			addMarker(marker, true, marker.isAdded, clusters, true);
			trace('...' + i);
			i++;
		}
		
		addLeftMarkers();
	}
	
	private function addMarker (marker : UnitMarker, 
		opt_isNodraw : Boolean,
		isAdded : Boolean, 
		clusters : Array, 
		opt_isNoCheck : Boolean) : void
	{
		this._markers.push(marker);
		
		if (opt_isNoCheck != true){
			if (!isMarkerInViewport_(marker)) {
				leftMarkers_.push(marker);
				return;
			}
		}
		var pos	: Point= map_.fromLatLngToViewport(marker.getLatLng());
		
		if (clusters == null){
			clusters = clusters_;
		}
		
//		length 		= clusters.length;
//		cluster 	= null;
		var centrePoint	: Point;
		var center		: LatLng;
		for each(var cluster:Cluster in clusters){
//		for (var i:int = length - 1; i >= 0; i--) {
//			cluster 	= clusters[i];
			center 		= cluster.getCenter();
			
			if (center == null)	
				continue;
		
			centrePoint = map_.fromLatLngToViewport(center);
			
			// Found a cluster which contains the marker.
			if (pos.x >= centrePoint.x - options.gridSize 
			&& pos.x <= centrePoint.x + options.gridSize 
			&& pos.y >= centrePoint.y - options.gridSize 
			&& pos.y <= centrePoint.y + options.gridSize){
				marker.isAdded = isAdded;
				cluster.addMarker(marker);
				
				if (!opt_isNodraw)
				{
					cluster.redraw(false);
				}
				
				return;
			}
		}
		
		// No cluster contain the marker, create a new cluster.
		var newCluster:Cluster 		= new Cluster(this, _pane);
		marker.isAdded 	= isAdded;
		newCluster.addMarker(marker);
		
		if (!opt_isNodraw)
		{
			cluster.redraw(false);
		}
		
		// Add this cluster both in clusters provided and clusters_
		clusters.push(newCluster);
		
		if (clusters != clusters_)
		{
			clusters_.push(newCluster);
		}
	}
	
/* 	private function removeMarker (marker : UnitMarker)  : void
	{
		
		for (var i:int = 0; i < clusters_.length; ++i)
		{
			if (clusters_[i].remove(marker))
			{
				clusters_[i].redraw_();
				return;
			}
		}
	} */
	
	private function redraw_ () : void
	{
		// @20100212
		
//		this._pane.clear();
		for each(var cluster:Cluster in listClusterInViewport_()){
			cluster.redraw(true);
		}
	}
	
	private function listCluster():Array{
		return this.clusters_;
	}
	private function listClusterInViewport_ () : Array
	{
		var clusters 	: Array = [];

		var curBounds:LatLngBounds 	= map_.getLatLngBounds();
		var nw:Point = map_.fromLatLngToViewport(curBounds.getNorthWest());
		var se:Point = map_.fromLatLngToViewport(curBounds.getSouthEast());
		var rect:Rectangle = new Rectangle(nw.x, nw.y, se.x - nw.x, se.y - nw.y);				
	
		//for (i = 0; i < clusters_.length; i ++)
		for each(var cluster:Cluster in this.listCluster()){
		//	if (cluster.isInBounds(curBounds))
		//	if((clusters_[i] as Cluster).isInRectangle(rect))
			if(cluster.isInRectangle(rect))
			{
				clusters.push(cluster);
			}
		}
		
		return clusters;
	
	}
	/**
	 * This getter property is intented for Cluster use
	 */
	internal function get maxZoom() : Number
	{
		return this.options.maxZoom;
	}
	/**
	 * This getter property is intented for Cluster use
	 */
	internal function get zoom():Number{
		return map_.getZoom();
	}
	/**
	 * This getter property is intented for Cluster use
	 */
	internal function get maximumResolution():Number{
		return map_.getCurrentMapType().getMaximumResolution(); 
	}
	// this will be removed!!
	// if cluster needs any info of map, this class should provide methods for it,
	// not to provide whole map object. 
/*  	internal function get map (): IMap
	{
		return map_;
	}  */
	/**
	 * This getter property is intented for Cluster use
	 */
	internal function get gridSize () : Number
	{
		return this.options.gridSize;
	}
	/* 
	private function getTotalMarkers () : int
	{
		var result 	: int = 0;
		for each(var cluster:Cluster in clusters_){
			result += cluster.getTotalMarkers();
		}
		return result;
	} */
	/* 
	private function getTotalClusters () : int
	{
		return clusters_.length;
	}
	 */
	public function resetViewport (force:Boolean=false) : void{
		// this new method will clear all markers, and then rebuild.
		var tmpMarkers:Array = this._markers.concat();
		this._pane.clear();
		
		this.clearMarkers();
		clusters_ = new Array;
		this._markers = new Array;
		this.reAddMarkers_(tmpMarkers);
	//	this.reAddMarkers_(this._markers);
		this.redraw_();
	}
	
	public function resetViewport0 (force:Boolean=false) : void {
		var clusters 	: Array = listClusterInViewport_();
		var tmpMarkers 	: Array = [];
		var removed 	: int = 0;

		for each(var cluster:Cluster in clusters)
		{
		//	cluster = clusters[i];
			var oldZoom		: Number = cluster.getCurrentZoom();
			if (isNaN(oldZoom))	continue;
			var curZoom 	: Number = map_.getZoom();
			
			if (curZoom != oldZoom || force)
			{
				
				// If the cluster zoom level changed then destroy the cluster
    			// and collect its markers.
    			for each(var mk:UnitMarker in cluster.getMarkers()){
					tmpMarkers.push(mk);
				}
				
				cluster.clearMarkers();
				removed++;
				
				for (var j:int = 0; j < clusters_.length; ++j){
					if (cluster == clusters_[j]){
						clusters_.splice(j, 1);
					}
				}
			} // for each previous cluster.
		}
		
		// I am not sure what is the difference 
		// between tmpMarkers and original markers in constructor.!!
		reAddMarkers_(tmpMarkers);
		redraw_();
	}
	
	public function addMarkers (markers : Array) : void
	{
		for each(var marker:UnitMarker in markers){
			this.addMarker(marker, true, false, new Array(), true);
		}
	//	redraw_();
		this.resetViewport();
	}
}
}