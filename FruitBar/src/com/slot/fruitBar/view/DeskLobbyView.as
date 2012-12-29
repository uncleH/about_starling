package com.slot.fruitBar.view
{
	import com.slot.fruitBar.model.vo.DeskVo;
	import com.slot.fruitBar.view.ui.Assets;
	import com.slot.fruitBar.view.ui.DeskItem;
	
	import flash.utils.ByteArray;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * 机台大厅视图
	 * 
	 */	
	public class DeskLobbyView extends View
	{
		public function DeskLobbyView()
		{
			drawScene();
		}
		
		override protected function drawScene():void
		{
			//加载背景图
			var bgImage:Image = new Image(Assets.getTexture("DESKLOBBYBG",true));
			bgImage.touchable = false;
			addChild(bgImage);
			
			//加载标题：机台大厅
			var titleImage:Image = new Image(Assets.getTextureAtlas().getTexture("desklobbyString"));
			titleImage.touchable = false;
			titleImage.x = bgImage.width * 0.5 - titleImage.width * 0.5;
			titleImage.y = 60;
			addChild(titleImage);
			
			//加载自己保存机台图标：自己保存的状态
			var mySavedIcon:Image = new Image(Assets.getTextureAtlas().getTexture("desk-04"));
			mySavedIcon.touchable = false;
			mySavedIcon.scaleX = mySavedIcon.scaleY = 0.48;
			mySavedIcon.x = 70;
			mySavedIcon.y = 600;
			addChild(mySavedIcon);
			
			//加载自己保存机台文字
			var mySavedChar:Image = new Image(Assets.getTextureAtlas().getTexture("mySavedString"));
			mySavedChar.touchable = false;
			mySavedChar.x = mySavedIcon.x + mySavedIcon.width + 10;
			mySavedChar.y = 630;
			addChild(mySavedChar);
			
			//加载其他玩家保存机台图标：其他玩家保存的状态
			var otherSavedIcon:Image = new Image(Assets.getTextureAtlas().getTexture("desk-05"));
			otherSavedIcon.touchable = false;
			otherSavedIcon.scaleX = otherSavedIcon.scaleY = 0.48;
			otherSavedIcon.y = mySavedIcon.y;
			otherSavedIcon.x = mySavedChar.x + mySavedChar.width + 20;
			addChild(otherSavedIcon);
			
			//加载其他玩家保存机台文字
			var otherSavedChar:Image = new Image(Assets.getTextureAtlas().getTexture("otherSavedString"));
			otherSavedChar.touchable = false;
			otherSavedChar.y = 620;
			otherSavedChar.x = otherSavedIcon.x + otherSavedIcon.width + 10;
			addChild(otherSavedChar);
			
		}
		
		public function initliazeDesk(data:Vector.<DeskVo>):void
		{
			if(data == null)
			{
				return;
			}
			
			var mDesk:DeskItem;		//要加载的机台实例
			var mWidth:Number;	//机台的宽
			var mHeight:Number; //机台的长
			
			//获取机台的数量
			var count:int = data.length;
			
			//加载机台资源
			for(var i:int = 0; i < count; i++)
			{
				mDesk = new DeskItem(data[i]);
				
				//获取机台的长宽，避免重复获取对象的长宽，因为此操作需要复杂的计算，消耗cpu资源
				if(i == 0)
				{
					mWidth = mDesk.width;
					mHeight = mDesk.height;
				}
				
				mDesk.x = (i % 9) * mWidth * 1.2 + 90;
				mDesk.y = Math.floor(i/9) * mHeight*1.1 + 140;
				addChild(mDesk);
			}
		}
		
		/**从父对象中移除，并释放资源*/
		override public function dealloc():void
		{
			var child:*;
			while(this.numChildren > 0)
			{
				child = getChildAt(0);
				
				if(child as Image)
				{
					(child as Image).texture.dispose();
					(child as Image).removeFromParent(true);
				}
				else if(child as DeskItem)
				{
					(child as DeskItem).dealloc();
				}
			}
			super.dealloc();
		}
	}
}