//
//  ContentView.swift
//  CatScanner
//
//  Created by Arturo Alfani on 16/11/22.
//

import CoreML
import SwiftUI
import Vision

struct ContentView: View {
    @StateObject private var model = FrameHandler()
    
    @State private var showingAlert = false
    
    @State var resultTitle = ""
    @State var resultMessage = ""
    @State var navigateWhenTrue: Bool = false
    
    @State var currentBreed = ""
    @State var photo: CGImage?
        
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                NavigationLink("Navigator",
                               destination: ResultView(resultTitle: $resultTitle, resultMessage: $resultMessage, currentBreed: $currentBreed, photo: photo),
                               isActive: $navigateWhenTrue
                )
                FrameView(image: model.frame)
                    .ignoresSafeArea()
                
                Button {
                    classifyCat()
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
                .alert(resultTitle, isPresented: $showingAlert) {
                    Button("OK") { }
                } message: {
                    Text(resultMessage)
                }
            }
            .background(.black)
            .navigationBarTitle("Camera")
            .toolbar(.hidden)
        }
    }
    
    func classifyCat() {
        do {
            photo = model.frame
            
            let config = MLModelConfiguration()
            let mlModel = try CatClassifier(configuration: config)

            let output = try? mlModel.prediction(image: model.imageBuffer!)
            if let output = output {
                let results = output.classLabelProbs.sorted { $0.1 > $1.1 }
                print(results[0].value)
                if (results[0].value > 0.75) {
                    // nome razza: results[0].key
                    let result = results.map { (key, value) in
                        return "\(key) = \(String(format: "%.2f", value * 100))%"
                    }
                    let relevantResult = "\(result[0])\n\(result[1])\n\(result[2])"
                    
                    currentBreed = results[0].key
                    resultTitle = "This cat is a:"
                    self.resultMessage = relevantResult
                    navigateWhenTrue = true
                } else {
                    resultTitle = "I don't see a cat"
                    self.resultMessage = "Please take a picture of a cat"
                    showingAlert = true
                }
            }
        } catch {
            resultTitle = "Error"
            resultMessage = "Failed classifying your cat"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
