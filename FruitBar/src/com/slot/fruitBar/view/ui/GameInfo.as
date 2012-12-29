package com.slot.fruitBar.view.ui
{
	import com.slot.fruitBar.view.View;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	
	/**游戏里面显示的赔率规则*/
	public class GameInfo extends View
	{
		private var _info:Image;
		private var _closeBtn:GameBtn;
		private var _flipLeftBtn:Button;
		private var _pageTextfield:GameText;
		private var _flipRightBtn:Button;
		
		private var _currentPage:int = 1;
		private static const TOTALPAGE:int = 6;
		
		public function GameInfo()
		{
			drawScene();
		}
		
		override protected function drawScene():void
		{
			var bgImage:Image = new Image(Assets.getTexture("INFOSBG",true));
			bgImage.touchable = false;
			addChild(bgImage);
			
			_closeBtn = new GameBtn("red2Btn-01","red2Btn-02","quitIcon");
			_closeBtn.addEventListener(Event.TRIGGERED, onTouch);
			_closeBtn.y = 30;
			_closeBtn.x = bgImage.width - _closeBtn.width*1.4;
			addChild(_closeBtn);
			
			_info = new Image(Assets.getTexture("INFOS_1",true));
			_info.touchable = false;
			_info.y = 30;
			_info.x = (bgImage.width - _info.width) * 0.5;
			addChild(_info);
			
			_pageTextfield = new GameText(100,30,_currentPage+" / "+TOTALPAGE,"Verdana",24,0xffff00);
			_pageTextfield.y = _info.y + _info.height + 20;
			_pageTextfield.x = (bgImage.width - _pageTextfield.width) * 0.5;
			addChild(_pageTextfield);
			
			_flipLeftBtn = new Button(Assets.getTextureAtlas().getTexture("flipLeftBtn"));
			_flipLeftBtn.addEventListener(Event.TRIGGERED, onTouch);
			_flipLeftBtn.y = _pageTextfield.y + 5;
			_flipLeftBtn.x = _pageTextfield.x - _flipLeftBtn.width * 1.5;
			addChild(_flipLeftBtn);
			
			_flipRightBtn = new Button(Assets.getTextureAtlas().getTexture("flipRightBtn"));
			_flipRightBtn.addEventListener(Event.TRIGGERED, onTouch);
			_flipRightBtn.y = _flipLeftBtn.y;
			_flipRightBtn.x = _pageTextfield.x + _pageTextfield.width + _flipRightBtn.width * 0.5;
			addChild(_flipRightBtn);
			
		}
		
		private function onTouch(event:Event):void
		{
			if(event.currentTarget == _closeBtn)	//关闭
			{
				dealloc();
			}
			else
			{
				var page:int = _currentPage;
				if(event.currentTarget == _flipLeftBtn && page > 1)		//左翻页
				{
					page--;
				}
				else if(event.currentTarget == _flipRightBtn && page < TOTALPAGE)	//右翻页
				{
					page++;
				}
				
				if(_currentPage != page)
				{
					_currentPage = page;
					_info.texture = Assets.getTexture("INFOS_"+_currentPage);
					_pageTextfield.text = _currentPage + " / " +TOTALPAGE;
				}
			}
		}
		
		override public function dealloc():void
		{
			var child:*;
			while(numChildren > 0)
			{
				child = getChildAt(0);
				if(child as GameBtn)
				{
					(child as GameBtn).dealloc();
				}
				else if(child as Image)
				{
					(child as Image).texture.dispose();
					(child as Image).removeFromParent(true);
				}
				else if(child as Button)
				{
					(child as Button).upState.dispose();
					(child as Button).downState.dispose();
					(child as Button).removeFromParent(true);
				}
				else if(child as GameText)
				{
					(child as GameText).removeFromParent(true);	
				}
			}
			super.dealloc();
		}
	}
}