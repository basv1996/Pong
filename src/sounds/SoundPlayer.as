package sounds 
{
	import flash.media.Sound;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import screens.*;
	import actors.Ball;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class SoundPlayer 
	{
		private var _sounds:Array = [];
		private var _channel:SoundChannel;
		private var _main:Main;
		public function SoundPlayer(main:Main):void
		{
			_main = main;			
			loadSound("../lib/a gladioles game.mp3");
			loadSound("../lib/again the same song.mp3");
			loadSound("../lib/Queens Park Raisins.mp3");
			loadSound("../lib/running behind the facts.mp3");
			loadSound("../lib/running behind the facts.mp3");
			loadSound("../lib/to lay a ginger on it.mp3");
			loadSound("../lib/pong.mp3");			
			loadSound("../lib/pong2.mp3");				
			loadSound("../lib/lose.mp3");	
			loadSound("../lib/intro.mp3");	
						
			
			_main.addEventListener(GameScreen.GAME_OVER, onGameOver, true);
			_main.addEventListener(IntroScreen.START_GAME, onIntro, true);
			_main.addEventListener(GameScreen.BALL_BOUNCE_LEFT, LEFT, true);
			_main.addEventListener(GameScreen.BALL_BOUNCE_RIGHT, RIGHT, true);
			_main.addEventListener(Ball.OUTSIDE_RIGHT, RECHTSWEG, true);
			_main.addEventListener(Ball.OUTSIDE_LEFT, LINKSWEG, true);
		}
		
			
		private function RECHTSWEG(e:Event):void 
		{
			playSound(Math.floor(Math.random() * 6));
		}
		
		private function LINKSWEG(e:Event):void 
		{
			playSound(Math.floor(Math.random() * 6));
		}
		
		private function onIntro(e:Event):void 
		{
			playSound(9);
		}
		
		private function onGameOver(e:Event):void 
		{
			playSound(8);
		}		
		private function LEFT(e:Event):void 
		{
			playSound(6);
			trace("links geeft geluid")
		}
		private function RIGHT(e:Event):void 
		{
			playSound(7);
			trace("geluid rechts werkt")
		}
		
		
		
		private function loadSound(file:String):void
		{
			_sounds.push(new Sound(new URLRequest(file)));
				
		}
		private function playSound(index:int, loops:int = 1, volume:Number = 1, pan:Number = 0):void
		{
			if (index > _sounds.length - 1)
			{
				trace("referenced sound is not loaded");				
			}
			else
			{			
				var transform:SoundTransform = new SoundTransform(volume, pan);
				_channel = _sounds[index].play(0,loops);
			}			
		}	
		
	}

}