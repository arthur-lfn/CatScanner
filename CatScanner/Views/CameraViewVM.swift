//
//  CameraViewVM.swift
//  CatScanner
//
//  Created by Arturo Alfani on 16/11/22.
//

import Foundation
import Vision

class CameraViewVM: ObservableObject {
    @Published var showingAlert = false
    
    @Published var resultTitle = ""
    @Published var resultMessage = ""
    @Published var navigateWhenTrue: Bool = false
    
    @Published var currentBreed = ""
    @Published var photo: CGImage?
    
    func classifyCat(
        permissionGranted: Bool,
        frame: CGImage?,
        imageBuffer: CVPixelBuffer?
    ) {
        do {
            if !permissionGranted {
                resultTitle = "Please allow access to the camera"
                resultMessage = "This app uses the camera to take pictures of the cats you want to scan"
                showingAlert = true
            } else {
                photo = frame
                
                let config = MLModelConfiguration()
                let mlModel = try CatClassifier(configuration: config)

                let output = try? mlModel.prediction(image: imageBuffer!)
                if let output = output {
                    let results = output.classLabelProbs.sorted { $0.1 > $1.1 }
                    
                    if (results[0].value > 0.75) {
                        let result = results.map { (key, value) in
                            return "\(String(format: "%.2f", value * 100))% \(key)"
                        }
                        let relevantResult = "\(result[0])\n\(result[1])\n\(result[2])"
                        
                        currentBreed = results[0].key
                        resultMessage = relevantResult
                        navigateWhenTrue = true
                    } else {
                        resultTitle = "I don't see a cat"
                        resultMessage = "Please take a picture of a cat"
                        showingAlert = true
                    }
                }
            }
        } catch {
            resultTitle = "Error"
            resultMessage = "Failed classifying your cat"
        }
    }
}
