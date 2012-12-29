package com.slot.fruitBar.view.ui
{
	import com.slot.fruitBar.view.View;

	/**贴图数字*/
	public class Numstring extends View
	{
		public var numValue:Number;
		
		private var _isZerofill:Boolean;
		private var _fullSize:uint;
		private var _texture:String;
		
		/**
		 * 贴图数字 
		 * @param numValue		数字串
		 * @param texture		贴图
		 * @param isZerofill	是否在最高位填充0
		 * @param fullSize		一共要显示多少为数字
		 * 
		 * <p>
		 * eg.
		 * 	var n:Numstring = new Numstring(10,"texture",true,3);
		 * ->010 
		 * 
		 * var n:Numstring = new Numstring(10,"texture",false);
		 * ->10 
		 * </p>
		 * 
		 */		
		public function Numstring(numValue:Number,texture:String,isZerofill:Boolean = false, fullSize:uint = 0)
		{
			this.numValue = numValue;
			_isZerofill = isZerofill;
			_fullSize = fullSize;
			_texture = texture;
			touchable = false;
			drawScene()
		}
		
		override protected function drawScene():void
		{
			var stringValue:String = String(numValue);
			var count:int = stringValue.length;
			var childCount:int;
			var i:int;
			var numerical:Numerical;
			
			if(_fullSize - count > 0)
			{
				var zeroCount:int = _fullSize - count;
				childCount = zeroCount;
				for(i = 0; i < zeroCount; i++)
				{
					numerical = new Numerical(0,_texture);
					numerical.x = i * (numerical.width + 2);
					addChild(numerical);
				}
			}
			
			for(i = 0; i < count; i++)
			{
				numerical = new Numerical(Number(stringValue.charAt(i)),_texture);
				numerical.x = (childCount+i) * (numerical.width + 2);
				addChild(numerical);
			}
		}
		
		/**更新数值*/
		public function updateValue(numValue:Number,isZerofill:Boolean = false, fullSize:uint = 0):void
		{
			if(this.numValue != numValue)
			{
				this.numValue = numValue;
				_isZerofill = isZerofill;
				_fullSize = fullSize;
				
				//TODO 
			}
		}		
		
		override public function dealloc():void
		{
			var numerical:Numerical;
			while(this.numChildren > 0)
			{
				numerical = getChildAt(0) as Numerical;
				numerical.dealloc();
			}
			super.dealloc();
		}
	}
}