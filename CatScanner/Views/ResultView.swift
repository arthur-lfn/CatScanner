//
//  ResultView.swift
//  CatScanner
//
//  Created by Arturo Alfani on 23/11/22.
//

import SwiftUI

struct ResultView: View {
    @Binding var resultTitle: String
    @Binding var resultMessage: String
    @Binding var currentBreed: String
    
    var photo: CGImage?
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                GeometryReader { geometry in
                    Image(currentBreed)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: geometry.size.width,
                            height: 380,
                            alignment: .center
                        )
                        .clipped()
                }
                
                CircleImage(photo: photo)
                    .offset(x: -80, y: -100)
                    .padding(.bottom, -100)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(resultTitle)
                            .font(.title)
                        
                        Divider()
                        Text("Precisely:\n")
                            .font(.headline)
                        Text(resultMessage)
                            .font(.headline)
                    }
                    .padding()
                    
                    Spacer()
                }
            }
            .navigationBarTitle(currentBreed)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(resultTitle: .constant("This cat seems to be Siamese"), resultMessage: .constant("98.00% Siamese\n02.00% Ragdoll"), currentBreed: .constant("Siamese"))
    }
}
