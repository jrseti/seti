package com.google.maps.extras.panecontentmanager
{
import com.google.maps.MapMouseEvent;
import com.google.maps.interfaces.IOverlay;
import com.google.maps.interfaces.IPane;

import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.utils.Dictionary;

public class AbstractPaneContentManager extends EventDispatcher implements IPaneContentManager
{
	public function AbstractPaneContentManager(
		pane:IPane=null, dataProvider:Array=null,
		overlayFunction:Function = null)
	{
		var target:IEventDispatcher=null;
		super(target);
		
		if(pane != null){
			this.pane = pane;
		}
		
		if(dataProvider != null){
			this.dataProvider = dataProvider;
		}
		
		if(overlayFunction != null){
			this.overlayFunction = overlayFunction;
		}
		
		
	}
	
	protected var thePane:IPane
	public function set pane(value:IPane):void
	{
		this.thePane = value;
	}
	
	private var theDataProvider:Array;
	public function set dataProvider(value:Array):void
	{
		this.theDataProvider = value;
	}
	
	private var theOverlayFunction:Function;
	public function set overlayFunction(value:Function):void
	{
		this.theOverlayFunction = value;
	}
	
	private var _itemToOverlay_dict:Dictionary = new Dictionary;
	
	public function execute():void{
		
		for each(var item:Object in theDataProvider){
			var overlay:IOverlay = this.theOverlayFunction(item);
			overlay.addEventListener(MapMouseEvent.CLICK, onClick_overlay);
			this.thePane.addOverlay(overlay);
		}
	}
	
	private function onClick_overlay(event:MapMouseEvent):void{
		_selectedOverlay = event.target as IOverlay;
	}
	
	private var _selectedOverlay:IOverlay;
	public function get selectedOverlay():IOverlay{
		return _selectedOverlay;
	}
}
}