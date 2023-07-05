//
//  ResultView.swift
//  CatScanner
//
//  Created by Arturo Alfani on 23/11/22.
//

import SwiftUI

struct ResultView: View {
    @Binding var resultMessage: String
    @Binding var currentBreed: String
    
    var photo: CGImage?
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                ZStack(alignment: .bottom) {
                    Image(currentBreed)
                        .resizable()
                        .scaledToFit()
                        .clipShape(
                            RoundedRectangle(cornerRadius: 25)
                        )
                        .padding()
                    CircleImage(photo: photo)
                        .offset(y: 60)
                }
                Spacer()
                Text(resultMessage)
                    .font(.title2)
                    .fontWeight(.medium)
                    .padding(.leading)
                Spacer()
            }
        }
        .navigationBarTitle(currentBreed)
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ResultView(
                resultMessage: .constant("97.50% Siamese\n02.00% Ragdoll\n00.50% Sphynx"),
                currentBreed: .constant("Siamese")
            )
        }
    }
}
