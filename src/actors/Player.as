package actors 
{
	import utils.Controller;	
	import flash.events.Event;
	import flash.ui.*;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Player extends Paddle 
	{
		private var controller:Controller;
		private var speed:Number = 0;
		private var maxSpeed:Number = 20;
		private var _up:Number;
		private var _down:Number;
		private var _fire:Number;
		
		public function Player(up:Number, down:Number, fire:Number) 
		{
			_up = up;
			_down = down;
			_fire = fire;
			this.addEventListener(Event.ADDED_TO_STAGE, init);		
		}		
		private function init(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			controller = new Controller(stage, _up,_down,_fire);
			this.addEventListener(Event.ENTER_FRAME, loop);	
			this.addEventListener(Event.REMOVED_FROM_STAGE, remove);	
		}
		private function loop(e:Event):void 
		{
			if (controller.up)
			{
				speed = -maxSpeed;
			}
			else if(controller.down)
			{
				speed = maxSpeed;
			}else
			{
				if (speed > 0) speed--;
				if (speed < 0) speed++;
				
			}
			if (controller.fire)
			{
				
				
			}
			if (this.y < 0) this.y = 0;4
			if (this.y > stage.stageHeight) this.y = stage.stageHeight;
		
 			this.y += speed;
			
			
 		}
 		public function remove(e:Event):void
		{
			this.removeEventListener(Event.ENTER_FRAME, loop);	
		}
 	}
		

}