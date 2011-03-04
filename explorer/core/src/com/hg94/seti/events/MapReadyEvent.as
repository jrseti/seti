package com.hg94.seti.events {

	import flash.events.Event;
	
	public class MapReadyEvent extends Event {
		
		public static var MAP_READY:String = "mapready";
		
		public function MapReadyEvent(type:String=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			if (type == null) {
				type = "mapready";
			}
			super(type, bubbles, cancelable);
		}
		
		public static function getEvent():MapReadyEvent {
			return new MapReadyEvent();
		}
	}
}