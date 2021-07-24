//
//  viewmodel.swift
//  Cards
//
//  Created by Developer on 10/18/20.
//

import Foundation
class gameObject: ObservableObject{
    
    
    //var Shared = gameObject()
    
    @Published var cardSet = [Card]()
    
    static var shared = gameObject()
    
    init(){
        //cardSet = Array<Card>()
        //cardSet = setcards()
    }
    let cardDecks:[String] = ["moji", "vizsla", "cat"]
    let cardCount:[String] = ["5","10","20","30"]
    
    func setcards() -> [Card]{
        //print("setcardscard")
        print("CardDeck set to:", CardSet.shared.cardDeck)
        print("Number of cards set to:", CardSet.shared.numberOfCardsToPlay)
        var cardnames:[String] = []
        if CardSet.shared.cardDeck == "moji"{
            let cardMojiSet = ["😀","🙎🏼","🧚🏼‍♀️","🦑","🦜","🐃","🦔","🦐","🐠","🐯","🐼","🦖","🦬","🦥","🦦","🦫","🦡","🦩","🐉","🦍","🦒","🦧","🦣","🦈","🐊","🐅","🦂","🐌"]
            CardSet.shared.cardImages = false
            for i in 0...CardSet.shared.numberOfCardsToPlay - 1{
                cardnames.append(cardMojiSet[i])
            }
        }
        if CardSet.shared.cardDeck == "vizsla"{
            let VizslaSet = ["IMG_0504", "IMG_1805","IMG_1959","IMG_8953","IMG_9575"]
            CardSet.shared.cardImages = true
            for i in 0...CardSet.shared.numberOfCardsToPlay - 1{
                cardnames.append(VizslaSet[i])
            }
        }
        print("Cardnames are:",cardnames)
        var newcard = Card()
        var newcardMatch = Card()
        var newcardSet = [Card]()//
        //let existingcardSet = CardSet.shared.cards
        var arrayvalue:Int = 0
        if (CardSet.shared.cardsAreSet == false){
            let array = Array.generateRandom(size: 100)
            print(array)
            for name in cardnames{
            
                newcard.name = name
                newcard.flipped = false
                newcard.id = UUID()
                newcard.seq = array[arrayvalue]
                newcard.match = array[arrayvalue+1]
                newcard.matched = false
                
                
                newcardMatch.name = name
                newcardMatch.flipped = false
                newcardMatch.id = UUID()
                newcardMatch.seq = array[arrayvalue+1]
                newcardMatch.match = array[arrayvalue+1]
                newcardMatch.matched = false
                
               
                newcardSet.append(newcard)
                newcardSet.append(newcardMatch)
                
                arrayvalue = arrayvalue + 2
                
            }
            CardSet.shared.numberOfPairs = cardnames.count
            CardSet.shared.cardsAreSet = true
            
            CardSet.shared.cards = newcardSet.sorted(by: { $0.seq! < $1.seq! })
            enumerateCards(cards: CardSet.shared.cards)
        }
       return CardSet.shared.cards
    }
    
    func getcards() ->[Card]{
        return CardSet.shared.cards
    }
    
    func flipcard(tappedCard:Card){
        //if checkNumberOfCardsFlipped() < 2 {
        print("updatecard")
        if checkNumberOfCardsFlipped() < 2 {
            for index in CardSet.shared.cards.indices{
                print("index: ",index)
                print("CardSet.shared.cards[index].id: ",CardSet.shared.cards[index].id)
                print("tappedCard id: ",tappedCard.id)
                print("CardSet.shared.cards[index].seq",String( describing:CardSet.shared.cards[index].seq))
                print("tappedCard.seq",String(describing:tappedCard.seq))
                if CardSet.shared.cards[index].seq == tappedCard.seq && CardSet.shared.cards[index].matched == false{
                    print("Card names are identical")
                    if CardSet.shared.cards[index].flipped == false {
                        CardSet.shared.cards[index].flipped = true
                        if CardSet.shared.flippedCard1Seq > 1000{
                            CardSet.shared.flippedCard1Seq = tappedCard.seq
                        }else{
                            CardSet.shared.flippedCard2Seq = tappedCard.seq
                        }
                    
                    }else{
                    CardSet.shared.cards[index].flipped = false
                    }
                    print("Card flipped")
                }
            }
        }
    }
        
