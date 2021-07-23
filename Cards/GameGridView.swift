//
//  GameGridView.swift
//  Cards
//
//  Created by Developer on 7/17/21.
//

import SwiftUI

struct GameGridView: View {
    var cards:[Card] = gameObject().getcards()
    @ObservedObject var array = gameObject()
    @ObservedObject var array2 = CardSet.shared
    @State var displayCard:Bool = false
    @State var showSettingsView:Bool = false
    @State var gameStarted:Bool = CardSet.shared.gameStarted
    @State private var degrees = 0.0
    private var columns: [GridItem] = [
        GridItem(.flexible(),spacing: 16),
        GridItem(.flexible(),spacing: 16),
        GridItem(.flexible(),spacing: 16)
    ]
    var body: some View {
        Group{
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color.blue)
                        .frame(width: 400, height: 50)
                    HStack{
                        Text("User:")
                        Text(String(reflecting:array2.score))
                    }
                }
                Spacer()
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
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color.yellow)
                        .frame(width: 400, height: 50)
                    HStack{
                        Text("Score: ")
                        Text(String(reflecting:array2.score))
                    }
                }
            }
        }
    }
}


struct GameGridView_Previews: PreviewProvider {
    static var previews: some View {
        GameGridView()
    }
}
