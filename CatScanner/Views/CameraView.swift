//
//  ContentView.swift
//  CatScanner
//
//  Created by Arturo Alfani on 16/11/22.
//

import CoreML
import SwiftUI
import Vision

struct CameraView: View {
    @StateObject var frameHandler = FrameHandler()
    @StateObject var cameraVVM = CameraViewVM()
        
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                FrameView(image: frameHandler.frame)
                    .ignoresSafeArea()
                
                Button {
                    cameraVVM.classifyCat(
                        permissionGranted: frameHandler.permissionGranted,
                        frame: frameHandler.frame,
                        imageBuffer: frameHandler.imageBuffer
                    )
                } label: {
                    ZStack {
                        Circle()
                            .strokeBorder(.white, lineWidth: 3)
                            .frame(width: 82, height: 82)
                        Circle()
                            .fill(.white)
                            .frame(width: 70, height: 70)
                    }
                }
                .padding()
            }
            .navigationBarTitle("Take a picture of a cat")
            .navigationBarTitleDisplayMode(.inline)
            .alert(cameraVVM.resultTitle, isPresented: $cameraVVM.showingAlert) {
                Button("OK") { }
            } message: {
                Text(cameraVVM.resultMessage)
            }
            .navigationDestination(isPresented: $cameraVVM.navigateWhenTrue) {
                ResultView(
                    resultTitle: $cameraVVM.resultTitle,
                    resultMessage: $cameraVVM.resultMessage,
                    currentBreed: $cameraVVM.currentBreed,
                    photo: cameraVVM.photo
                )
            }
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
