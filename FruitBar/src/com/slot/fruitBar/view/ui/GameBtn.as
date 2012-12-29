package com.slot.fruitBar.view.ui
{
	import com.slot.fruitBar.view.View;
	
	import starling.display.Button;
	import starling.display.Image;
	
	public class GameBtn extends View
	{
		private var _icon:Image;
		private var _btn:Button;
		private var _disabledLayer:Image;
		
		public function GameBtn(upTexture:String, downTexture:String, icon:String, disabledTexture:String = null)
		{
			drawScene(upTexture,downTexture,icon,disabledTexture);
		}
		
		private function drawScene(upTexture:String, downTexture:String, icon:String, disabledTexture:String):void
		{
			_btn = new Button(Assets.getTextureAtlas().getTexture(upTexture),"",Assets.getTextureAtlas().getTexture(downTexture));
			addChild(_btn);
			
			if(icon != null)
			{
				_icon = new Image(Assets.getTextureAtlas().getTexture(icon));
				_icon.touchable = false;
				_icon.x = Math.ceil(_btn.width * 0.5 - _icon.width * 0.5);
				_icon.y = Math.ceil(_btn.height * 0.5 - _icon.height * 0.5);
				addChild(_icon);
			}
			
			if(disabledTexture)
			{
				_disabledLayer = new Image(Assets.getTextureAtlas().getTexture(disabledTexture));
				_disabledLayer.alpha = 0.5;
				addChild(_disabledLayer);
			}
			
			setEnabled(true);
		}
		
		public function offsetIconPosition(offsetX:Number, offsetY:Number):void
		{
			if(_icon)
			{
				_icon.x += offsetX;
				_icon.y += offsetY;
			}
		}
		
		public function scaleIcon(factor:Number):void
		{
			_icon.scaleX = _icon.scaleY = factor;
			_icon.x = _btn.width * 0.5 - _icon.width * 0.5;
			_icon.y = _btn.height * 0.5 - _icon.height * 0.5;
		}
		
		public function setBtnFilter(filter:*):void
		{
			_btn.filter =filter;
		}
		
		public function setIconFilter(filter:*):void
		{
			_icon.filter = filter;
		}
		
		override public function dealloc():void
		{
			if(_icon)
			{
				_icon.texture.dispose();
				_icon.removeFromParent(true);
				_icon = null;
			}
			
			if(_btn)
			{
				_btn.upState.dispose();
				_btn.downState.dispose();
				_btn.removeFromParent(true);
				_btn = null;
			}
			super.dealloc();
		}
		
		public function setEnabled(value:Boolean):void
		{
			if(_disabledLayer && _disabledLayer.visible == value)
			{
				_disabledLayer.visible = !value;
				touchable = value;
			}
		}
	}
}