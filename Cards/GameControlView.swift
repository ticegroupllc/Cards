//
//  GameControlView.swift
//  Cards
//
//  Created by Developer on 7/17/21.
//

import SwiftUI

struct GameControlView: View {
    var cards:[Card] = gameObject().getcards()
    @ObservedObject var array = gameObject()
    @ObservedObject var array2 = CardSet.shared
    @State var displayCard:Bool = false
    @State var showSettingsView:Bool = false
    @State var gameStarted:Bool = CardSet.shared.gameStarted
    @State private var degrees = 0.0
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .ignoresSafeArea()
            if CardSet.shared.gameStarted == true{
                if gameObject().gameWon() == false{
                    GameGridView()
                }
                if gameObject().gameWon() == true{
                    WinView()
                }
                
            }else{
                if CardSet.shared.gameStarted == false{
                    StartGameView()
                }
            }
        }
    }
}

struct GameControlView_Previews: PreviewProvider {
    static var previews: some View {
        GameControlView()
    }
}
