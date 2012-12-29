package com.slot.fruitBar.view.ui
{
	import com.slot.fruitBar.events.PlayGameEvent;
	import com.slot.fruitBar.view.View;
	
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import starling.core.Starling;
	
	/**滚动图案视图*/
	public class Slots extends View
	{
		private var _patternPool:Vector.<Pattern>;
		//图案坐标
		private static  const PATTERN_POSITION:Vector.<Point> = Vector.<Point>([
			new Point(230,223),
			new Point(470,223),
			new Point(715,223),
			new Point(230,375),
			new Point(470,375),
			new Point(715,375),
			new Point(230,65),
			new Point(470,65),
			new Point(715,65)
		]);
		
		private var _linePool:Vector.<Shape>;
		//绘制线的坐标
		private static const DRAW_LINE_POS:Array = [
			[new Point(313,336), new Point(1060,336)],
			
			[new Point(313,485), new Point(1060,485)],
			[new Point(328,561), new Point(1040,105)],
			
			[new Point(313,185), new Point(1060,185)],
			[new Point(318,95),  new Point(1040,560)],
			[new Point(447,90),  new Point(447,580)],
			
			[new Point(688,90),  new Point(688,580)],
			
			[new Point(926,90),  new Point(926,580)]
		];
		
		//符合中奖规则的图案列表
		private var _resultPatterns:Array;
		
		public function Slots()
		{
			drawScene();
		}
		
		override protected function drawScene():void
		{
			_linePool = new Vector.<Shape>();
			_patternPool = new Vector.<Pattern>();
			
			var mPattern:Pattern;
			
			for(var i:int = 0; i < 9; i++)
			{
				mPattern = new Pattern();
				mPattern.x = PATTERN_POSITION[i].x;
				mPattern.y = PATTERN_POSITION[i].y;
				_patternPool[i] = mPattern;
				addChild(_patternPool[i]);
			}
		}
		
		/**
		 * 开始滚动 
		 * @param result 	结果数据
		 * result.patterns 	结构图案列表
		 * result.lines 	中奖线列表
		 * result.results	中奖的图案列表
		 */		
		public function startSlot(result:Object):void
		{
			removeDrawLine();
			addLine(result.lines);
			
			_resultPatterns = result.results;
			
			for(var i:int =0; i < 9; i++)
			{
				_patternPool[i].startSlot(result.patterns[i]);
			}
		}
		
		/**停止滚动*/
		public function stopSlot():void
		{
			_patternPool[0].stopSlot();
			
			var t:Timer = new Timer(300);
			t.addEventListener(TimerEvent.TIMER,function(event:TimerEvent):void{
				_patternPool[t.currentCount].stopSlot();
				if(t.currentCount == 8)
				{
					t.stop();
					t.removeEventListener(TimerEvent.TIMER,arguments.callee);
					t = null;
					
					setTimeout(displayResult,800);
				}
			});
			t.start();
		}
		
		//添加中奖线
		private function addLine(lines:Array):void
		{
			var counts:int = lines.length;
			
			for(var i:int = 0; i < counts; i++)
			{
				drawLine(DRAW_LINE_POS[lines[i]][0],DRAW_LINE_POS[lines[i]][1]);
			}
		}
		
		//绘制线
		private function drawLine(begin:Point,end:Point):void
		{
			var mShape:Shape = new Shape();
			mShape.graphics.lineStyle(5,0xff0000);
			mShape.graphics.moveTo(begin.x,begin.y);
			mShape.graphics.lineTo(begin.x,begin.y);
			mShape.graphics.lineTo(end.x,end.y);
			mShape.visible = false;
			_linePool.push(mShape);
			Starling.current.nativeOverlay.addChild(_linePool[_linePool.length - 1]);
		}
		
		//移除中奖线
		private function removeDrawLine():void
		{
			while(_linePool.length > 0)
			{
				Starling.current.nativeOverlay.removeChild(_linePool[0]);
				_linePool.shift();
			}
		}
		
		//显示结果
		private function displayResult():void
		{
			var i:int;
			var count:int = _linePool.length;
			
			//显示中奖线
			for(i = 0; i < count; i++)
			{
				_linePool[i].visible = true;
			}
			
			//中奖图案播放中奖动画
			var index:int;
			count = _resultPatterns.length;
			for(i = 0; i < count; i++)
			{
				_patternPool[_resultPatterns[i]].didWinAction();
			}
			
			setTimeout(function():void{
				dispatchEvent(new PlayGameEvent(PlayGameEvent.STOPSPIN));
			},1000);
		}
		
		override public function dealloc():void
		{
			removeDrawLine();
			_linePool = null;
			
			var child:Pattern;
			while(numChildren > 0)
			{
				child = getChildAt(0) as Pattern;
				if(child)
				{
					child.dealloc();
				}
			}
			_patternPool = null;
			super.dealloc();
		}
	}
}