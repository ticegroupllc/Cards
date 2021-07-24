//
//  StartGameView.swift
//  Cards
//
//  Created by Developer on 7/17/21.
//

import SwiftUI

struct StartGameView: View {
    @State var gameStarted:Bool = CardSet.shared.gameStarted
    @State var showGreeting:Bool = true
    var cardCount = gameObject.shared.cardCount
    var colors = gameObject.shared.cardDecks
    @State private var selectedColor = gameObject.shared.cardDecks[1]
    @State private var selectedNumberofCards = gameObject.shared.cardCount[1]
    var body: some View {
        VStack{
            Spacer()
            ZStack{
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.blue)
                    .frame(width: 300, height: 650)
                VStack{
                    Text("Settings ")
                        .padding()
                        .font(.title)
                        .font(.headline)
                    VStack {
                                Picker("Please choose number of cards", selection: $selectedNumberofCards) {
                                    ForEach(cardCount, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .frame(width: 50, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                                Text("You selected: \(selectedNumberofCards)")
                            }
                    HStack{
                           // Text("Animations:")
                                //.bold()
                           //     .foregroundColor(.black)
                           //     .padding()
                        Toggle("Animations", isOn: $showGreeting)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 50, maxWidth: 200, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 25, maxHeight: 50, alignment: .leading)
                    }
                    VStack {
                                Picker("Please choose a card set", selection: $selectedColor) {
                                    ForEach(colors, id: \.self) {
                                        Text($0)
                                    }
                                }.frame(width: 50, height: 100, alignment: .center)
                                Text("You selected: \(selectedColor)")
                        
                            }
                }
            }
            Spacer()
            ZStack{
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.yellow)
                    .frame(width: 300, height: 100)
                Button(action: {
                    CardSet.shared.cardDeck = selectedColor
                    
                    CardSet.shared.numberOfCardsToPlay = Int(selectedNumberofCards) ?? 0
                    gameObject().setcards()
                    gameObject().startGame()
                    gameStarted.toggle()
                }){
                    Text("Start Game")//CardView(displayCard: displayCard, card: card)
                }
            }
            Spacer()
        }
    }
    
}

struct StartGameView_Previews: PreviewProvider {
    static var previews: some View {
        StartGameView()
    }
}
