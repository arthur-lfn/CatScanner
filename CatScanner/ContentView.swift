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
    @State private var alertTitle = ""
    @State private var alertMessage = ""
        
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
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
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK") { }
                } message: {
                    Text(alertMessage)
                }
            }
            .background(.black)
            .navigationTitle("Camera View")
        }
    }
    
    func classifyCat() {
        do {
            let config = MLModelConfiguration()
            let mlModel = try CatClassifier(configuration: config)

            let output = try? mlModel.prediction(image: model.imageBuffer!)
            if let output = output {
                let results = output.classLabelProbs.sorted { $0.1 > $1.1 }
                let result = results.map { (key, value) in
                    return "\(key) = \(String(format: "%.2f", value * 100))%"
                }.joined(separator: "\n")

                self.alertMessage = result
            }
            alertTitle = "This cat is a:"
        } catch {
            alertTitle = "Error"
            alertMessage = "Failed classifying your cat"
        }

        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
