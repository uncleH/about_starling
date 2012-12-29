package com.slot.fruitBar.test
{
	import com.slot.fruitBar.model.vo.DeskVo;

	public class AI
	{
		/**机台的数量*/
		private static const COUNTOFDESK:int = 27;
		
		/**最大下注点数*/
		private static const MAX_BET:int = 80;
		
		/**最小下注点数*/
		private static const MIN_BET:int = 8;
		
		private static const BET_RATE:Number = 9;
		
		public function AI()
		{
		}
		
		/**生成机台*/
		public function createDesk():Vector.<DeskVo>
		{
			var data:Vector.<DeskVo> = new Vector.<DeskVo>(COUNTOFDESK,true);
			var desk:DeskVo;
			
			for(var i:int = 0; i < COUNTOFDESK; i++)
			{
				desk = new DeskVo();
				desk.id = i + 1;
				desk.maxBet = MAX_BET;
				desk.minBet = MIN_BET;
				desk.betRate = BET_RATE;
				desk.minBringPoint = 8;
				data[i] = desk;
			}
			return data;
		}
		
		public function createPattern(betpoint:int):Object
		{
			var data:Object = {};
			var patterns:Array = [
				Math.ceil(Math.random()*8),Math.ceil(Math.random()*8),Math.ceil(Math.random()*8),Math.ceil(Math.random()*8),
				Math.ceil(Math.random()*8),Math.ceil(Math.random()*8),Math.ceil(Math.random()*8),Math.ceil(Math.random()*8),Math.ceil(Math.random()*8)
			];
			
			data.patterns = patterns;
			data.lines = [];
			data.results = [];
			
			//中间行
			if((patterns[0] == patterns[1]) && (patterns[0] == patterns[2]))
			{
				data.lines.push(0);
				data.results.push(0);
				data.results.push(1);
				data.results.push(2);
			}
			else if(patterns[0] == 9)
			{
				data.lines.push(0);
				data.results.push(0);
				
				if(patterns[1] == 9)
				{
					data.results.push(1);
				}
			}
			
			//最下面一行
			if(patterns[3] == patterns[4] && patterns[3] == patterns[5])
			{
				data.lines.push(1);
				data.results.push(3);
				data.results.push(4);
				data.results.push(5);
			}
			
			if(patterns[3] == patterns[1] && patterns[3] == patterns[8])
			{
				data.lines.push(2);
				data.results.push(3);
				data.results.push(1);
				data.results.push(8);
			}
			
			if((data.lines as Array).indexOf(1) == -1 && (data.lines as Array).indexOf(2) == -1 && patterns[3] == 9)
			{
				data.lines.push(1);
				data.results.push(3);
				if(patterns[4] ==  9)
				{
					data.results.push(4);
				}
			}
						
			//最上面一行
			if(patterns[6] == patterns[7] && patterns[6] == patterns[8])
			{
				data.lines.push(3);
				data.results.push(6);
				data.results.push(7);
				data.results.push(8);
			}
			
			if(patterns[6] == patterns[1] && patterns[6] == patterns[5])
			{
				data.lines.push(4);
				data.results.push(6);
				data.results.push(1);
				data.results.push(5);
			}
			
			if(patterns[6] == patterns[0] && patterns[6] == patterns[3])
			{
				data.lines.push(5);
				data.results.push(6);
				data.results.push(0);
				data.results.push(3);
			}
			
			if(data.lines.indexOf(3) == -1 && data.lines.indexOf(4) == -1 && data.lines.indexOf(5) == -1
					&& patterns[6] == 9)
			{
				data.lines.push(3);
				data.lines.push(4);
				data.lines.push(5);
				data.results.push(6);
				
				if(patterns[7] == 9)
				{
					data.results.push(7);
				}
				
				if(patterns[1] == 9)
				{
					data.results.push(1);
				}
				
				if(patterns[0] == 9)
				{
					data.results.push(0);
				}
			}
			
			var countOfResults:int = Math.floor(data.results.length * 0.5);
			for(var i:int = 0; i < countOfResults; i++)
			{
				var index:int = (data.results as Array).lastIndexOf(data.results[i]);
				if(index != i)
				{
					(data.results as Array).splice(index,1);
				}
			}
			
			return data;
		}
		
	}
}