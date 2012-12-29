package com.slot.fruitBar.view.ui
{
	import com.slot.fruitBar.view.View;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	
	public class Checkbox extends View
	{
		private var _checkboxBtn:Button;
		private var _checkboxIcon:Image;
		
		private var _isSelected:Boolean;
		
		public function Checkbox()
		{
			drawScene();
		}
		
		override protected function drawScene():void
		{
			_checkboxBtn = new Button(Assets.getTextureAtlas().getTexture("checkbox"));
			_checkboxBtn.addEventListener(Event.TRIGGERED,onTrigger);
			addChild(_checkboxBtn);
			
			_checkboxIcon = new Image(Assets.getTextureAtlas().getTexture("selectedIco"));
			_checkboxIcon.x = _checkboxBtn.x;
			_checkboxIcon.y = _checkboxBtn.y - 5;
			_checkboxIcon.touchable = false;
			addChild(_checkboxIcon);
			
			isSelected = false;
		}
		
		private function onTrigger(event:Event):void
		{
			isSelected =!_isSelected?true:false;
		}

		public function get isSelected():Boolean
		{
			return _isSelected;
		}

		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
			_checkboxIcon.visible = _isSelected;
		}

	}
}