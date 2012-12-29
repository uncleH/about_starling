package com.slot.fruitBar.view.ui
{
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class GameText extends TextField
	{
		public function GameText(width:int, height:int, text:String, fontName:String="Verdana", fontSize:Number=12, color:uint=0x0, bold:Boolean=false)
		{
			super(width, height, text, fontName, fontSize, color, bold);
			hAlign = HAlign.CENTER;
			vAlign = VAlign.CENTER;
			touchable = false;
		}
		
		public function setHAlign(value:String):void
		{
			hAlign = value;
		}
	}
}