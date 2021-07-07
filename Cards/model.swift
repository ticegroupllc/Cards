//
//  model.swift
//  Cards
//
//  Created by Developer on 10/18/20.
//

import Foundation

struct Card:Identifiable{
    var name:String?
    var flipped:Bool?
    var id = UUID()
    var seq: Int!
    var matched:Bool = false
    var match: Int!
}
/*
class Card:Identifiable, ObservableObject{
    
    //static var shared = Card()
    var name:String?
    var flipped:Bool?
    var id = UUID()
    
   
}*/

class CardSet: ObservableObject{
    static var shared = CardSet()
    @Published var cards = [Card]()
    var cardsAreSet:Bool = false
    var flippedCard1Seq:Int = 1000000
    var flippedCard2Seq:Int = 1000000
    var numberOfPairs:Int = 0
    var gameWon:Bool = false
    var gameStarted:Bool = false
    var score:Int = 0
    var countdown:String = ""
    
    }
    


