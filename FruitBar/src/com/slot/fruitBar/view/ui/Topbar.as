package com.slot.fruitBar.view.ui
{
	import com.slot.fruitBar.events.PlayGameEvent;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.ColorMatrixFilter;
	import starling.utils.HAlign;
	
	public class Topbar extends Sprite
	{
		private var _nickNameTextfiled:GameText;
		private var _pointTextfiled:GameText;
		private var _roundChar:GameText;
		private var _roundTextfield:GameText;
		private var _saveBtn:GameBtn;
		private var _faqBtn:GameBtn;
		private var _fullscreenBtn:GameBtn;
		private var _deskNo:Sprite;
		private var _rebackBtn:GameBtn;
		
		public function Topbar()
		{
			drawScene();
		}
		
		private function drawScene():void
		{
			var logoImage:Image = new Image(Assets.getTextureAtlas().getTexture("logo"));
			logoImage.touchable = false;
			logoImage.x = 10;
			addChild(logoImage);
			
			var headerBg:Image = new Image(Assets.getTextureAtlas().getTexture("textfieldBg"));
			headerBg.touchable = false;
			headerBg.x = 320;
			headerBg.y = 10;
			addChild(headerBg);
			
			var headerImage:Image = new Image(Assets.getTextureAtlas().getTexture("header"));
			headerImage.touchable = false;
			headerImage.x = 302;
			headerImage.y = 1;
			addChild(headerImage);
			
			_nickNameTextfiled = new GameText(122,30,"xde","Verdana",18,0xffff00);
			_nickNameTextfiled.x = 337;
			_nickNameTextfiled.y = 9;
			addChild(_nickNameTextfiled);
			
			var pointsBg:Image = new Image(Assets.getTextureAtlas().getTexture("textfieldBg"));
			pointsBg.touchable = false;
			pointsBg.y = 10;
			pointsBg.x = 542;
			addChild(pointsBg);
			
			var pointsImage:Image = new Image(Assets.getTextureAtlas().getTexture("pointsIcon"));
			pointsImage.touchable = false;
			pointsImage.x = 520;
			pointsImage.y =1;
			addChild(pointsImage);
			
			_pointTextfiled = new GameText(122,30,"3000","Verdana",18,0xffff00);
			_pointTextfiled.y = 9;
			_pointTextfiled.x = 550;
			addChild(_pointTextfiled);
			
			_rebackBtn = new GameBtn("shortGreenBtn-01","shortGreenBtn-02","quitIcon");
			_rebackBtn.addEventListener(Event.TRIGGERED, onTrigger);
			var colorFilter:ColorMatrixFilter = new ColorMatrixFilter();
			colorFilter.adjustHue(-0.8);
			_rebackBtn.setBtnFilter(colorFilter);
			_rebackBtn.y = 3;
			var dis:int = (Starling.current.stage.stageWidth - _rebackBtn.width - 10)>>0;
			_rebackBtn.x = Starling.current.stage.stageWidth - _rebackBtn.width - 10;
			addChild(_rebackBtn);
			
			_fullscreenBtn = new GameBtn("shortGreenBtn-01","shortGreenBtn-02","fullScreenIcon");
			_fullscreenBtn.x = _rebackBtn.x - _fullscreenBtn.width - 6;
			_fullscreenBtn.y = 3;
			addChild(_fullscreenBtn);
			
			_faqBtn = new GameBtn("shortGreenBtn-01","shortGreenBtn-02","faqIcon");
			_faqBtn.x = _fullscreenBtn.x - _faqBtn.width - 6;
			_faqBtn.y = 3;
			addChild(_faqBtn);
		}
		
		public function addGameElements(deskNo:Number):void
		{
			_saveBtn = new GameBtn("shortGreenBtn-01","shortGreenBtn-02","saveIcon");
			_saveBtn.x = _faqBtn.x - _saveBtn.width - 10;
			_saveBtn.y = 3;
			addChild(_saveBtn);
			
			_deskNo = new Sprite();
			_deskNo.y = 4;
			_deskNo.x = 150;
			addChild(_deskNo);
			
			var deskNoBg:Image = new Image(Assets.getTextureAtlas().getTexture("room"));
			deskNoBg.touchable = false;
			_deskNo.addChild(deskNoBg);
			
			var deskNumber:Numstring = new Numstring(deskNo,"goldenNumber-0",true,2);
			deskNumber.x = deskNoBg.width - deskNumber.width*1.5;
			deskNumber.y = deskNoBg.height*0.5 - deskNumber.height*0.5;
			_deskNo.addChild(deskNumber);
			
			_roundChar = new GameText(53,25,"局号：","Verdana",16,0xffffff,true);
			_roundChar.x = 710;
			_roundChar.y = 12;
			addChild(_roundChar);
			
			_roundTextfield = new GameText(122,25,"DFE444","Verdana",16,0xffffff,true);
			_roundTextfield.setHAlign(HAlign.LEFT);
			_roundTextfield.y = 12;
			_roundTextfield.x = _roundChar.x + _roundChar.width;
			addChild(_roundTextfield);
		}
		
		public function removeGameElements():void
		{
			if(_saveBtn)
			{
				_saveBtn.dealloc();
			}
			
			if(_roundChar)
			{
				_roundChar.removeFromParent(true);
				_roundChar = null;
			}
			
			if(_roundTextfield)
			{
				_roundTextfield.removeFromParent(true);
				_roundTextfield = null;
			}
			
			if(_deskNo)
			{
				var child:*;
				while(_deskNo.numChildren > 0)
				{
					child = _deskNo.getChildAt(0);
					
					if(child as Image)
					{
						(child as Image).texture.dispose();
						(child as Image).removeFromParent(true);
					}
					else if(child as Numstring)
					{
						(child as Numstring).dealloc();
					}
				}
				
				_deskNo.removeFromParent(true);
				_deskNo = null;
			}
		}
		
		public function setNickname(value:String):void
		{
			if(value != null)
			{
				_nickNameTextfiled.text = value;
			}
		}
		
		public function setPoints(value:String):void
		{
			if(value != null)
			{
				_pointTextfiled.text = value;
			}
		}
		
		public function setRoundNo(value:String):void
		{
			if(value != null)
			{
				_roundTextfield.text = value;
			}
		}
		
		private function onTrigger(event:Event):void
		{
			dispatchEvent(new PlayGameEvent(PlayGameEvent.BACKTODESKLOBBY));
		}
	}
}