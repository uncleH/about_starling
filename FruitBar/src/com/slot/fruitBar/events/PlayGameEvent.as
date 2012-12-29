package com.slot.fruitBar.events
{
	import starling.events.Event;
	
	public class PlayGameEvent extends Event
	{
		public static const BACKTODESKLOBBY:String = "backToDeskLobby";
		public static const BRINGPINTS:String = "bringPoints";
		public static const DISPLAYINFOS:String = "displayInfos";
		public static const STARTSPIN:String = "startSpin";
		public static const STOPSPIN:String = "stopSpin";
		public static const GETSCORE:String = "getScore";
		public static const AUTOSPIN:String = "autoSpin";
		
		public function PlayGameEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}