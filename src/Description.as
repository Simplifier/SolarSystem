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

			addText(labelformat, 'Planet:', 9, 11);
			addText(tformat, planet, 70, 11);

			addText(labelformat, 'Owner:', 9, 31);
			addText(tformat, owner, 70, 31);

			addText(labelformat, 'Alliance:', 9, 51);
			addText(tformat, alliance, 70, 51);
		}

		private function addText(format:TextFormat, text:String, x:int, y:int):TextField {
			var tf:TextField = new TextField;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.defaultTextFormat = format;
			tf.mouseEnabled = false;
			tf.embedFonts = true;
			tf.text = text;
			tf.x = x;
			tf.y = y;
			addChild(tf);
			return tf;
		}
	}
}