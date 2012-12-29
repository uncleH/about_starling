package com.slot.fruitBar.view.ui
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	/**UI资源管理*/
	public class Assets
	{
		private static var textureDictionary:Dictionary;
		private static var textureAtlas:TextureAtlas;
		
		[Embed(source="../../../../../../assets/deskLobbyBG.png")]
		public static const DESKLOBBYBG:Class;
		
		[Embed(source="../../../../../../assets/playGameBg.png")]
		public static const PLAYGAMEBG:Class;
		
		[Embed(source="../../../../../../assets/playGameBg2.png")]
		public static const PLAYGAMEBG2:Class;
		
		[Embed(source="../../../../../../assets/alertBg.png")]
		public static const ALERTBG:Class;
		
		[Embed(source="../../../../../../assets/jp.png")]
		public static const SIDEBARJP:Class;
		
		[Embed(source="../../../../../../assets/jpLine.png")]
		public static const JPLINE:Class;
		
		[Embed(source="../../../../../../assets/playGameAtlas.png"]
		public static const ATLAS_PNG:Class;
		
		[Embed(source="../../../../../../assets/playGameAtlas.xml", mimeType="application/octet-stream")]
		public static const ATLAS_XML:Class;
		
		[Embed(source="../../../../../../assets/infos-01.png")]
		public static const INFOS_1:Class;
		
		[Embed(source="../../../../../../assets/infos-02.png")]
		public static const INFOS_2:Class;

		[Embed(source="../../../../../../assets/infos-03.png")]
		public static const INFOS_3:Class;

		[Embed(source="../../../../../../assets/infos-04.png")]
		public static const INFOS_4:Class;

		[Embed(source="../../../../../../assets/infos-05.png")]
		public static const INFOS_5:Class;

		[Embed(source="../../../../../../assets/infos-06.png")]
		public static const INFOS_6:Class;
		
		[Embed(source="../../../../../../assets/infosBg.png")]
		public static const INFOSBG:Class;

		[Embed(source="../../../../../../assets/desk-1.png")]
		public static const DESKITEM:Class;
		
		public function Assets()
		{
		}
	
		public static function getTexture(name:String, isRecreat:Boolean = false,isGenerateMipmap:Boolean = false):Texture
		{
			if(textureDictionary == null)
			{
				textureDictionary = new Dictionary();
			}
			
			if(isRecreat || textureDictionary[name] == null)
			{
				textureDictionary[name] = Texture.fromBitmap(new Assets[name](),isGenerateMipmap);
			}
			return textureDictionary[name];
		}
		
		public static function getTextureAtlas():TextureAtlas
		{
			if(textureAtlas == null)
			{
				var mTexture:Texture = Texture.fromBitmap(new Assets["ATLAS_PNG"]() as Bitmap);
				var mXml:XML = XML(new Assets["ATLAS_XML"]());
				textureAtlas = new TextureAtlas(mTexture,mXml);
			}
			return textureAtlas;
		}
		
	}
}