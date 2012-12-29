package com.slot.fruitBar.view.ui
{
	import com.slot.fruitBar.view.View;
	
	import starling.display.Image;
	
	/**用贴图显示的单个数字*/
	public class Numerical extends View
	{
		public var num:uint;
		
		private var _texture:String
		private var _numerical:Image;
		
		public function Numerical(num:uint,texture:String)
		{
			this.num = num;
			_texture = texture;
			touchable = false;
			drawScene();
		}
		
		override protected function drawScene():void
		{
			_numerical = new Image(Assets.getTextureAtlas().getTexture(_texture + num));
			addChild(_numerical);
			this.flatten();
		}
		
		override public function dealloc():void
		{
			if(_numerical)
			{
				_numerical.texture.dispose();
				_numerical.removeFromParent(true);
				_numerical = null;
			}
			super.dealloc();
		}
	}
}