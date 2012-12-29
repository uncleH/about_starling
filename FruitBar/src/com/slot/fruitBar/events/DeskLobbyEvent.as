package com.slot.fruitBar.events
{
	import starling.events.Event;
	
	public class DeskLobbyEvent extends Event
	{
		public static const DIDSELECTEDDESK:String = "didSelectedDesk";
		
		public function DeskLobbyEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}