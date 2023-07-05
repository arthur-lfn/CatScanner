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
        ZStack(alignment: .topLeading) {
            Color("Background")
                .ignoresSafeArea()
            ZStack(alignment: .bottom) {
                Image(currentBreed)
                    .resizable()
                    .scaledToFit()
                CircleImage(photo: photo)
                    .offset(y: 75)
            }
            VStack(alignment: .leading) {
                Spacer()
                Text(resultMessage)
                    .font(.title)
            }
            .padding(.leading, 20)
            .padding(.bottom, 60)
            .navigationBarTitle(currentBreed)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ResultView(
                resultMessage: .constant("98.00% Siamese\n02.00% Ragdoll"),
                currentBreed: .constant("Siamese")
            )
        }
    }
}
