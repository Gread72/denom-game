package com.gread.denom.model{
	/*
	GameStatusVO Class
	value object for value object
	*/
	
	public class GameStatusVO{
		
		public var numGames:Number;
		public var lost:Number;
		public var won:Number;
		public var level:Number;
		
		public function GameStatusVO(numGamesVal:Number = 0, lostVal:Number = 0, wonVal:Number = 0, levelVal:Number = 1){
			numGames = numGamesVal;
			lost = lostVal;
			won = wonVal;
			level = levelVal;
		}
	}
}