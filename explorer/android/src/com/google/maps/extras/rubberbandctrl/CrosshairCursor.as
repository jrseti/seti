package com.google.maps.extras.rubberbandctrl
{

import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.ui.Mouse;
import flash.display.Shape;

/**
 * A cursor that shows a "crosshair" pattern. Used by RubberBandCtrl.
 * <p>
 * <strong>Notes:</strong>&#xA0;
 * <ul>
 * <li>This class is not required for Flash 10, which includes support for alternate cursors.</li>
 * </ul>
 * </p>
 * <p>
 * <strong>Contacts:</strong>
 * <ul>
 * <li>To contact the author of CrosshairCursor, email kevin.macdonald AT thinkwrap DOT com</li>
 * <li>Visit <code>http://www.spatialdatabox.com</code> for other Google Flash Map demos and related information.</li>
 * <li>For updates to CrosshairCursor, please visit <code>http://code.google.com/p/gmaps-utility-library-flash</code></li>
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
internal class CrosshairCursor
{

function CrosshairCursor (displayObject:DisplayObjectContainer)
{
	displayObject.addChild (cursor);
	hide ();
}

internal function show (p:Point):void
{
	if (! cursor.visible) {
		Mouse.hide ();
		cursor.visible = true;
	}
	cursor.x = p.x + X_OFFSET_PX - 1;
	cursor.y = p.y + Y_OFFSET_PX - 1;
}


internal function hide ():void
{
	cursor.visible = false;
	Mouse.show ();
}

internal function isVisible ():Boolean
{
	return cursor.visible;
}

private static function drawCrosshairs ():Shape
{
	const s:Shape = new Shape ();

	//	Draw a thick white crosshair
	s.graphics.lineStyle (BACKGROUND_THICKNESS_PX, BACKGROUND_COLOR);
	s.graphics.moveTo (SIZE_PX / 2, 0);
	s.graphics.lineTo (SIZE_PX / 2, SIZE_PX);
	s.graphics.moveTo (0, SIZE_PX / 2);
	s.graphics.lineTo (SIZE_PX, SIZE_PX / 2);

	//	Draw a thin black crosshair in the middle of the thick white crosshair.
	s.graphics.lineStyle (FOREGROUND_THICKNESS_PX, FOREGROUND_COLOR);
	s.graphics.moveTo (SIZE_PX / 2, 0);
	s.graphics.lineTo (SIZE_PX / 2, SIZE_PX);
	s.graphics.moveTo (0, SIZE_PX / 2);
	s.graphics.lineTo (SIZE_PX, SIZE_PX / 2);

	return s;
}

private static const BACKGROUND_COLOR:uint = 0xffffff;
private static const BACKGROUND_THICKNESS_PX:uint = 3;

private static const FOREGROUND_COLOR:uint = 0x000000;
private static const FOREGROUND_THICKNESS_PX:uint = 1;

//	Width & height of crosshair cursor. Must be an odd number.
private static const SIZE_PX:int = 15;

//	Offset of cursor origin (ie. upper-left-edge) from its center.
private static const X_OFFSET_PX:int = -SIZE_PX / 2;
private static const Y_OFFSET_PX:int = -SIZE_PX / 2;

private static const cursor:Shape = drawCrosshairs ();

}

}
