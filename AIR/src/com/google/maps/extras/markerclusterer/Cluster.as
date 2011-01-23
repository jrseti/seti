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
import com.google.maps.overlays.Marker;

import flash.geom.Point;
import flash.geom.Rectangle;
/**
 * class Cluster is a structure to manage markers which fall into a single cluster.
 * 
 */ 
internal class Cluster
{
	private var center_				: LatLng;
	private var markers_			: Array;
	private var markerClusterer_	: MarkerClusterer;
//	private var map_				: IMap;
	private var clusterMarker_		: ClusterMarker;
	private var zoom_				: Number;
	private var _pane:IPane ;
	
	/**
	 * class Cluster is a structure to manage markers which fall into this cluster.
	 * 
	 */ 
	public function Cluster (markerClusterer : MarkerClusterer, pane:IPane)
	{
		center_ 			= null;
		markers_ 			= new Array();
		markerClusterer_ 	= markerClusterer;
//		map_ 				= markerClusterer.map;
		clusterMarker_ 		= null;
		zoom_ 				= markerClusterer_.zoom; // map_.getZoom();
		this._pane = pane;
	}
	/**
	 * @return an array of UnitMarker instance.
	 */ 
	public function getMarkers () : Array
	{
		return markers_;
	}
	/**
	 * Check whether the cluster is in the rectangle in pixels
	 */
	public function isInRectangle(bounds:Rectangle= null):Boolean{
		if(bounds == null){
			bounds = this._pane.getViewportBounds();
		}
		var centerxy:Point = this._pane.fromLatLngToPaneCoords(center_);
		
		var gridSize:Number = markerClusterer_.gridSize;
		if (zoom_ != _pane.map.getZoom()) //  map_.getZoom())
		{
			var dl:Number 	= this.markerClusterer_.zoom - zoom_;
			gridSize 	= Math.pow(2, dl) * gridSize;
		}
		if(centerxy.x + gridSize < bounds.left || centerxy.x - gridSize > bounds.right){
			return false;
		} 
		if(centerxy.y + gridSize < bounds.top || centerxy.y - gridSize > bounds.bottom){
			return false;
		}
		return true;
	}
	/**
	 * Check whether this cluster is in bounds in LatLngBounds
	 * 
	 * This method is considered to be replaced with isInRectangle. 
	 * So you may not see it in the later version.
	 */
/* 
	public function isInBounds (bounds : LatLngBounds = undefined) : Boolean
	{
		if (center_ == null)			{
			return false;
		}
	
		if (!bounds)			{
			bounds = map_.getLatLngBounds();
		}
	
		var  sw 			: Point = map_.fromLatLngToViewport(bounds.getSouthWest());
		var  ne 			: Point	= map_.fromLatLngToViewport(bounds.getNorthEast());
		var  centerxy 		: Point	= map_.fromLatLngToViewport(center_);
		var  inViewport 	:Boolean 	= true;
		var  gridSize 		: Number	= markerClusterer_.gridSize;
	
		if (zoom_ != map_.getZoom())
		{
			var  dl	: Number = map_.getZoom() - zoom_;
			gridSize 	= Math.pow(2, dl) * gridSize;
		}
		
		if (ne.x != sw.x && (centerxy.x + gridSize < sw.x || centerxy.x - gridSize > ne.x))
		{
			inViewport = false;
		}
		
		if (inViewport && (centerxy.y + gridSize < ne.y || centerxy.y - gridSize > sw.y))
		{
			inViewport = false;
		}
		
		return inViewport;
	}
	 */
	 /* used in MarkerClusterer addMarker */
	public function getCenter () : LatLng
	{
		return center_;
	}
	
	public function addMarker (marker : UnitMarker) : void
	{
		if (center_ == null)
		{
			center_ = marker.getLatLng();
		}
		
		markers_.push(marker);
	}
	
/* 	private function removeMarker (marker : Marker) : Boolean
	{

		for (var i:int = 0; i < markers_.length; ++i)
		{
			if (marker == markers_[i].marker)
			{
				if (markers_[i].isAdded)
				{
					this._pane.removeOverlay(markers_[i].marker);
				//	map_.removeOverlay(markers_[i].marker);
				}
				markers_.splice(i, 1);
				
				return true;
			}
		}
		return false;
	} */
	
	public function getCurrentZoom () : Number
	{
		return zoom_;
	}
	/**
	 * This function causes to redraw the cluster.
	 * Currently, there are three (3) places to call this function:
	 * - 2 places in MarkerClusterer.addMarker
	 * - 1 place in MarkerClusterer.redraw
	 * 
	 * @param isForced - current not in used
	 */
	public function redraw (isForce : Boolean) : void
	{

		if (!isForce && ! this.isInRectangle()
		//this.isInBounds()
		) {
			return;
		}
		
		// Set cluster zoom level.
		zoom_ = this.markerClusterer_.zoom; //  map_.getZoom();
	
		var mz 	: Number = markerClusterer_.maxZoom;
		
		if (isNaN(mz)) {
			mz = this.markerClusterer_.maximumResolution; // map_.getCurrentMapType().getMaximumResolution(); 
		}
		var marker:UnitMarker;
		if (zoom_ >= mz || this.getTotalMarkers() == 1)
		{
			// If current zoom level is beyond the max zoom level or the cluster
 			// have only one marker, the marker(s) in cluster will be showed on map.
			for each(marker in markers_)
			{
				if (marker.isAdded)
				{
					if(!marker.visible )  marker.visible = true;
				}
				else
				{
					this._pane.addOverlay(marker);
				//	map_.addOverlay(markers_[i]);
					marker.isAdded = true;
				}
			}
			
			if (clusterMarker_ != null)
			{
			// was:	clusterMarker_.hide();
				clusterMarker_.visible = false;
			}
		}
		else
		{
			// Else add a cluster marker on map to show the number of markers in
 			// this cluster.

			for each(marker in markers_)
			{
				if (marker.isAdded && marker.visible)
				{
					marker.visible = false;
				}
			}
			
			if (clusterMarker_ == null)
			{
				clusterMarker_ = new ClusterMarker(center_, this.getTotalMarkers(), 
					markerClusterer_.getStyles(), markerClusterer_.gridSize);
		//		clusterMarker_.initialise(map_);
		//		map_.addOverlay(clusterMarker_);
				this._pane.addOverlay(clusterMarker_);
			}
			else
			{
			/* was :	
				if (clusterMarker_.isHidden())
				{
					clusterMarker_.show();
				}
			*/	
				if(!clusterMarker_.visible) 
					clusterMarker_.visible = true;
				clusterMarker_.redraw(true);
			}
			
		}
	}
	
	public function clearMarkers () : void
	{
		if (clusterMarker_ != null){
			this._pane.removeOverlay(clusterMarker_);
			clusterMarker_ = null;
		//	map_.removeOverlay(clusterMarker_);
		}
		
		for (var i:int = 0; i < markers_.length; ++i) {
			if (markers_[i].isAdded){
				markers_[i].isAdded = false;
			// was:	map_.removeOverlay(markers_[i]);
				this._pane.removeOverlay(markers_[i]);
			}
		}
		
		markers_ = new Array();
	}
	
 	internal function getTotalMarkers () : int{
		return markers_.length;
	}
}
}
