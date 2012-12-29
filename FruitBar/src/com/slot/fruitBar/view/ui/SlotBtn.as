package com.slot.fruitBar.view.ui
{
	import com.slot.fruitBar.events.PlayGameEvent;
	import com.slot.fruitBar.view.View;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	
	public class SlotBtn extends View
	{
		private var _btn:Button;
		private var _name:Image;
		private var _unTouchabledLayer:Image;
		
		private var _state:int;
		
		private static const NAME_TEXTURES:Array = ["beginString","stopString","getScoreString"];
		
		public function SlotBtn()
		{
			drawScene();
		}
		
		override protected function drawScene():void
		{
			_btn = new Button(Assets.getTextureAtlas().getTexture("bigRedBtn-01"),"",Assets.getTextureAtlas().getTexture("bigRedBtn-02"));
			_btn.addEventListener(Event.TRIGGERED, onTapBtn);
			addChild(_btn);
			
			_name = new Image(Assets.getTextureAtlas().getTexture("beginString"));
			_name.touchable = false;
			_name.scaleX = _name.scaleY = 1.4;
			_name.x = _btn.width * 0.5 - _name.width * 0.5;
			_name.y = 15;
			addChild(_name);
			
			var line:Image = new Image(Assets.getTextureAtlas().getTexture("line"));
			line.touchable = false;
			line.x = _btn.width * 0.5 - line.width * 0.5;
			line.y = _name.y + _name.height + 2;
			addChild(line);
			
			var spaceTextfield:GameText = new GameText(_btn.width,22,"空格键","Verdana",14,0xffffff);
			spaceTextfield.y = line.y + line.height+2;
			addChild(spaceTextfield);
			
			_unTouchabledLayer = new Image(Assets.getTextureAtlas().getTexture("bigRedBtn-03"));
			_unTouchabledLayer.alpha = 0.5;
			addChild(_unTouchabledLayer);
			
			_state = 0;
			
			setEnabled(false);
		}

		public function get state():int
		{
			return _state;
		}

		public function set state(value:int):void
		{
			_state = value;
			_name.texture = Assets.getTextureAtlas().getTexture(NAME_TEXTURES[value]);
		}
		
		private function onTapBtn(event:Event):void
		{
			switch(_state)
			{
				case 0:
					dispatchEvent(new PlayGameEvent(PlayGameEvent.STARTSPIN,true));
					break;
				case 1:
					dispatchEvent(new PlayGameEvent(PlayGameEvent.STOPSPIN));
					break;
				case 2:
					dispatchEvent(new PlayGameEvent(PlayGameEvent.GETSCORE));
					break;
				default:
					break;
			}
		}
		
		public function setEnabled(value:Boolean):void
		{
			if(_unTouchabledLayer.visible == value)
			{
				_unTouchabledLayer.visible = !value;
				touchable = value;
			}
		}
		
		override public function dealloc():void
		{
			
			super.dealloc();
		}
	}
}