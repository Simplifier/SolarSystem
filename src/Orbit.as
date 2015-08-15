package  {
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class Orbit extends Sprite {
		private var radius:int;
		private var delta:Number;
		private var content:Sprite = new Sprite;
		private var _paused:Boolean;
		
		public var planet:Planet;
		
		public function Orbit(radius:int, rotationTime:int) {
			this.radius = radius;
			delta = 360 / (rotationTime * 60);
			buttonMode = true;
			blendMode = BlendMode.LAYER;
			super.addChild(content);
			
			var hit:Shape = new Shape;
			hit.graphics.lineStyle(24, 0, 0);
			hit.graphics.drawCircle(0, 0, radius);
			super.addChild(hit);
			
			graphics.lineStyle(0, 0x55B7F2, .5);
			graphics.drawCircle(0, 0, radius);
		}
		
		override public function addChild(child:DisplayObject):DisplayObject {
			return content.addChild(child);
		}
		
		public function update():void {
			if (paused) return;
			content.rotation += delta;
		}
		
		public function set highlighted(value:Boolean):void {
			graphics.clear();
			if (value) {
				graphics.lineStyle(3, 0x55B7F2);
				graphics.drawCircle(0, 0, radius);
			}else {
				graphics.lineStyle(0, 0x55B7F2, .5);
				graphics.drawCircle(0, 0, radius);
			}
		}
		
		public function get paused():Boolean {
			return _paused;
		}
		
		public function set paused(value:Boolean):void {
			_paused = value;
		}
	}
}