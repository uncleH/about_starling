package com.slot.fruitBar.view.ui
{
	import com.slot.fruitBar.events.PlayGameEvent;
	import com.slot.fruitBar.model.consts.Settings;
	import com.slot.fruitBar.view.View;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class OpertationBar extends View
	{
		private var _infoBtn:GameBtn;
		private var _settingBtn:GameBtn;
		private var _autoBtn:GameBtn;
		private var _reduceBtn:GameBtn;
		private var _addBtn:GameBtn;
		private var _betBtn:GameBtn;
		private var _maxBetBtn:GameBtn;
		private var _startBtn:GameBtn;
		private var _stopBtn:GameBtn;
		private var _scoreBtn:GameBtn;
		private var _slotBtn:SlotBtn;
		private var _betRateTextfield:GameText;
		private var _betTextfield:GameText;
		private var _scoreTextfield:GameText;
		private var _totalMarkTextfield:GameText;
		private var _startTimeTextfiled:TextField;
		
		private var _betDisplayTxtPool:Vector.<GameText>;
		private static const BETDISPLAYTXTPOS:Vector.<Point> = Vector.<Point>([
			new Point(240,582),
			new Point(231,472),
			new Point(231,322),
			new Point(231,166),
			new Point(241,50),
			new Point(397,50),
			new Point(637,50),
			new Point(875,50)
		]);
		
		private var _slots:Slots;
		
		private var _canWinScore:Boolean;
		private var _totalMark:Number;
		private var _stopInterval:uint;
		private var _isAuto:Boolean;
		private var _isSloting:Boolean;
		
		public var betpoint:int;
		
		public function OpertationBar()
		{
			drawScene();
		}
		
		override protected function drawScene():void
		{
			_betRateTextfield = new GameText(122,29,"1:1","Verdana",19,0xffff00,true);
			_betRateTextfield.x = 100;
			_betRateTextfield.y = 628;
			addChild(_betRateTextfield);
			
			_scoreTextfield = new GameText(122,29,"0","Verdana",19,0xffff00,true);
			_scoreTextfield.y = 628;
			_scoreTextfield.x = 330;
			addChild(_scoreTextfield);
			
			_betTextfield = new GameText(122,29,"0","Verdana",19,0xffff00,true);
			_betTextfield.x = 570;
			_betTextfield.y = 628;
			addChild(_betTextfield);
			
			_totalMarkTextfield = new GameText(122,29,"0","Verdana",19,0xffff00,true);
			_totalMarkTextfield.x = 810;
			_totalMarkTextfield.y = 628;
			addChild(_totalMarkTextfield);
			
			_betDisplayTxtPool = new Vector.<GameText>();
			var txt:GameText ;
			for(var i:int = 0; i < 8; i++)
			{
				txt = new GameText(100,25,"0","Verdana",16,0xffffff);
				txt.x = BETDISPLAYTXTPOS[i].x;
				txt.y = BETDISPLAYTXTPOS[i].y;
				_betDisplayTxtPool[i] = txt;
				addChild(_betDisplayTxtPool[i]);
			}
			
			_infoBtn = new GameBtn("greenBtn-01","greenBtn-02","infoString","greenBtn-03");
			_infoBtn.addEventListener(Event.TRIGGERED,onTrigger);
			_infoBtn.x = 27;
			_infoBtn.y = 665;
			addChild(_infoBtn);
			
			_settingBtn = new GameBtn("greenBtn-01","greenBtn-02","settingString");
			_settingBtn.addEventListener(Event.TRIGGERED,onTrigger);
			_settingBtn.x = 157;
			_settingBtn.y = _infoBtn.y;
			addChild(_settingBtn);
			
			_autoBtn = new GameBtn("greenBtn-01","greenBtn-02","autoModeSettingString","greenBtn-03");
			_autoBtn.addEventListener(Event.TRIGGERED,onTrigger);
			_autoBtn.x = 285;
			_autoBtn.y = _infoBtn.y;
			addChild(_autoBtn);
			
			_reduceBtn = new GameBtn("blueBtn-01","blueBtn-02","minus","blueBtn-03");
			_reduceBtn.addEventListener(Event.TRIGGERED,onTrigger);
			_reduceBtn.y = _infoBtn.y - 1;
			_reduceBtn.x = 410;
			addChild(_reduceBtn);
			
			_addBtn = new GameBtn("blueBtn-01","blueBtn-02","plus","blueBtn-03");
			_addBtn.addEventListener(Event.TRIGGERED,onTrigger);
			_addBtn.x = 590;
			_addBtn.y = _infoBtn.y - 1;
			addChild(_addBtn);
			
			_betBtn = new GameBtn("greenBtn-01","greenBtn-02","betString","greenBtn-03");
			_betBtn.addEventListener(Event.TRIGGERED,onTrigger);
			_betBtn.x = 650;
			_betBtn.y = _infoBtn.y;
			addChild(_betBtn);
			
			_maxBetBtn = new GameBtn("longGreenBtn-01","longGreenBtn-02","maxbetString","longGreenBtn-03");
			_maxBetBtn.addEventListener(Event.TRIGGERED,onTrigger);
			_maxBetBtn.y =_infoBtn.y - 2;
			_maxBetBtn.x = 775;
			addChild(_maxBetBtn);
			
			_startTimeTextfiled = new TextField(100,46,"0","arial",24,0xffff00,true);
			_startTimeTextfiled.hAlign = HAlign.CENTER;
			_startTimeTextfiled.touchable = false;
			_startTimeTextfiled.x = 500;
			_startTimeTextfiled.y = 665;
			addChild(_startTimeTextfiled);
			
			_slotBtn = new SlotBtn();
			_slotBtn.addEventListener(PlayGameEvent.STOPSPIN,onStopSlot);
			_slotBtn.addEventListener(PlayGameEvent.GETSCORE, onGetScore);
			_slotBtn.y = 620;
			_slotBtn.x = 950;
			addChild(_slotBtn);
			
			_slots = new Slots();
			_slots.addEventListener(PlayGameEvent.STOPSPIN, onDidEndSlotMotion);
			_slots.touchable = false;
			_slots.x = 100;
			_slots.y = 30;
			addChild(_slots);
		}
		
		private function onTrigger(event:Event):void
		{
			switch(event.currentTarget)
			{
				case _betBtn:
					refreshBetPoint(false);
					_slotBtn.setEnabled(true);
					break;
				case _maxBetBtn:
					refreshBetPoint(true);
					_slotBtn.setEnabled(true);
					break;
				case _autoBtn:
					if(!_isAuto && betpoint > 0 && Number(_startTimeTextfiled.text) > 0)
					{
						_isAuto = true;
						autoSlot();
					}
					else
					{
						_isAuto = false;
					}
					break;
				case _reduceBtn:
					var loc:int = (Number(_startTimeTextfiled.text) - 10);
					_startTimeTextfiled.text = String(loc >= 0 ? loc : 0);
					break;
				case _addBtn:
					_startTimeTextfiled.text = (Number(_startTimeTextfiled.text) + 10).toString();
					break;
				case _settingBtn:
					
					break;
				case _infoBtn:
					dispatchEvent(new PlayGameEvent(PlayGameEvent.DISPLAYINFOS));
					break;
				default:
					break;
			}
		}
		
		public function startSlot(results:Object,totalMark:int):void
		{
			_slotBtn.setEnabled(false);
			_reduceBtn.setEnabled(false);
			_addBtn.setEnabled(false);
			_betBtn.setEnabled(false);
			_maxBetBtn.setEnabled(false);
			
			setTotalPoints(totalMark);
			
			_canWinScore = results.lines.length > 0 ? true : false;
			_slots.startSlot(results);
			_slotBtn.state = 1;
			_isSloting = true;
			
			if(!_isAuto)
			{
				setTimeout(_slotBtn.setEnabled,200,true);
				_autoBtn.setEnabled(false);
			}

			_stopInterval = setTimeout(onStopSlot,2000,null);
		}
		
		private function onStopSlot(event:PlayGameEvent):void
		{
			_stopInterval = -1;
			
			_slotBtn.setEnabled(false);
			_slots.stopSlot();
		}
		
		private function onDidEndSlotMotion(event:PlayGameEvent):void
		{
			if(_canWinScore)
			{
				_slotBtn.state = 2;
				onGetScore(null);
			}
			else
			{
				_slotBtn.state = 0;
			
				if(!_isAuto)
				{
					_autoBtn.setEnabled(true);
					_reduceBtn.setEnabled(true);
					_addBtn.setEnabled(true);
					_betBtn.setEnabled(true);
					_maxBetBtn.setEnabled(true);
				}
				else
				{
					autoSlot();
				}
			}
			
			if(!_isAuto)
			{
				_slotBtn.setEnabled(true);
			}
		}
		
		private function onGetScore(event:PlayGameEvent):void
		{
			_slotBtn.setEnabled(false);
			
			var mTotalMark:int = _totalMark;
			_totalMark += betpoint*2;
			
			var t:Timer = new Timer(2);
			t.addEventListener(TimerEvent.TIMER,function(event:TimerEvent):void{
				_totalMarkTextfield.text = (++mTotalMark).toString();
				if(_totalMark == mTotalMark)
				{
					t.stop();
					t.removeEventListener(event.type,arguments.callee);
					
					_slotBtn.state = 0;
					if(!_isAuto)
					{
						_slotBtn.setEnabled(true);
						_autoBtn.setEnabled(true);
						_reduceBtn.setEnabled(true);
						_addBtn.setEnabled(true);
						_betBtn.setEnabled(true);
						_maxBetBtn.setEnabled(true);
					}
					else
					{
						autoSlot();
					}
				}
			});
			t.start();
		}
		
		public function setTotalPoints(value:Number):void
		{
			_totalMark = value;
			_totalMarkTextfield.text = value.toString();
		}
		
		private function refreshBetPoint(isMax:Boolean):void
		{
			if(!isMax)
			{
				betpoint += Settings.MIN_BET;
				
				if(betpoint > Settings.MAX_BET)
				{
					betpoint = Settings.MIN_BET;
				}
			}
			else
			{
				betpoint = Settings.MAX_BET;
			}
			
			_betTextfield.text = betpoint.toString();
			
			var mBetpoint:int = betpoint / Settings.MIN_BET;
			
			for(var i:int = 0; i < 8; i++)
			{
				_betDisplayTxtPool[i].text = mBetpoint.toString();
			}
			
		}
		
		private function autoSlot():void
		{
			var repeatCount:int = Number(_startTimeTextfiled.text)
			if(repeatCount > 0)
			{
				dispatchEvent(new PlayGameEvent(PlayGameEvent.STARTSPIN,true));
				_startTimeTextfiled.text = String(--repeatCount);
			}
			else
			{
				_isAuto = false;
				_slotBtn.setEnabled(true);
				_autoBtn.setEnabled(true);
				_reduceBtn.setEnabled(true);
				_addBtn.setEnabled(true);
				_betBtn.setEnabled(true);
				_maxBetBtn.setEnabled(true);
			}
		}
		
		override public function dealloc():void
		{
			
			super.dealloc();
		}
	}
}