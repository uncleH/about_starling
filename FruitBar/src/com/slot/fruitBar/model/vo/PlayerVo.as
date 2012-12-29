package com.slot.fruitBar.model.vo
{
	public class PlayerVo
	{
		public var uid:String;
		public var nickName:String;
		public var points:Number;
		public var bringPoints:int;
		public var betPoints:int;
		public var winScore:Number;
		
		public function PlayerVo(uid:String, nickName:String = "", points:Number = 0)
		{
			if(uid != null)
			{
				this.uid = uid;
			}
			
			if(nickName != null)
			{
				this.nickName = nickName;
			}
			
			this.points = points;
		}
	}
}