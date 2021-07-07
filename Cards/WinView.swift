//
//  WinView.swift
//  Cards
//
//  Created by Developer on 10/24/20.
//

import SwiftUI

struct WinView: View{
    @ObservedObject var array2 = CardSet.shared
    var body: some View{
        HStack(alignment: .center){
            VStack(alignment: .center){
                Text("You Win! ")
                    .font(.largeTitle)
                Button(action: {
                    gameObject().restartGame()
                }){
                    Text("Play Again")//CardView(displayCard: displayCard, card: card)
                
                }.padding()//.animation(.easeOut)

                Button(action: {
                    gameObject().endGame()
                }){
                    Text("Main Menu")//CardView(displayCard: displayCard, card: card)
                
                }.padding()//.animation(.easeOut)
            }
        }
    }
}


struct WinView_Previews: PreviewProvider {
    static var previews: some View {
        WinView()
    }
}
