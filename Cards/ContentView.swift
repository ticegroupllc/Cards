//
//  ContentView.swift
//  Cards
//
//  Created by Developer on 10/18/20.
//

import SwiftUI

struct CardView: View{
    
    @ObservedObject var array = gameObject()
    @ObservedObject var array2 = CardSet.shared
    @State var displayCard:Bool
    var card:Card
    var body: some View {
        //GeometryReader{geometry in
            ZStack{
           //
            //Rectangle()
                
                //.rotationEffect(.degrees(displayCard ? 90 : 0))
                  //                      .padding()
                   //                     .animation(.easeInOut)
                Circle()
                    //.border(Color.black)
                    //.scale(2)
                    //.padding()
                    .foregroundColor(Color.gray)
                    .blur(radius: 3)
                    //.border(Color.black)
                    //.padding()
                Circle()
                    .foregroundColor(.white)
                    
                   // .blur(radius:
                Text(gameObject().cardDisplayValue(tappedCard: card))
                    .padding()
                    //.border(Color.clear)
                    //.padding()
                
            //}
        }
    }
}



struct GameGridView: View {
    var cards:[Card] = gameObject().getcards()
    @ObservedObject var array = gameObject()
    @ObservedObject var array2 = CardSet.shared
    @State var displayCard:Bool = false
    @State var showSettingsView:Bool = false
    @State var gameStarted:Bool = CardSet.shared.gameStarted
    @State private var degrees = 0.0
    private var columns: [GridItem] = [
            //GridItem(.fixed(100), spacing: 16),
            //GridItem(.fixed(100), spacing: 16),
            //GridItem( spacing: 100)
            //GridItem(.adaptive(minimum: 40))
        GridItem(.flexible(),spacing: 16),
        GridItem(.flexible(),spacing: 16),
        GridItem(.flexible(),spacing: 16)
            
        ]
    var body: some View {
        //NavigationView{
        if CardSet.shared.gameStarted == true{
                if gameObject().gameWon() == false{
                    Group{
                        HStack{
                            Text("User:")
                            ZStack{
                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                                                .fill(Color.yellow)
                                                .frame(width: 200, height: 50)
                                Text("Score: ")
                            }
                            Text(String(reflecting:array2.score))
                        }
                        ZStack{
                            LazyVGrid(columns:columns, spacing: 20){
                                ForEach(CardSet.shared.cards, id: \.id) { card in
                                        Button(action: {
                                            gameObject().flipcard(tappedCard: card)
                                            gameObject().checkFlippedCards(tappedCard: card)
                                                displayCard.toggle()
                                                degrees = degrees + 360
                                        }){
                                            withAnimation(.linear(duration: 1)){
                                                CardView(displayCard: displayCard, card: card)
                                            }
                                        }
                                        .rotation3DEffect(.degrees(degrees), axis: (x: 1, y: 1, z: 1))
                                }
                            }
                            Text(gameObject().gameStartCountDown())
                                .font(.system(size:200, weight: .bold, design: .default))
                                .foregroundColor(.red)
                        }
                    }
                if gameObject().gameWon() == true{
                    WinView()
                }
            }
        }else{
            if CardSet.shared.gameStarted == false{
                ZStack{
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(Color.yellow)
                                    .frame(width: 200, height: 200)
                    Button(action: {
                        gameObject().startGame()
                        gameStarted.toggle()
                    }){
                        Text("Start Game")//CardView(displayCard: displayCard, card: card)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameGridView()
            
        }
    }
}
