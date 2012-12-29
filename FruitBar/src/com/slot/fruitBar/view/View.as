package com.slot.fruitBar.view
{
	import starling.display.Sprite;
	
	public class View extends Sprite
	{
		public function View()
		{
			super();
		}
		
		protected function drawScene():void
		{
			
		}
		
		public function dealloc():void
		{
			removeFromParent(true);
		}
	}
}