package com.slot.fruitBar.model.vo
{
	/**机台数据设置*/
	public class DeskVo
	{
		/**机台ID*/
		public var id:int;
		
		/**机台状态：0选择，1保留，2其他玩家保留*/
		public var state:int;
		
		/**比率*/
		public var betRate:Number;
		
		/**最大下注*/
		public var maxBet:int;
		
		/**最小下注*/
		public var minBet:int;
		
		/**最低带入点数*/		
		public var minBringPoint:int;
		
		public function DeskVo()
		{
		}
	}
}