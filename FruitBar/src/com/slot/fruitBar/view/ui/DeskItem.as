package com.slot.fruitBar.view.ui
{
	import com.slot.fruitBar.events.DeskLobbyEvent;
	import com.slot.fruitBar.model.vo.DeskVo;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.ColorMatrixFilter;
	
	/**机台*/
	public class DeskItem extends Sprite
	{
		private var _bitmap:Bitmap;
		private var _desk:Image;
		private var _no:Numstring;
		
		//鼠标状态 0普通，1：hover 2：end
		private var _touchState:int;
		
		/**机台设置数据*/
		public var data:DeskVo;
		
		public function DeskItem(data:DeskVo)
		{
			this.data = data;
			initializeDesk();
		}
		
		//初始化，组装机台
		private function initializeDesk():void
		{
			//机台底板
			
			_bitmap = new Assets['DESKITEM']();
			
			_desk = new Image(Assets.getTextureAtlas().getTexture("desk-01"));
			_desk.addEventListener(TouchEvent.TOUCH, onTouchDesk);
			addChild(_desk);
			
			var filter:ColorMatrixFilter = new ColorMatrixFilter();
			filter.matrix = Vector.<Number>([
				1,0,0,0,0,
				1,0,0,0,0,
				1,0,0,0,0,
				0,0,0,1,0
			]);
			
			//机台号码
			_no = new Numstring(data.id,"goldenNumber-0",true,2);
			_no.filter = filter;
			_no.x = 23;
			_no.y = 86;
			addChild(_no);
		}
		
		private function onTouchDesk(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(event.currentTarget as Image);
			if(touch)
			{
				if(touch.phase == TouchPhase.HOVER)  //滑过
				{
					var p:Point = touch.getLocation(event.currentTarget as Image);
					if(_bitmap.bitmapData.getPixel32(p.x,p.y) > 0)	//如果不是透明的像素则显示选中状态
					{
						if(_touchState != 1)
						{
							_desk.texture = Assets.getTextureAtlas().getTexture("desk-02");
							useHandCursor = true;
							_no.y = 83;
							_touchState = 1;
						}
					}
					else
					{
						if(useHandCursor)	//如果光标样式为手型，切换为默认形式
						{
							useHandCursor = false;
							Mouse.cursor =  MouseCursor.AUTO;
						}
						_desk.texture = Assets.getTextureAtlas().getTexture("desk-01");
						_no.y = 86;
						_touchState = 0;
					}
				}
				else if(touch.phase == TouchPhase.ENDED && _touchState == 1) //点击
				{
					dispatchEvent(new DeskLobbyEvent(DeskLobbyEvent.DIDSELECTEDDESK,true,{deskNo:data.id}));
					if(_desk)
					{
						_desk.texture = Assets.getTextureAtlas().getTexture("desk-03");
						_no.y = 86;
					}
					_touchState = 2;
				}
			}
			else
			{
				if(_touchState!= 0)
				{
					_desk.texture = Assets.getTextureAtlas().getTexture("desk-01");
					if(useHandCursor)
					{
						useHandCursor = false;
					}
					_no.y = 86;
				}
				_touchState = 0;
			}
		}
		
		/**如果此台被保留，恢复普通状态*/
		public function resetState():void
		{
			if(data.state > 0)
			{
				data.state = 0;
				_desk.texture = Assets.getTextureAtlas().getTexture("desk-01");
				_desk.touchable = true;
				_desk.useHandCursor = true;
				_desk.addEventListener(TouchEvent.TOUCH,onTouchDesk);
			}
		}
		
		/**
		 * 设置保留状态 
		 * @param isMyself
		 * 
		 */		
		public function didSaved(isMyself:Boolean):void
		{
			data.state = isMyself?1:2;
			
			_desk.texture = Assets.getTextureAtlas().getTexture("desk-0"+(isMyself?4:5));
			_desk.touchable = false;
			_desk.useHandCursor = false;
			_desk.removeEventListeners(TouchEvent.TOUCH);
		}
		
		/**从父对象中移除，并释放资源*/
		public function dealloc():void
		{
			if(_desk)
			{
				_desk.texture.dispose();
				_desk.removeFromParent(true);
				_desk = null;
			}
			removeFromParent(true);
		}
	}
}