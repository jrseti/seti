package com.google.maps.extras.rubberbandctrl
{

import com.google.maps.LatLng;
import com.google.maps.LatLngBounds;
import com.google.maps.Map;
import com.google.maps.MapEvent;
import com.google.maps.MapMouseEvent;
import com.google.maps.MapMoveEvent;

import flash.display.Shape;
import flash.errors.IllegalOperationError;
import flash.events.KeyboardEvent;
import flash.geom.Point;
import flash.ui.Mouse;

/**
 * The RubberBandCtrl class works with <em>Google Maps API for Flash</em> to
 * provide a user with an efficient way to zoom in to a specific area on the
 * map. This class also offers convenient keyboard shortcuts (with support for
 * left and right-handed users) to rewind to previous map views, zoom out, as
 * well as pan in any of four directions.
 *
 * <p>
 * To zoom in to a specific area on the map, a user would normally click the
 * map and drag it to its desired center point, and then move the mouse to the
 * upper-left corner of the map to select the appropriate zoom level (a few
 * tries might be necessary to get the right fit). RubberBandCtrl provides
 * a more direct way to perform this task, as described below:
 * <ul>
 * <li>Hold a <em>Shift</em> key (the cursor changes to a cross).</li>
 * <li>Click and hold the left mouse button to anchor the rubber band to the map.</li>
 * <li>Drag the mouse to stretch the rubber band.</li>
 * <li>Release the mouse button to snap the map to the area enclosed by the
 * rubber band, or release the <em>Shift</em> key to cancel.</li>
 * </ul>
 * </p>
 *
 * <p>
 * The <em>Shift</em> key can also be used in conjunction with any of the keys
 * below to perform other kinds of map navigation:
 *
 * <table>
 * <tr><th>Left-hand<br/>Key</th><th>Right-hand<br/>Key</th><th>Action</th></tr>
 * <tr><td>?</td><td>Z</td><td>Zoom out one level</td></tr>
 * <tr><td>{</td><td>Q</td><td>Rewind to previous map view</td></tr>
 * <tr><td>:</td><td>A</td><td>Pan left</td></tr>
 * <tr><td>"</td><td>S</td><td>Pan right</td></tr>
 * <tr><td>L</td><td>D</td><td>Pan up</td></tr>
 * <tr><td>&gt;</td><td>X</td><td>Pan down</td></tr>
 * </table>
 * </p>
 *
 * <p>
 * <strong>Notes:</strong>&#xA0;
 * <ul>
 * <li>RubberBandCtrl is active only when the map has keyboard focus, which might require the user to first click the map.</li>
 * <li>Adobe Flash security policy disables RubberBandCtrl when the map is in full-screen mode.</li>
 * </ul>
 * </p>
 *
 * <p>
 * <strong>Contacts:</strong>
 * <ul>
 * <li>To contact the author of RubberBandCtrl, email kevin.macdonald AT thinkwrap DOT com</li>
 * <li>Visit <code>http://www.spatialdatabox.com</code> for other Google Flash Map demos and related information.</li>
 * <li>For updates to RubberBandCtrl, please visit <code>http://code.google.com/p/gmaps-utility-library-flash</code></li>
 * </ul>
 * </p>
 *
 * <p>
 * <strong>Copyright Notice:</strong><br>
 * <br>
 * Copyright 2009 Kevin Macdonald<br>
 * <br>
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at<br>
 * <br>
 *     http://www.apache.org/licenses/LICENSE-2.0<br>
 * <br>
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.<br>
 * </p>
 */
public class RubberBandCtrl
{

/**
 * Creates an empty rubber band control object, which must be assigned to a Google Map via <code>enable ()</code>.
 * 
 * @example The following example shows how to assign a Google Map object to a RubberBandCtrl object:
 * <listing version="3.0">
 *         :
 *     map.addEventListener (MapEvent.MAP_READY, onMapReady);
 *         :
 * 
 * public function onMapReady (event:MapEvent):void
 * {
 *     rbCtrl = new RubberBandCtrl ();
 *     rbCtrl.enable (map);
 * }
 * 
 * const map:Map = new Map ();
 * var   rbCtrl:RubberBandCtrl = null;
 * </listing>
 */
public function RubberBandCtrl ():void
{
}

/**
 * Call this method once, ideally within the MapEvent.MAP_READY handler, to add
 * RubberBandCtrl functionality to a Google Map.
 *
 * @param googleMap The map to receive RubberBandCtrl functionality.
 */
public function enable (googleMap:Map):void
{
	if (googleMap == null) {
		throw new ArgumentError ("Map parameter is null. (Hint: create Map object first, then call enable ().");
	}
	if (map != null) {
		throw new IllegalOperationError ("RubberBandCtrl is already enabled.");
	}

	map = googleMap;
	crosshairCursor = new CrosshairCursor (map);

	setRightHandedKeyCodes ();
	addEventHandlers ();
	initRubberBandOverlay ();
	initZoomHistory ();
	
	//	Map has a positional state to save, only if it has been loaded.
	if (map.isLoaded ()) {
		pushMapStateToHistory ();
	}
}

/**
 * Remove RubberBandCtrl functionality from a Google Map.
 */
public function disable ():void
{
	if (map == null) {
		throw new IllegalOperationError ("There is no map to be disabled. (Hint: did you call enable () first?)");
	}

	removeEventHandlers ();
	disableRubberBandOverlay ();
	initZoomHistory ();

	crosshairCursor = null;
	map = null;
}

/**
 * Set key codes for right handed users, who operate the mouse with the right
 * hand, and keyboard with the left.
 */
public function setRightHandedKeyCodes ():void
{
	zoomCharCode		= 'Z'.charCodeAt (0);
	rewindViewCharCode	= 'Q'.charCodeAt (0);
	panLeftCharCode 	= 'A'.charCodeAt (0);
	panRightCharCode	= 'S'.charCodeAt (0);
	panUpCharCode		= 'D'.charCodeAt (0);
	panDownCharCode		= 'X'.charCodeAt (0);
}

/**
 * Set key codes for left handed users, who operate the mouse with the left
 * hand, and keyboard with the right.
 */
public function setLeftHandedKeyCodes ():void
{
	zoomCharCode		= '?'.charCodeAt (0);
	rewindViewCharCode	= '{'.charCodeAt (0);
	panLeftCharCode 	= ':'.charCodeAt (0);
	panRightCharCode	= '"'.charCodeAt (0);
	panUpCharCode		= 'L'.charCodeAt (0);
	panDownCharCode		= '>'.charCodeAt (0);
}		

/**
 * Change the color of the rubber band.
 *
 * @param rgb A hexadecimal color value of the rubber band; for example, red is 0xFF0000, green is 0x00FF00 and blue is 0x0000FF.
 */
public function setRubberBandColor (rgb:uint):void
{
	rubberBandColor = rgb;
}

/**
 * Set the thickness, in pixels, of the rubber band.
 *
 * @param pixels The thickness of the rubber band, in pixels.
 */
public function setRubberBandThickness (pixels:int):void
{
	if (pixels < 1 || pixels > 50) {
		throw new ArgumentError ("Invalid rubber band thickness: " + pixels);
	}

	rubberBandThicknessPx = pixels;
}

/**
 * Set the size, in pixels, for a keyboard initiated pan of the map.
 *
 * @param pixels The number of pixels to pan vertically or horizontally, when the user performs a pan action. Setting this value to 0 disables panning.
 */
public function setPanIncrement (pixels:int):void
{
	if (pixels < 0) {
		throw new ArgumentError ("Pan increment must be 0 or greater: " + pixels);
	}
	panIncrementPx = pixels;
}

private function addEventHandlers ():void
{
	map.stage.addEventListener (KeyboardEvent.KEY_DOWN, keyDownHandler);
	map.stage.addEventListener (KeyboardEvent.KEY_UP, keyUpHandler);
	map.addEventListener (MapMouseEvent.MOUSE_DOWN, mouseDownHandler);
	map.addEventListener (MapMouseEvent.MOUSE_UP, mouseUpHandler);
	map.addEventListener (MapMouseEvent.MOUSE_MOVE, mapMouseMoveHandler);
	map.addEventListener (MapMouseEvent.ROLL_OUT, rollOutHandler);
	map.addEventListener (MapMoveEvent.MOVE_END, moveEndHandler);
}

private function initRubberBandOverlay ():void
{
	rubberband.x = 0;
	rubberband.y = 0;
	rubberband.visible = false;
	map.addChild (rubberband);
}

private function removeEventHandlers ():void
{
	map.stage.removeEventListener (KeyboardEvent.KEY_DOWN, keyDownHandler);
	map.stage.removeEventListener (KeyboardEvent.KEY_UP, keyUpHandler);
	map.removeEventListener (MapMouseEvent.MOUSE_DOWN, mouseDownHandler);
	map.removeEventListener (MapMouseEvent.MOUSE_UP, mouseUpHandler);
	map.removeEventListener (MapMouseEvent.MOUSE_MOVE, mapMouseMoveHandler);
	map.removeEventListener (MapMouseEvent.ROLL_OUT, rollOutHandler);
	map.removeEventListener (MapMoveEvent.MOVE_END, moveEndHandler);
}

private function disableRubberBandOverlay ():void
{
	map.stage.removeChild (rubberband);
}

//	EVENT HANDLERS

private function keyDownHandler (event:KeyboardEvent):void
{
	if (event.shiftKey && ! prevShiftKeyDown) {
		//	On Windows, holding down the Shift or character keys will generate
		//	a continous stream of KEY_DOWN events. Must act on only first
		//	occurrence of such event.
		doShiftDown ();
	}

	if (event.charCode != 0) {
		doKeyDown (event.charCode);
	}

	prevShiftKeyDown = event.shiftKey;
}

private function keyUpHandler (event:KeyboardEvent):void
{
	if (! event.shiftKey && prevShiftKeyDown) {
		doShiftUp ();
	}

	prevShiftKeyDown = event.shiftKey;
}

private function mouseDownHandler (event:MapMouseEvent):void
{
	doMouseDown ();
}

private function mouseUpHandler (event:MapMouseEvent):void
{
	cursorPos = map.fromLatLngToViewport (event.latLng);

	doMouseUp ();
}

private function mapMouseMoveHandler (event:MapMouseEvent):void
{
	cursorPos = map.fromLatLngToViewport (event.latLng);

	doMouseMove ();
}

private function moveEndHandler (mapEvent:MapEvent):void
{
	pushMapStateToHistory ();
}

private function rollOutHandler (event:MapMouseEvent):void
{
	cursorPos = null;
	showStandardCursor ();
}

//	STATE TRANSITIONS

private function doShiftDown ():void
{
	switch (state) {
	case ST_IDLE:
		if (! mouseDown && cursorPos != null) {
			state = ST_WATCH;
			showCrosshairCursor ();
		}
		break;
	case ST_WATCH:
		break;
	case ST_DRAW:
		break;
	default:
		throw new IllegalOperationError ("Unknown state=" + state);
	}
}

private function doShiftUp ():void
{
	switch (state) {
	case ST_IDLE:
		//	Happens if user had clicked mouse, pressed shift (which doesn't
		//	cause a transition to ST_WATCH) then released shift.
		break;
	case ST_WATCH:
		cancelDraw ();
		state = ST_IDLE;
		break;
	case ST_DRAW:
		cancelDraw ();
		state = ST_IDLE;
		break;
	default:
		throw new IllegalOperationError ("Unknown state=" + state);
	}
}

private function doKeyDown (key:uint):void
{
	switch (state) {
	case ST_IDLE:
		break;
	case ST_WATCH:
		processKeyAction (key);
		break;
	case ST_DRAW:
		break;
	default:
		throw new IllegalOperationError ("Unknown state=" + state);
	}
}

private function doMouseDown ():void
{
	mouseDown = true;

	switch (state) {
	case ST_IDLE:
		break;
	case ST_WATCH:
		//	Anchor rubber band
		map.disableDragging ();
		rubberBandStartPt = cursorPos;
		rubberband.graphics.clear ();
		rubberband.visible = true;
		state = ST_DRAW;
		break;
	case ST_DRAW:
		throw new IllegalOperationError ("Invalid state");	
		break;
	default:
		throw new IllegalOperationError ("Unknown state=" + state);
	}
}

private function doMouseUp ():void
{
	mouseDown = false;

	switch (state) {
	case ST_IDLE:
		break;
	case ST_WATCH:
		break;
	case ST_DRAW:
		panAndZoom ();
		cancelDraw ();
		state = ST_WATCH;
		break;
	default:
		throw new IllegalOperationError ("Unknown state=" + state);
	}
}

private function doMouseMove ():void
{
	switch (state) {
	case ST_IDLE:
		break;
	case ST_WATCH:
		drawRubberBandCursor ();
		break;
	case ST_DRAW:
		drawRubberBandCursor ();
		drawRubberBand ();
		break;
	default:
		throw new IllegalOperationError ("Unknown state=" + state);
	}
}


//	SUPPORTING FUNCTIONS FOR KEY & MOUSE EVENTS

private function drawRubberBandCursor ():void
{
	Mouse.hide ();
	crosshairCursor.show (cursorPos);
}

//	Draw a rectangle on the 'rubberband' overlay between 'rubberBandStartPt' and 'cursorPos'.

private function drawRubberBand ():void
{
	rubberband.graphics.clear ();
	rubberband.graphics.lineStyle (rubberBandThicknessPx, rubberBandColor);
	rubberband.graphics.moveTo (rubberBandStartPt.x, rubberBandStartPt.y);
	rubberband.graphics.lineTo (cursorPos.x, rubberBandStartPt.y);
	rubberband.graphics.lineTo (cursorPos.x, cursorPos.y);
	rubberband.graphics.lineTo (rubberBandStartPt.x, cursorPos.y);
	rubberband.graphics.lineTo (rubberBandStartPt.x, rubberBandStartPt.y);
}

private function cancelDraw ():void
{
	//	Restore standard map behavior
	showStandardCursor ();
	map.enableDragging ();

	//	Remove rubberband image over map.
	rubberband.visible = false;
	rubberBandStartPt = null;
}

private function showStandardCursor ():void
{
	crosshairCursor.hide ();
	Mouse.show ();
}

private function showCrosshairCursor ():void
{
	Mouse.hide ();
	if (cursorPos != null) {
		crosshairCursor.show (cursorPos);
	}
}

//	Take rectangle drawn, if any, and pan & zoom map such that the rectangle is
//	the map's new viewport.

private function panAndZoom ():void
{
	//	Ignore, if no rubber band exists.
	if (rubberBandStartPt == null) {
		return;
	}

	//	Get coordinates of viewport.
	const left:int				= Math.min (rubberBandStartPt.x, cursorPos.x);
	const right:int				= Math.max (rubberBandStartPt.x, cursorPos.x);
	const top:int				= Math.min (rubberBandStartPt.y, cursorPos.y);
	const bottom:int			= Math.max (rubberBandStartPt.y, cursorPos.y);

	if (left == right || top == bottom) {
		return;
	}

	//	Centerpoint of pan
	const centerPt:Point		= new Point ((left + right) / 2, (top + bottom) / 2);
	const centerLatLng:LatLng	= map.fromViewportToLatLng (centerPt);

	//	Zoom
	const swLatLng:LatLng		= map.fromViewportToLatLng (new Point (left, bottom));
	const neLatLng:LatLng		= map.fromViewportToLatLng (new Point (right, top));
	const bounds:LatLngBounds	= new LatLngBounds (swLatLng, neLatLng);
	const zoom:Number			= map.getBoundsZoomLevel (bounds);

	//	Perform pan & zoom
	map.setCenter (centerLatLng, zoom);
}

private function processKeyAction (charCode:uint):void
{
	const mapCenter:Point = map.fromLatLngToViewport (map.getCenter ());

	if (charCode == zoomCharCode) {
		map.setZoom (Math.max (0, map.getZoom () - 1));
	} else if (charCode == rewindViewCharCode) {
		popMapStateFromHistory ();
	} else if (charCode == panLeftCharCode) {
		map.setCenter (map.fromViewportToLatLng (new Point (Math.max (0, mapCenter.x - panIncrementPx), mapCenter.y)));	
	} else if (charCode == panRightCharCode) {
		map.setCenter (map.fromViewportToLatLng (new Point (mapCenter.x + panIncrementPx, mapCenter.y)));
	} else if (charCode == panUpCharCode) {
		map.setCenter (map.fromViewportToLatLng (new Point (mapCenter.x, Math.max (0, mapCenter.y - panIncrementPx))));
	} else if (charCode == panDownCharCode) {
		map.setCenter (map.fromViewportToLatLng (new Point (mapCenter.x, mapCenter.y + panIncrementPx)));
	}
}


//	MAP STATE HISTORY FUNCTIONS

private function initZoomHistory ():void
{
	for (var i:int = 0; i < zoomHistory.length; ++i) {
		zoomHistory[i] = INVALID_ZOOM;
	}
	ignoreMoveEndEvent = false;
	historyCurrentIndex = 0;
}

private function pushMapStateToHistory ():void
{
	if (ignoreMoveEndEvent) {
		ignoreMoveEndEvent = false;
		return;
	}

	historyCurrentIndex = (historyCurrentIndex + 1) % MAX_VIEWPORT_HISTORY;

	zoomHistory[historyCurrentIndex] = map.getZoom ();
	latLngHistory[historyCurrentIndex] = map.getCenter ();
}

//	Pop top entry in history arrays and apply to current state of 'map'.

private function popMapStateFromHistory ():void
{
	const prev:int = (historyCurrentIndex - 1) % MAX_VIEWPORT_HISTORY;

	if (zoomHistory[prev] == INVALID_ZOOM) {
		return;
	}

	ignoreMoveEndEvent = true;
	map.setCenter (latLngHistory[prev], zoomHistory[prev]);
	zoomHistory[historyCurrentIndex] = INVALID_ZOOM;
	historyCurrentIndex = prev;
}

private static const DEFAULT_PAN_INCREMENT_PX:int	= 100;
private static const DEFAULT_RUBBER_BAND_COLOR:uint	= 0x8080ff;
private static const DEFAULT_RUBBER_BAND_THICKNESS_PX:int	= 2;
private static const MAX_VIEWPORT_HISTORY:int		= 100;
private static const INVALID_ZOOM:int				= -1;

//	States of user interaction with the map.

//	Waiting for user to press shift key.
private static const ST_IDLE:uint	= 100;

//	User has pressed shift key, cursor has changed shape, waiting for user to
//	click mouse.
private static const ST_WATCH:uint	= 101;

//	Rubber band is visible and is tracking mouse movement.
private static const ST_DRAW:uint	= 102;

//	Current state 'ST_*'.
private var state:uint = ST_IDLE;

//	State of mouse button.
private var mouseDown:Boolean		= false;

//	Map to apply DragZoom functionality.
private var map:Map					= null;

//	Current cursor position
private var cursorPos:Point			= null;

//	Rubber band, which is drawn as a rectangle, anchored at one edge to
//	'rubberBandStartPt'.
private const rubberband:Shape		= new Shape ();
private var rubberBandStartPt:Point	= null;

//	Rubber band properties.
private var rubberBandColor:uint = DEFAULT_RUBBER_BAND_COLOR;
private var rubberBandThicknessPx:int = DEFAULT_RUBBER_BAND_THICKNESS_PX;

//	Navigation key bindings
private var zoomCharCode:int		= 0;
private var rewindViewCharCode:int	= 0;
private var panLeftCharCode:int		= 0;
private var panRightCharCode:int	= 0;
private var panUpCharCode:int		= 0;
private var panDownCharCode:int		= 0;

//	How far to pan, in pixels, vertically or horizontally
private var panIncrementPx:int = DEFAULT_PAN_INCREMENT_PX;

//	Previous key event. Used to detect and discard key repeats.
private var prevShiftKeyDown:Boolean = false;

//	Map position history, organized as a circular buffer.
private var zoomHistory:Array = new Array (MAX_VIEWPORT_HISTORY);
private var latLngHistory:Array = new Array (MAX_VIEWPORT_HISTORY);
private var historyCurrentIndex:int = 0;
private var ignoreMoveEndEvent:Boolean;

//	Cursor to display, when shift key is held.
private var crosshairCursor:CrosshairCursor = null;

}

}