    func checkFlippedCards(tappedCard:Card){
        var numberOfCardsFlipped:Int = 0
        numberOfCardsFlipped = checkNumberOfCardsFlipped()
        print("Number of flipped cards is: ", numberOfCardsFlipped)
        var card1 = Card()
        card1.name = ""
        card1.seq = 100000
        var card2 = Card()
        card2.name = ""
        card2.seq = 99999
        if (numberOfCardsFlipped == 2){
            for card in CardSet.shared.cards{
               
                if (CardSet.shared.flippedCard1Seq == card.seq){
                    print( "The 1st flipped card is:", String(reflecting:card.name))
                    print( "The 1st flipped card SEQ is:", String(reflecting:card.seq))
                        card1.name = card.name
                        card1.seq = card.seq!
                    }
                if (CardSet.shared.flippedCard2Seq == card.seq){
                    print( "The 2nd flipped card is:", String(reflecting:card.name))
                    print( "The 2nd flipped card SEQ is:", String(reflecting:card.seq))
                        card2.name = card.name
                        card2.seq = card.seq!
                    }
                }
            for index in CardSet.shared.cards.indices{
                if (card1.name == card2.name){
                    if (CardSet.shared.cards[index].seq == card1.seq ){
                        CardSet.shared.cards[index].matched = true
                    }
                    if (CardSet.shared.cards[index].seq == card2.seq ){
                        CardSet.shared.cards[index].matched = true
                    }
                    print("The current score is: ", CardSet.shared.score)
                    CardSet.shared.score = CardSet.shared.score + 1
                    print("The updated score is: ", CardSet.shared.score)
                }else{
                    DispatchQueue.main.asyncAfter(deadline: .now()  + 2) {
                        [self] in
                        resetSequenceNumber()
                        if (CardSet.shared.cards[index].seq == card1.seq ){
                            CardSet.shared.cards[index].flipped = false
                        }
                        if (CardSet.shared.cards[index].seq == card2.seq ){
                            CardSet.shared.cards[index].flipped = false
                        }
                    }
                }
            }
            resetSequenceNumber()
            if(checkNumberOfPairsMatched() == CardSet.shared.numberOfPairs ){
                print("You Win")
                CardSet.shared.gameWon = true
            }
        }
        enumerateCards(cards: CardSet.shared.cards)
    }
    
    func gameStartCountDown() -> String{
        return CardSet.shared.countdown
    }
    
    func gameWon() -> Bool{
        return CardSet.shared.gameWon
    }
    
    func gameStarted() -> Bool{
        print("Value of gameStarted: ", CardSet.shared.gameStarted )
        return CardSet.shared.gameStarted
    }
    
    
    
    func startGame() {
        var countdown:Int = 0
        print("Value of gameStarted: ", CardSet.shared.gameStarted )
        CardSet.shared.gameStarted = true
        print("Value of gameStarted: ", CardSet.shared.gameStarted )
        for index in CardSet.shared.cards.indices{
            CardSet.shared.cards[index].flipped = true
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("Timer fired!")

            
        
           
                CardSet.shared.countdown = String(reflecting: 10 - countdown)
                print(String(reflecting: 10 - countdown))
            print(CardSet.shared.countdown)
                countdown = countdown + 1
            CardSet.shared.cards[0].flipped = true
            
            if countdown  > 10 {
                timer.invalidate()
            }
            
        
        }
        DispatchQueue.main.asyncAfter(deadline: .now()  + 11) {
            //[self] in
            for index in CardSet.shared.cards.indices{
                CardSet.shared.cards[index].flipped = false
            }
            CardSet.shared.countdown = ""
        }
    }
    
