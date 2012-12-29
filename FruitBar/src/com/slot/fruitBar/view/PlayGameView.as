package com.slot.fruitBar.view
{
	import com.slot.fruitBar.events.PlayGameEvent;
	import com.slot.fruitBar.view.ui.GameInfo;
	import com.slot.fruitBar.view.ui.InGameJP;
	import com.slot.fruitBar.view.ui.OpertationBar;
	import com.slot.fruitBar.view.ui.playGameBg;
	
	public class PlayGameView extends View
	{
		//背景
		private var _bg:playGameBg;
		//显示彩金
		private var _jp:InGameJP
		//游戏信息，包括赔率等
		private var _info:GameInfo;
		//操作栏，按钮和滚动图案等
		public var operationBar:OpertationBar;
		
		public function PlayGameView()
		{
			drawScene();
		}
		
		override protected function drawScene():void
		{
			_bg = new playGameBg();
			addChild(_bg);
			
			_jp = new InGameJP();
			_jp.x = 37;
			_jp.y = 130;
			addChild(_jp);

			operationBar = new OpertationBar();
			operationBar.addEventListener(PlayGameEvent.DISPLAYINFOS,onDisplayInfos);
			addChild(operationBar);
		}
		
		//显示或隐藏游戏信息
		private function onDisplayInfos(event:PlayGameEvent):void
		{
			if(_info)
			{
				_info.dealloc();
				_info = null;
			}
			else
			{
				_info = new GameInfo();
				_info.y = (_bg.height - _info.height)*0.5 - 25;
				_info.x = (_bg.width - _info.width)*0.5 + 137;
				addChild(_info);
			}
		}
		
		override public function dealloc():void
		{
			if(_info)
			{
				_info.dealloc();
				_info = null;
			}
			_bg.dealloc();
			_bg = null;
			operationBar.dealloc();
			operationBar = null;
			super.dealloc();
		}
	}
}