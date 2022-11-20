//
//  ContentView.swift
//  CatScanner
//
//  Created by Arturo Alfani on 16/11/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model = FrameHandler()
        
    var body: some View {
        NavigationView {
            VStack {
                FrameView(image: model.frame)
                    .ignoresSafeArea()
                Button {
                    // take photo
                } label: {
                    Label {
                        Text("Take Photo")
                    } icon: {
                        ZStack {
                            Circle()
                                .strokeBorder(.white, lineWidth: 3)
                                .frame(width: 82, height: 82)
                            Circle()
                                .fill(.white)
                                .frame(width: 70, height: 70)
                        }
                    }
                }
                .labelStyle(.iconOnly)
                .padding()
            }
            .background(.black)
            .navigationTitle("Camera View")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
