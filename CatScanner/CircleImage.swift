//
//  CircleImage.swift
//  CatScanner
//
//  Created by Arturo Alfani on 23/11/22.
//

import SwiftUI

struct CustomColor {
    static let backgroundColor = Color("Background")
}

struct CircleImage: View {
    var photo: CGImage?
    private let label = Text("your picture")

    var body: some View {
        if let image = photo {
            Image(image, scale: 1.0, label: label)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(CustomColor.backgroundColor, lineWidth: 8)
            }            
        } else {
            // this code mostly has the purpose of showing a preview in xcode
            Image("Siamese")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(CustomColor.backgroundColor, lineWidth: 8)
                }
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
