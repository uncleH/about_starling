package com.slot.fruitBar.controller
{
	import com.slot.fruitBar.events.DeskLobbyEvent;
	import com.slot.fruitBar.events.PlayGameEvent;
	import com.slot.fruitBar.model.PlayerDataSource;
	import com.slot.fruitBar.test.AI;
	import com.slot.fruitBar.view.ui.BringPoints;
	import com.slot.fruitBar.view.ui.Sidebar;
	import com.slot.fruitBar.view.ui.Topbar;
	import com.slot.fruitBar.view.DeskLobbyView;
	import com.slot.fruitBar.view.PlayGameView;
	import com.slot.fruitBar.model.vo.DeskVo;
	import com.slot.fruitBar.model.vo.PlayerVo;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameViewController extends Sprite
	{
		//机台大厅视图，选择机台后，进入游戏
		private var _deskLobbyView:DeskLobbyView;
		
		//游戏视图
		private var _playGameView:PlayGameView;
		
		//头部状态栏，包括logo、昵称、点数和保持按钮的显示
		private var _topbar:Topbar;
		
		//侧栏，包括 全局JP显示和按钮
		private var _sidebar:Sidebar;
		
		//点数带入页面，必须带入点数才能开始游戏
		private var _bringPoints:BringPoints;
		
		//测试
		private var _ai:AI;
		
		//机台列表
		private var _deskList:Vector.<DeskVo>;
		
		public function GameViewController()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListeners(event.type);
			drawScene();
		}
		
		private function drawScene():void
		{
			addDeskLobbyView();
			
			_sidebar = new Sidebar();
			addChild(_sidebar);
			
			_topbar = new Topbar();
			_topbar.addEventListener(PlayGameEvent.BACKTODESKLOBBY, onBackToDeskLobby);
			addChild(_topbar);
			
			initializePlayer();
		}
		
		private function onDidSelectedDesk(event:DeskLobbyEvent):void
		{
			_topbar.addGameElements(event.data.deskNo);
			
			addPlayGameView();
			addBringpointView(_deskList[event.data.deskNo - 1].minBringPoint);
			swapChildren(_playGameView,_topbar);
			removeDeskLobbyView();
		}
		
		//加载机台大厅视图
		private function addDeskLobbyView():void
		{
			if(_deskLobbyView == null)
			{
				_deskLobbyView = new DeskLobbyView();
				_deskLobbyView.addEventListener(DeskLobbyEvent.DIDSELECTEDDESK, onDidSelectedDesk);
				addChild(_deskLobbyView);
			}
		}
		private function removeDeskLobbyView():void
		{
			if(_deskLobbyView)
			{
				_deskLobbyView.dealloc();
				_deskLobbyView = null;
			}
		}
		
		//加载游戏视图
		private function addPlayGameView():void
		{
			if(_playGameView == null)
			{
				_playGameView = new PlayGameView();
				_playGameView.addEventListener(PlayGameEvent.BACKTODESKLOBBY, onBackToDeskLobby);
				_playGameView.addEventListener(PlayGameEvent.STARTSPIN, onStartSpin);
				addChild(_playGameView);
			}
		}
		private function removePlayGameView():void
		{
			if(_playGameView)
			{
				_playGameView.dealloc();
				_playGameView = null;
			}
		}
		
		//加载带入点数视图
		private function addBringpointView(minBringPoint:int):void
		{
			if(_bringPoints == null)
			{
				_bringPoints = new BringPoints();
				_bringPoints.addEventListener(PlayGameEvent.BACKTODESKLOBBY,onBackToDeskLobby);
				_bringPoints.addEventListener(PlayGameEvent.BRINGPINTS, onBringPoints);
				addChild(_bringPoints);
				_bringPoints.initBringPoint(PlayerDataSource.data.points,0,minBringPoint);
			}
		}
		private function removeBringpintView():void
		{
			if(_bringPoints)
			{
				_bringPoints.dealloc();
				_bringPoints = null;
			}
		}
		
		//返回机台大厅
		private function onBackToDeskLobby(event:PlayGameEvent):void
		{
			if(_playGameView)
			{
				addDeskLobbyView();
				_deskLobbyView.initliazeDesk(_deskList);
				swapChildren(_deskLobbyView,_topbar);
				removePlayGameView();
				removeBringpintView();
				PlayerDataSource.reCountPoint();
				_topbar.removeGameElements();
				_topbar.setPoints(PlayerDataSource.data.points.toString());
			}
		}
		
		//确定带入提交点数
		private function onBringPoints(event:PlayGameEvent):void
		{
			PlayerDataSource.setBringpoints(event.data.bringPoints);
			_topbar.setPoints(PlayerDataSource.data.points.toString());
			_playGameView.operationBar.setTotalPoints(PlayerDataSource.data.bringPoints);
			removeBringpintView();
		}
		
		//开始滚动 
		private function onStartSpin(event:PlayGameEvent):void
		{
			PlayerDataSource.setBetpoints(_playGameView.operationBar.betpoint);
			var data:Object = _ai.createPattern(PlayerDataSource.data.betPoints);
			_playGameView.operationBar.startSlot(data,PlayerDataSource.data.bringPoints);
		}
			
		//模拟一个玩家，用于测试
		private function initializePlayer():void
		{
			//for test:模拟玩家信息
			var player:PlayerVo = new PlayerVo("test1","TESTER_001",1000);
			PlayerDataSource.data = player;
			
			_topbar.setNickname(PlayerDataSource.data.nickName);
			_topbar.setPoints(PlayerDataSource.data.points.toString());
			
			_ai = new AI();
			_deskList = _ai.createDesk();
			_deskLobbyView.initliazeDesk(_deskList);
		}
	}
}