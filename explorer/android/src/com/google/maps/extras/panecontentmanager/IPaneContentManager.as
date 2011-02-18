package com.google.maps.extras.panecontentmanager
{
import com.google.maps.interfaces.IOverlay;
import com.google.maps.interfaces.IPane;
/*
PaneContentManager. 
a new way to organize a list of overlay in a pane.
*/
public interface IPaneContentManager
{
	function set pane(value:IPane):void;
	
	function set dataProvider(value:Array):void;
	
	function set overlayFunction(value:Function):void;
	function get selectedOverlay():IOverlay;
	/**
	 * execute what has to be done.
	 * 
	 * 
	 */ 
	function execute():void;
}
}