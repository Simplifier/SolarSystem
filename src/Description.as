package  {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class Description extends Sprite {
		private var labelformat:TextFormat = new TextFormat('Arial', 13, 0x396281);
		private var tformat:TextFormat = new TextFormat('Arial', 13, 0x519bce);
		
		public function Description(planet:String, owner:String, alliance:String) {
			graphics.lineStyle(1, 0x87d1ff);
			graphics.beginFill(0x2139);
			graphics.drawRect(0, 0, 170, 80);
			mouseEnabled = false;
			
			var planetLabel:TextField = createText(labelformat, 'Planet:');
			planetLabel.x = 9;
			planetLabel.y = 11;
			addChild(planetLabel);
			
			var planetField:TextField = createText(tformat, planet);
			planetField.x = 70;
			planetField.y = 11;
			addChild(planetField);
			
			var ownerLabel:TextField = createText(labelformat, 'Owner:');
			ownerLabel.x = 9;
			ownerLabel.y = 31;
			addChild(ownerLabel);
			
			var ownerField:TextField = createText(tformat, owner);
			ownerField.x = 70;
			ownerField.y = 31;
			addChild(ownerField);
			
			var allianceLabel:TextField = createText(labelformat, 'Alliance:');
			allianceLabel.x = 9;
			allianceLabel.y = 51;
			addChild(allianceLabel);
			
			var allianceField:TextField = createText(tformat, alliance);
			allianceField.x = 70;
			allianceField.y = 51;
			addChild(allianceField);
		}
		
		private function createText(format:TextFormat, text:String):TextField {
			var tf:TextField = new TextField;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.defaultTextFormat = format;
			tf.mouseEnabled = false;
			tf.embedFonts = true;
			tf.text = text;
			return tf;
		}
	}
}