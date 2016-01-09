package screens 
{
	import actors.AI;
	import actors.Ball;
	import actors.Obstacle;
	import actors.Paddle;
	import actors.Player;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import utils.MovementCalculator;
	import screens.Scoreboard;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Bas Vugts
	 */
	public class GameScreen extends Screen
	{
		private var balls:Array = [];
		private var paddles:Array = [];
		private var obstacles:Array=  [];
		private var scoreboard:Scoreboard;
		static public const GAME_OVER:String = "game over";
		//static public const BALL_BOUNCE:String = "ballBounce";
		static public const BALL_BOUNCE_LEFT:String = "ballBounce";
		static public const BALL_BOUNCE_RIGHT:String = "ballBounce";
		static private const TEN_BOUNCE:String = "10_BOUNCE";
		public function GameScreen() 
		{

			this.addEventListener(Event.ADDED_TO_STAGE, init);			
		}				
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
				for (var i:int = 0; i < 1; i++) 
			{
				balls.push(new Ball());
				addChild(balls[i]);
				balls[i].reset();
				
				balls[i].addEventListener(Ball.OUTSIDE_RIGHT, onRightOut);
				balls[i].addEventListener(Ball.OUTSIDE_LEFT, onLeftOut);
				
			}	
			//paddles.push(new AI());
			paddles.push(new Player(Keyboard.UP,Keyboard.DOWN,Keyboard.LEFT));
			paddles.push(new Player(Keyboard.W,Keyboard.S,Keyboard.E));
			//paddles[0].balls = balls;
			for (i = 0; i < 2; i++) 
			{
				
				addChild(paddles[i]);
				paddles[i].y = stage.stageHeight / 2;
			}	
			paddles[0].x = stage.stageWidth - 100;
			
			paddles[1].x = 100;
			
			scoreboard = new Scoreboard();
			addChild(scoreboard);
			
			this.addEventListener(Event.ENTER_FRAME, loop);
			this.addEventListener(TEN_BOUNCE, createObstacle);
		}		
		
		private function loop(e:Event):void 
		{
			checkCollision();
			
		}	
		
		function createObstacle(e:Event):void
		{
			//obstacle maken
			
			trace("new obstacle");
			obstacles.push(new ObstacleArt);
			obstacles[obstacles.length - 1].x = stage.stageWidth * Math.random();
			obstacles[obstacles.length - 1].y = stage.stageHeight * Math.random();
			addChild(obstacles[obstacles.length-1]);
			
			
		}
		private var bounces:int = 0;
		private function checkBounces():void 
		{
			bounces++;
			if (bounces > 1) 
			{
				dispatchEvent(new Event(TEN_BOUNCE));
				bounces = 0;
			
			}
		}
		private function checkCollision():void 
		{
			for (var i:int = 0; i < balls.length; i++) 
			{
				for (var j:int = 0; j < paddles.length; j++) 
				{
					if (paddles[0].hitTestObject(balls[i]))
					{
						dispatchEvent(new Event(BALL_BOUNCE_LEFT));
						trace(" ball links bounce werkt")
						checkBounces();
						
					}
					if (paddles[1].hitTestObject(balls[i]))
					{
						dispatchEvent(new Event(BALL_BOUNCE_RIGHT));
							trace(" ball rechts bounce werkt")
							checkBounces();
					}
					
					
					if (paddles[j].hitTestObject(balls[i]))
 					{
 						balls[i].xMove *= -1;
						var dir:Number = balls[i].xMove / Math.abs(balls[i].xMove);
						while (paddles[j].hitTestObject(balls[i]))
						{
							balls[i].x += dir;
							
						}
						
 						balls[i].x += balls[i].xMove / 2;
 						
 					//	dispatchEvent(new Event(BALL_BOUNCE));
					}
					

					
					
 					
					
					
				}
			}
			
		}
		
	
		private function onLeftOut(e:Event):void 
		{
			var b:Ball = e.target as Ball;
			b.reset();
			
			scoreboard.player2 += 1;
			
			checkScore();
		}		
		private function onRightOut(e:Event):void 
		{
			var b:Ball = e.target as Ball;
			b.reset();
			scoreboard.player1 += 1;
			
			
			checkScore();
		}		
		
		private function checkScore():void 
		{
			if (scoreboard.player1 >= 10 || scoreboard.player2 >= 10)
			{
				destroy();
				dispatchEvent(new Event(GAME_OVER));
				trace("checkSore is klaar");
				
			}
			
		}
			
		private function destroy():void
		{
			for (var i:int = 0; i < balls.length; i++) 
			{
				balls[i].destroy();
				removeChild(balls[i]);
			}
			balls.splice(0, balls.length);
		}
	}

}