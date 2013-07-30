package com.gread.denom.model{
	/*
	StatusController Class
	Controller for status display
	*/
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import org.osflash.signals.Signal;
	
	public class ApplicationModel{
	
		private var _status:GameStatusVO = new GameStatusVO(); 
		
		public var gameTallyChanged:Signal;
		
		/* constructor function */
		public function ApplicationModel(){
			gameTallyChanged = new Signal();
		}
		
		/*
		function gameLost()
		handle a game series lost
		*/
		public function gameLost():void{
			_status.lost++;
			_status.numGames++;
			sendStatus();
		}
		
		/*
		function gameLost()
		handle a game series won
		*/
		public function gameWon():void{
			_status.won++;
			_status.numGames++;
			sendStatus();
		}
		
		/*
		function sendStatus()
		iterate level if needed, dispatch status 
		*/
		private function sendStatus():void{
			// series of games per level is four.
			if(_status.numGames % 4 == 0){
				_status.level++;
			}
			// last level is 4, after reset back to level 1.
			if(_status.level > 4){
				_status = new GameStatusVO();
			}
			gameTallyChanged.dispatch( { status: _status } );
		}
		
		/*
		function status()
		getter for status
		*/
		public function get status():GameStatusVO
		{
			return _status;
		}
		
		/*
		function status()
		setter for status - dispatch status change
		*/
		public function set status(value:GameStatusVO):void
		{
			_status = value;
			
			gameTallyChanged.dispatch( { status: _status } );
		}


	}
}