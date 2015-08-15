package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Alex
	 */
	[Event(name="select", type="flash.events.Event")]
	public class Menu extends Sprite {
		
		public function Menu(items:Array/*String*/) {
			var pos:int = 10;
			for each(var label:String in items) {
				var item:Item = new Item(label);
				item.y = pos;
				addChild(item);
				pos += 40;
				item.addEventListener(MouseEvent.CLICK, item_clickHandler);
			}
			
			graphics.lineStyle(1, 0x87d1ff);
			graphics.beginFill(0x2139);
			graphics.drawRect(0, 0, 165, height + 15);
		}
		
		private function item_clickHandler(e:MouseEvent):void {
			dispatchEvent(new Event(Event.SELECT));
		}
	}
}

import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
class Item extends Sprite {
	private var tformat:TextFormat = new TextFormat('Arial', 13, 0x0a5c94, true);
	private var back:Shape = new Shape;
	private var tf:TextField = new TextField;
	
	public function Item(text:String) {
		buttonMode = true;
		graphics.beginFill(0, 0);
		graphics.drawRect(0, 0, 165, 32);
		
		back.graphics.beginFill(0x3e7aa3);
		back.graphics.drawRect(1, 0, 163, 32);
		back.visible = false;
		addChild(back);
		
		tf.autoSize = TextFieldAutoSize.LEFT;
		tf.defaultTextFormat = tformat;
		tf.mouseEnabled = false;
		tf.embedFonts = true;
		tf.text = text;
		tf.x = width / 2 - tf.width / 2;
		tf.y = height / 2 - tf.height / 2;
		addChild(tf);
		
		addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
		addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
	}
	
	private function rollOverHandler(e:MouseEvent):void {
		back.visible = true;
		tf.textColor = 0xffffff;
		e.updateAfterEvent();
	}
	
	private function rollOutHandler(e:MouseEvent):void {
		back.visible = false;
		tf.textColor = 0x0a5c94;
		e.updateAfterEvent();
	}
}