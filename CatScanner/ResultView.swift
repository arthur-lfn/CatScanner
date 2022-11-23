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
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 250, green: 237, blue: 205)
                    .ignoresSafeArea()
                VStack {
                    Image("Siamese")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 370)
                        .cornerRadius(15)
                    
                    CircleImage()
                        .offset(x: -80, y: -130)
                        .padding(.bottom, -130)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(resultTitle)
                                .font(.title)
                            
                            Text(resultMessage)
                                .font(.subheadline)
                        }
                        .padding()
                        
                        Spacer()
                    }
                }
                .foregroundColor(.black)
                .navigationTitle(currentBreed)
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(resultTitle: .constant("This cat is a:"), resultMessage: .constant("Siamese"), currentBreed: .constant("Siamese"))
    }
}
