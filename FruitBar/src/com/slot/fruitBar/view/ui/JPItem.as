package com.slot.fruitBar.view.ui
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	/**彩金显示条*/
	public class JPItem extends Sprite
	{
		public function JPItem()
		{
			drawScene();
		}
		
		private function drawScene():void
		{
			var jpBg:Image = new Image(Assets.getTextureAtlas().getTexture("jpBg"));
			jpBg.touchable = false;
			addChild(jpBg);
			
			var jpTxt:TextField = new TextField(jpBg.width,jpBg.height,"1  0 0  0 0  0","Verdana",12,0xffffff);
			jpTxt.hAlign = HAlign.RIGHT;
			addChild(jpTxt);
		}
	}
}