    func restartGame() {
        CardSet.shared.cardsAreSet = false
        CardSet.shared.flippedCard1Seq = 1000000
        CardSet.shared.flippedCard2Seq = 1000000
        CardSet.shared.numberOfPairs = 0
        CardSet.shared.gameWon = false
        CardSet.shared.gameStarted = false
        CardSet.shared.score = 0
        for index in CardSet.shared.cards.indices{
            CardSet.shared.cards[index].name = ""
            CardSet.shared.cards[index].id = UUID()
            CardSet.shared.cards[index].flipped = false
            CardSet.shared.cards[index].match = nil
            //CardSet.shared.cards[index].seq = nil
            CardSet.shared.cards[index].matched = true
        }
        
        //setcards()
    }
    
    func endGame() {
        CardSet.shared.cardsAreSet = false
        CardSet.shared.flippedCard1Seq = 1000000
        CardSet.shared.flippedCard2Seq = 1000000
        CardSet.shared.numberOfPairs = 0
        CardSet.shared.gameWon = false
        CardSet.shared.gameStarted = false
        CardSet.shared.score = 0
        for index in CardSet.shared.cards.indices{
            CardSet.shared.cards[index].name = ""
            CardSet.shared.cards[index].id = UUID()
            CardSet.shared.cards[index].flipped = false
            CardSet.shared.cards[index].match = nil
            //CardSet.shared.cards[index].seq = nil
            CardSet.shared.cards[index].matched = true
        }
        
        //setcards()
    }
    
    func cardDisplayValue(tappedCard:Card) -> String{
        //print("carddisplayvalue")
        for index in CardSet.shared.cards.indices{
            if CardSet.shared.cards[index].seq == tappedCard.seq {
                if (CardSet.shared.cards[index].flipped == false){
                    return ""
                }else{
                    return tappedCard.name!
                }
            }
        }
        return ""
    }
    
    func checkNumberOfCardsFlipped() -> Int{
        var numberOfCardsFlipped:Int = 0
        for card in CardSet.shared.cards{
            if (card.flipped == true && card.matched == false){
                numberOfCardsFlipped = numberOfCardsFlipped + 1
            }
        }
        return numberOfCardsFlipped
    }
    
    func checkNumberOfPairsMatched() -> Int{
        var numberOfPairsMatched:Int = 0
        var numberOfCardsMatched:Int = 0
        for card in CardSet.shared.cards{
            if (card.flipped == true && card.matched == true){
                numberOfCardsMatched = numberOfCardsMatched + 1
            }
        }
        print("Number of matched cards: ",numberOfCardsMatched)
        numberOfPairsMatched = numberOfCardsMatched/2
        print("Number of matched pairs: ",numberOfPairsMatched)
        return numberOfPairsMatched
    }
    
    func resetFlippedCards(){
        let numberOfCardsFlipped:Int = checkNumberOfCardsFlipped()
        if (numberOfCardsFlipped > 1){
            for index in CardSet.shared.cards.indices{
                CardSet.shared.cards[index].flipped = false
            }
            resetSequenceNumber()
            
        }
            
    }
    
    func enumerateCards(cards:[Card]){
        print("enumerating")
        for card in cards{
            print("Name: ",String(describing: card.name!), "Flipped:", String(describing:card.flipped!),"Seq: ",String(describing:card.seq!),"Match: ",String(describing:card.match!),"Matched: ",String(describing:card.matched))//"Card ID: ",card.id))
        }
    }
    
    func resetSequenceNumber(){
        CardSet.shared.flippedCard1Seq = 10000
        CardSet.shared.flippedCard2Seq = 99999
    }
    
    
}

public extension Array where Element == Int {
    static func generateRandom(size: Int) -> [Int] {
        guard size > 0 else {
            return [Int]()
        }
        return Array(0..<size).shuffled()
    }
}
