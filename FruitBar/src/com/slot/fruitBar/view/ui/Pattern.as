package com.slot.fruitBar.view.ui
{
	import com.slot.fruitBar.view.View;
	
	import flash.geom.Rectangle;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.extensions.ClippedSprite;
	
	public class Pattern extends View
	{
		//图案名称前缀
		private static const PATTERN_PREFIX:String = "pattern-0";
		//有遮罩功能的sprite，用来加载 _patternImage和_patterMc
		private var _patternContainer:ClippedSprite;
		//图案滚动动画
		private var _motionMc:MovieClip;
		//图案
		private var _patternImage:Image;
		//图案id
		private var _patternId:Number;
		
		public function Pattern()
		{
			drawScene();
		}
		
		override protected function drawScene():void
		{
			_patternContainer = new ClippedSprite();
			addChild(_patternContainer);
			
			_patternId = Math.ceil(Math.random() * 9);
			
			_patternImage = new Image(Assets.getTextureAtlas().getTexture(PATTERN_PREFIX + _patternId));
			_patternImage.pivotX = _patternImage.width * 0.5;
			_patternImage.pivotY = _patternImage.height * 0.5;
			_patternImage.y = 144*0.5 + 5;
			_patternImage.x = 226*0.5;
			_patternImage.touchable = false;
			_patternContainer.addChild(_patternImage);
			
			_motionMc = new MovieClip(Assets.getTextureAtlas().getTextures("slotMotion-"),40);
			_motionMc.scaleX = _motionMc.scaleY = 1.2;
			_motionMc.x = 226*0.5 - _motionMc.width*0.5;
			_motionMc.y = Math.ceil((144*0.5 - _motionMc.height * 0.5))+8;
			_motionMc.touchable = false;
			_motionMc.visible = false;
			_motionMc.currentFrame = Math.ceil(Math.random() * 14);
			_patternContainer.addChild(_motionMc);
			_patternContainer.clipRect = new Rectangle(0,2,226,146);
		}
		
		/**
		 * 开始滚动 
		 * @param id	结果显示的图案id
		 * 
		 */		
		public function startSlot(id:int):void
		{
			var tween:Tween = new Tween(_patternImage,0.5,Transitions.EASE_IN_BACK);
			tween.animate("y",_patternImage.y + 30);
			tween.onComplete = function():void{
				Starling.juggler.remove(tween);
				_motionMc.visible = true;
				Starling.juggler.add(_motionMc);
				
				if(_patternId != id)
				{
					_patternImage.texture.dispose();
					_patternImage.removeFromParent(true);
					_patternImage =  new Image(Assets.getTextureAtlas().getTexture(PATTERN_PREFIX + id));
					_patternImage.pivotX = _patternImage.width * 0.5;
					_patternImage.pivotY = _patternImage.height * 0.5;
					_patternImage.y = 144*0.5+ 50;
					_patternImage.x = 226*0.5;
					_patternImage.touchable = false;
					_patternContainer.addChildAt(_patternImage,0);
				}
				_patternId = id;
				_patternImage.visible = false;
			};
			Starling.juggler.add(tween);
		}
		
		/**停止滚动*/
		public function stopSlot():void
		{
			var tween:Tween = new Tween(_patternImage,0.3,Transitions.EASE_IN_OUT_BACK);
			tween.animate("y",_patternImage.y - 48);
			tween.onComplete = function():void{
				_patternImage.y = 144*0.5 + 3;
				_patternImage.x = 226*0.5;
				Starling.juggler.remove(tween);
			};
			_patternImage.visible = true;
			_motionMc.visible = false;
			Starling.juggler.remove(_motionMc);
			Starling.juggler.add(tween);
		}
		
		/**中奖动画*/
		public function didWinAction():void
		{
			var tween:Tween = new Tween(_patternImage,0.4,Transitions.EASE_IN_BOUNCE);
			tween.scaleTo(1.12);
			tween.onComplete = function():void{
				_patternImage.scaleX = _patternImage.scaleY = 1;
				Starling.juggler.remove(tween);
			};
			tween.repeatCount = 6;
			Starling.juggler.add(tween);
		}
		
		override public function dealloc():void
		{
			if(Starling.juggler.contains(_motionMc))
			{
				Starling.juggler.remove(_motionMc);
			}
			_motionMc.removeFromParent(true)
			_patternImage.texture.dispose();
			_patternImage.removeFromParent(true);
			_patternContainer.removeFromParent(true);
			Starling.juggler.purge();
			super.dealloc();
		}
	}
}