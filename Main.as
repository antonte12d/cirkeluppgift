package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;

	
	public class Main extends Sprite 
	{
		
		private var blueCircles:Vector.<Sprite> = new Vector.<Sprite>();
		private const CIRCLE_RADIUS:int = 20;
		
		private var points:int;
		private var text:TextField = new TextField;
		private var result:TextField = new TextField;
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			stage.addEventListener(Event.ENTER_FRAME, gametime);			//Lyssnare som ständigt räknar mina cirklar
			stage.addEventListener(KeyboardEvent.KEY_DOWN, gameloop);		//Sätter lyssnare på space-knappen
			stage.addEventListener(MouseEvent.CLICK, circleClick);			//Lyssnare på om en cirkel blir klickad
			
			addChild(text);													//Lägger till mina texter på scenen!
			addChild(result);
			
			result.x = 350;													//Placerar resultattexten!
			result.y = 250;
			
			result.visible = false;											//Gör resultatet osynligt från början så att den endast syns när den ska!
		}
		
		private function gameloop(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.SPACE) 								//Restartar spelet!
			{
				if (blueCircles.length > 0) {
					for (var k:int = 0; k < blueCircles.length; k++) {
						removeChild(blueCircles[k]);
						points = 0;
					}
					blueCircles.length = 0;
				}
				for (var i:int = 0; i < 20; i++) 							//Spawnar alla cirklar
				{
					var blueCircle:Sprite = new Sprite();
					blueCircle.graphics.beginFill(0x0000FF);
					blueCircle.graphics.drawCircle(Math.random() * (stage.stageWidth - CIRCLE_RADIUS * 4) + CIRCLE_RADIUS * 2, Math.random() * (stage.stageHeight - CIRCLE_RADIUS * 4) + CIRCLE_RADIUS * 2, CIRCLE_RADIUS);
					blueCircle.graphics.endFill();
					blueCircles.push(blueCircle);
					addChild(blueCircle);
					
					points = 0; 											//nollställer poängen.
					
					result.visible = false;									//"Tar bort" score resultatet så det inte syns i nästa spel!
				}
			}
		}
		
		private function circleClick(e:MouseEvent):void 
		{
			
			for (var i:int = 0; i < blueCircles.length; i++) 				//Tar bort cirkeln man klickar på och ger poäng!
			{
				if (e.target == blueCircles[i] && e.target != blueCircles[0]) 
				{
					points ++;
					removeChild(blueCircles[i]);
					blueCircles.splice(i, 1);
				}
			}
			
			if (e.target == blueCircles[0]) 								//Skapar en dödscirkel och visar slutresultatet.
			{
				while (blueCircles.length > 0) 
				{
					removeChild(blueCircles[0]);
					blueCircles.splice(0, 1);
					result.visible = true;
				}
			}
		}
		
		private function gametime(e:Event):void 							//Tilldelar värden på mina texter samt räknar cirklar.
		{
			text.text = "Om du är för lat för att räkna så har du nu klickat på " + String(points) + " Cirklar!" + "\n" + "Idiot..";
			text.wordWrap = true;
			
			if (points >= 5) 
			{
				result.text = "Your score is " + String(points) + " \n" + "Great job!";
			}
			else if (points >= 13) 
			{
				result.text = "Your score is " + String(points) + "\n" + "You can do better!" + "\n" + "Keep on going!";
			}
			else if (points >= 17) 
			{
				result.text = "Your score is " + String(points) + "\n" + "Dude you suck!";
			}
		}
		
		
		
	}
	
}