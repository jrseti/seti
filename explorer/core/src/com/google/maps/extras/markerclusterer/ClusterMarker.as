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
import com.google.maps.MapEvent;
import com.google.maps.interfaces.IMap;
import com.google.maps.interfaces.IPane;
import com.google.maps.interfaces.IPaneManager;
import com.google.maps.overlays.OverlayBase;

import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.geom.Point;
import flash.net.URLRequest;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;


/**
 * 
 * This is a presentation class for <code>Cluster</code>.
 * The current implementation is to load images for different level.
 * Later, it can be implemented with other possibilities.
 * 
 * 
 * Update: 
 * 	2010-02-11
 * 		Now it works with Flash, that means it also works for Flex.
 * 	2010-02-13
 * 		Make it formal as overlay .e.g. create and destroy content as needed - 
 * 			through MapEvent.OVERLAY_ADDED, and MapEvent.OVERLAY_REMOVED events.
 */  
internal class ClusterMarker extends OverlayBase
{
	private var _latlng 	: LatLng;
	private var _count		: int;
	private var _styles 	: Array;
//	private var text_ 		: String;
//	private var padding_	: Number;

	
//	private var imageLoader	: Image;
//	private var label		: Label;
	
	public function ClusterMarker (latlng : LatLng, count:int , styles : Array, padding : Number)
	{
		_latlng	= latlng;
		_styles = styles;
		_count 	= count;
		
		this.addEventListener(MapEvent.OVERLAY_ADDED, onOverlayAdded);
		this.addEventListener(MapEvent.OVERLAY_REMOVED, onOverlayRemoved);
		
	}
	
	private var _ld:Loader;
	private var _tf:TextField;
	
	private function onOverlayAdded(event:MapEvent):void{
		var index 	: int = 0;
		var dv		: int = _count;

		while (dv != 0) {
			dv = dv / 10;
			index ++;
		}
		
		if (_styles.length < index) {
			index = _styles.length;
  		}
		
		var url_ :String		= _styles[index - 1].url;
//		textColor_ 						= styles[index - 1].opt_textColor;
//		anchor_ 						= styles[index - 1].opt_anchor;

		var text_:String 		= String(_count);
//		padding_ 						= padding;
/* 		
		imageLoader						= new Image();
		imageLoader.autoLoad            = true;
		imageLoader.source 				= url_; 
		imageLoader.scaleContent 		= false;
		imageLoader.addEventListener(Event.COMPLETE, completeHandler);
		addChild(imageLoader);
		 */
		var req:URLRequest = new URLRequest(url_);
		_ld = new Loader;
		_ld.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
		_ld.load(req);
		
		this.addChild(_ld);
		
		
/* 	
@20100211
Previous code, for Flex only!	
		label							= new Label();
		label.setStyle("textAlign", "center");
		label.setStyle("color", "0x00FF00");
		label.setStyle("font", "Verdana");
		label.setStyle("bold", "true");
		label.selectable                = false;
		label.text 						= text_;
		
		addChild(label);
 */
		var format :TextFormat = new TextFormat;
		format.align = TextFormatAlign.CENTER;
		format.color = 0xFFFFFF;
		format.font = 'Verdana';
		format.bold = true;
		
		this._tf = new TextField;
		_tf.selectable = false;
		_tf.text = text_;
		_tf.setTextFormat(format);
		
		this.addChild(_tf);
	}
	
	private function onOverlayRemoved(event:MapEvent):void{
		this.removeChild(_ld);
		_ld = null;
		
		this.removeChild(_tf);
		_tf = null;
		
	}
	
	private function completeHandler(event : Event) : void
	{		
	//	imageLoader.width = event.currentTarget.content.width;
	//	imageLoader.height = event.currentTarget.content.height;	
		var content:Bitmap = event.currentTarget.content;
		_ld.width = content.width;
		_ld.height = content.height;	
	
	//	event.currentTarget.move(imageLoader.width/-2, imageLoader.height/-2);
		_ld.x = _ld.width / -2;
		_ld.y = _ld.height / -2;
		
	/* 	label.width 	= imageLoader.width;
		label.height 	= 14;
		label.x         = imageLoader.width / -2;
		label.y 		= 0 - (label.height / 2);
		label.visible 	= true; */
		this._tf.width = _ld.width;
		this._tf.height = 16;
		this._tf.x = - _ld.width / 2;
		this._tf.y = 0 - (_tf.height/2);
		
	}
	
	override public function getDefaultPane(map : IMap): IPane
	{
		var paneManager	: IPaneManager = map.getPaneManager();

//		return paneManager.getPaneById(PaneId.PANE_MARKER);
		
		return null;
	}
	
	override public function positionOverlay(zoomChanged : Boolean): void
	{
		this.reposition();
	}
	
/* 	private function remove () : void
	{
		parent.removeChild(this);
	} */
	/*
	private function copy () : ClusterMarker
	{
		return new ClusterMarker(this.latlng_, this.index_, this.styles_, this.padding_);
	}
	*/
	/**
	 * 
	 * Developer should not call this function. 
	 * It is managed by Cluster.
	 */ 
	internal function redraw (force:Boolean) : void
	{
		if (!force){
			return;
		}

		this.reposition();
	}
	
	private function reposition():void{
		var pos : Point = this.pane.fromLatLngToPaneCoords(_latlng);
		x = pos.x;
		y = pos.y;
	}
}
}