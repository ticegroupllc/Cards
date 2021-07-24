//
//  CardView.swift
//  Cards
//
//  Created by Developer on 7/17/21.
//

import SwiftUI

import SwiftUI

struct CardView: View{
    
    @ObservedObject var array = gameObject()
    @ObservedObject var array2 = CardSet.shared
    @State var cardImagesOn = CardSet.shared.cardImages
    @State var displayCard:Bool
    var card:Card
    var body: some View {
        //GeometryReader{geometry in
            ZStack{
                if cardImagesOn{
                    Circle()
                        .foregroundColor(Color.gray)
                        .blur(radius: 3)
                    Circle()
                        .foregroundColor(.white)
                    Image(gameObject().cardDisplayValue(tappedCard: card))
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                    
                    
                    
                }else{
                    Circle()
                        .foregroundColor(Color.gray)
                        .blur(radius: 3)
                    Circle()
                        .foregroundColor(.white)
                    Text(gameObject().cardDisplayValue(tappedCard: card))
                        .padding()
                }

        }
    }
}

struct CardView_Previews: PreviewProvider {
    
    static var previews: some View {
        CardView(displayCard: true, card: Card(name:"Jack", flipped:false, id:UUID.init(), seq:23, matched:false, match:2))
    }
}
