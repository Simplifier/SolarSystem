package  {
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Alex
	 */
	public class Planet extends Sprite {
		private var planet:Loader;
		private var halo:Shape = new Shape;
		private var hole:Shape;
		private static var zeroPoint:Point = new Point;
		
		public var orbit:Orbit;
		public var planetName:String;
		public var owner:String;
		public var alliance:String;
		
		public function Planet(skinURL:String, orbitRadius:int, startAngle:int) {
			mouseChildren = false;
			planet = new Loader;
			planet.load(new URLRequest(skinURL));
			planet.x = orbitRadius * Math.cos(startAngle * Math.PI / 180);
			planet.y = orbitRadius * Math.sin(startAngle * Math.PI / 180);
			
			hole = new Shape;
			hole.graphics.beginFill(0, 1);
			hole.graphics.drawCircle(0, 0, 15);
			hole.blendMode = BlendMode.ERASE;
			hole.visible = false;
			hole.x = planet.x;
			hole.y = planet.y;
			
			halo.graphics.lineStyle(3, 0x55B7F2);
			halo.graphics.drawCircle(0, 0, 15);
			halo.x = planet.x;
			halo.y = planet.y;
			halo.visible = false;
			
			addChild(hole);
			addChild(planet);
			addChild(halo);
			
			planet.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_completeHandler);
		}
		
		private function loader_completeHandler(e:Event):void {
			var img:Bitmap = e.target.content;
			img.smoothing = true;
			img.x = -img.width / 2;
			img.y = -img.height / 2;
		}
		
		public function set highlighted(value:Boolean):void {
			halo.visible = value;
			hole.visible = value;
		}
		
		public function get highlighted():Boolean {
			return halo.visible;
		}
		
		public function get position():Point {
			return planet.localToGlobal(zeroPoint);
		}
	}
}