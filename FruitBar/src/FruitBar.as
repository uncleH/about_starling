package
{
	import com.slot.fruitBar.controller.GameViewController;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	[SWF(frameRate="60",width="1280",height="720")]
	public class FruitBar extends Sprite
	{
		public function FruitBar()
		{
			addEventListener(flash.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:flash.events.Event):void
		{
			removeEventListener(event.type,onAddedToStage);
			initializeStarling();
		}
		
		private function initializeStarling():void
		{
			var mStarling:Starling = new Starling(GameViewController,stage,new Rectangle(0,0,stage.stageWidth,stage.stageHeight));
			mStarling.showStatsAt("right","bottom");
			mStarling.stage.addEventListener(starling.events.Event.RESIZE,function(event:starling.events.Event):void
			{
				mStarling.viewPort = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
			});
			mStarling.start();
		}
	}
}