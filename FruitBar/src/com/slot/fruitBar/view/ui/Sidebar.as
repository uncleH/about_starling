package com.slot.fruitBar.view.ui
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Sidebar extends Sprite
	{
		public function Sidebar()
		{
			drawScene();
		}
		
		private function drawScene():void
		{
			var bgImage:Image = new Image(Assets.getTexture("PLAYGAMEBG2"));
			bgImage.x = 1098;
			bgImage.touchable = false;
			addChild(bgImage);
			
			var moreGameImage:Image = new Image(Assets.getTextureAtlas().getTexture("moreGameBtn-01"));
			moreGameImage.x = bgImage.x + (bgImage.width - moreGameImage.width) * 0.5 - 3;
			moreGameImage.y = bgImage.height - moreGameImage.height - 25;
			addChild(moreGameImage);
			
			var jpBg:Image = new Image(Assets.getTexture("SIDEBARJP"));
			jpBg.x = bgImage.x + (bgImage.width - jpBg.width ) *0.5 - 1;
			jpBg.y = 100;
			addChild(jpBg);
			
			var jp1:JPItem = new JPItem();
			jp1.scaleX = jp1.scaleY = 0.98;
			jp1.x = jpBg.x + (jpBg.width - jp1.width)*0.5-2;
			jp1.y = 210;
			addChild(jp1);
			
			var jp2:JPItem = new JPItem();
			jp2.scaleX = jp2.scaleY = 0.98;
			jp2.x = jp1.x;
			jp2.y = 280;
			addChild(jp2);
			
			
			var jp3:JPItem = new JPItem();
			jp3.scaleX = jp3.scaleY = 0.98;
			jp3.x = jp1.x;
			jp3.y = 350;
			addChild(jp3);
			
			var jp4:JPItem = new JPItem();
			jp4.scaleX = jp4.scaleY = 0.98;
			jp4.x =jp1.x;
			jp4.y = 420;
			addChild(jp4);
			
			var soundIcon:Image = new Image(Assets.getTextureAtlas().getTexture("soundbtn"));
			soundIcon.touchable = false;
			soundIcon.x = bgImage.x + 5;
			soundIcon.y = 60;
			addChild(soundIcon);
			
			var soundVolumn:Image = new Image(Assets.getTextureAtlas().getTexture("sound"));
			soundVolumn.touchable = false;
			soundVolumn.x = soundIcon.x + soundIcon.width + 10;
			soundVolumn.y = soundIcon.y - 2;
			addChild(soundVolumn);
			
			var soundLine:Image = new Image(Assets.getTextureAtlas().getTexture("scrollLine"));
			soundLine.touchable =false;
			soundLine.x = soundVolumn.x;
			soundLine.y = soundVolumn.y + soundVolumn.height + 10;
			addChild(soundLine);
			
			var soundArrow:Image = new Image(Assets.getTextureAtlas().getTexture("arrowBtn"));
			soundArrow.touchable = false;
			soundArrow.x = soundLine.x;
			soundArrow.y = soundLine.y - soundArrow.height*0.5;
			addChild(soundArrow);
			
			flatten();
		}
	}
}