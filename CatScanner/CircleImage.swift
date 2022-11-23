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
    struct CustomColor {
        static let backgroundColor = Color("Background")
    }
    var body: some View {
        Image("Siamese")
            .resizable()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(CustomColor.backgroundColor, lineWidth: 8)
            }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
