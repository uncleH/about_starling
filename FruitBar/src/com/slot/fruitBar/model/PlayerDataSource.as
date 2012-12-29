package com.slot.fruitBar.model
{
	import com.slot.fruitBar.model.vo.PlayerVo;

	/**
	 * 玩家信息数据源
	 * 
	 */	
	public class PlayerDataSource
	{
		public static var data:PlayerVo;
		
		public function PlayerDataSource()
		{
		}
		
		public static function setBringpoints(value:int):void
		{
			data.bringPoints = value;
			data.points -= value;
		}
		
		public static function setBetpoints(value:int):void
		{
			data.betPoints = value;
			data.bringPoints -= value;
		}
		
		public static function reCountPoint():void
		{
			data.points += data.bringPoints;
			data.bringPoints = data.betPoints = 0;
		}
	}
}