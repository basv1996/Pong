package actors 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Bas Vugts
	 */
	public class Paddle extends MovieClip 
	{
		
		public function Paddle() 
		{
			addChild(new PaddleArt());
		}
		
	}

}