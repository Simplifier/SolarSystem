package {
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Alex
	 */
	public class SolarSystem extends Sprite {
		[Embed(systemFont = "Arial", fontName = "Arial", fontWeight="normal", fontStyle="normal", unicodeRange = "U+0020-007F, U+00A0-00BF, U+0401, U+0410-0451, U+2012-201F", advancedAntiAliasing = "true", embedAsCFF = "false", mimeType = "application/x-font")]
		private var font:Class;
		[Embed(systemFont = "Arial", fontName = "Arial", fontWeight = 'bold', fontStyle="normal", unicodeRange = "U+0020-007F, U+00A0-00BF, U+0401, U+0410-0451, U+2012-201F", advancedAntiAliasing = "true", embedAsCFF = "false", mimeType = "application/x-font")]
		private var bold:Class;
		
		private var systemContainer:Sprite = new Sprite;
		private var orbits:Vector.<Orbit> = new Vector.<Orbit>;
		private var description:Description;
		private var pausedOrbit:Orbit;
		private var overedPlanet:Planet;
		private var planetMenu:Menu = new Menu(['Trade', 'Bookmark', 'Ban']);
		
		public function SolarSystem():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var back:Loader = new Loader;
			back.load(new URLRequest('../img/back.png'));
			addChild(back);
			
			systemContainer.x = stage.stageWidth / 2;
			systemContainer.y = stage.stageHeight / 2;
			addChild(systemContainer);
			
			var sunLoader:Loader = new Loader;
			sunLoader.load(new URLRequest('../img/sun.png'));
			sunLoader.x = -116;
			sunLoader.y = -116;
			systemContainer.addChild(sunLoader);
			
			var numbers:Array/*int*/= [];
			for (var n:int = 1; n < 13; n++) numbers.push(n);
			var numberLength:int = numbers.length;
			
			var radius:int = 100;
			var rotationTime:int = 40;
			var nickLength:int = Data.NICKNAMES.length;
			var allianceLength:int = Data.ALLIANCE_NAMES.length;
			var planetLength:int = Data.PLANET_NAMES.length;
			for (var i:int = 0; i < 12; i++ ) {
				var orbit:Orbit = new Orbit(radius, rotationTime);
				systemContainer.addChild(orbit);
				orbits.push(orbit);
				orbit.addEventListener(MouseEvent.ROLL_OVER, orbit_rollOverHandler);
				orbit.addEventListener(MouseEvent.ROLL_OUT, orbit_rollOutHandler);
				
				var startAngle:int = Math.random() * 360;
				var num:int = numbers.splice(int(Math.random() * numberLength--), 1);
				
				var planet:Planet = new Planet('../img/' + num + '.png', radius, startAngle);
				planet.orbit = orbit;
				planet.owner = Data.NICKNAMES.splice(int(Math.random() * nickLength--), 1);
				planet.planetName = Data.PLANET_NAMES.splice(int(Math.random() * planetLength--), 1);
				planet.alliance = Data.ALLIANCE_NAMES.splice(int(Math.random() * allianceLength--), 1);
				orbit.addChild(planet);
				
				planet.addEventListener(MouseEvent.ROLL_OVER, planet_rollOverHandler);
				planet.addEventListener(MouseEvent.ROLL_OUT, planet_rollOutHandler);
				planet.addEventListener(MouseEvent.CLICK, planet_clickHandler);
				
				orbit.planet = planet;
				radius += 26;
				rotationTime += 20;
			}
			
			planetMenu.addEventListener(Event.SELECT, planetMenu_selectHandler);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function planetMenu_selectHandler(e:Event):void {
			pausedOrbit.paused = false;
			planetMenu.parent.removeChild(planetMenu);
		}
		
		private function planet_clickHandler(e:MouseEvent):void {
			if (planetSelected) return;
			if (description.stage) removeChild(description);
			
			var planet:Planet = Planet(e.target);
			var pos:Point = planet.position;
			planetMenu.x = pos.x - systemContainer.x;
			planetMenu.y = pos.y - systemContainer.y;
			
			var orbit:Orbit = planet.orbit;
			pausedOrbit = orbit;
			orbit.paused = true;
			systemContainer.addChild(orbit);
			orbit.addChildAt(planetMenu, 0);
		}
		
		private function planet_rollOverHandler(e:MouseEvent):void {
			if (planetSelected) return;
			
			var planet:Planet = Planet(e.target);
			overedPlanet = planet;
			var pos:Point = planet.position;
			description = new Description(planet.planetName, planet.owner, planet.alliance);
			description.x = pos.x + 20;
			description.y = pos.y;
			addChild(description);
			e.updateAfterEvent();
		}
		
		private function planet_rollOutHandler(e:MouseEvent):void {
			if (description.stage) removeChild(description);
			e.updateAfterEvent();
		}
		
		private function orbit_rollOverHandler(e:MouseEvent):void {
			if (planetSelected) return;
			
			var orbit:Orbit = Orbit(e.target);
			orbit.highlighted = true;
			orbit.planet.highlighted = true;
			e.updateAfterEvent();
		}
		
		private function orbit_rollOutHandler(e:MouseEvent):void {
			if (planetSelected) return;
			
			var orbit:Orbit = Orbit(e.target);
			orbit.highlighted = false;
			orbit.planet.highlighted = false;
			e.updateAfterEvent();
		}
		
		private function update(e:Event):void {
			if (description && description.stage) {
				var pos:Point = overedPlanet.position;
				description.x = pos.x + 20;
				description.y = pos.y;
			}
			for each(var orbit:Orbit in orbits) {
				orbit.update();
			}
		}
		
		private function get planetSelected():Boolean {
			return Boolean(planetMenu.stage);
		}
	}
}