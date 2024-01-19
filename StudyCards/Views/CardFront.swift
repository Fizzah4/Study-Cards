//
//  CradFront.swift
//  StudyCards
//
//  Created by Hurriya Ali on 12/12/23.

// CardFront.swift
import SwiftUI

struct CardFront: View {
    @Binding var degree: Double
    let textContent: String
    let imageName: String?

    // Add an optional imageName parameter, even if it's not used in this view
    init(degree: Binding<Double>, textContent: String, imageName: String? = nil) {
        self._degree = degree
        self.textContent = textContent
        self.imageName = imageName
    }

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .stroke(.green.opacity(0.5), lineWidth: 10)
                .padding()

            RoundedRectangle(cornerRadius: 20)
                .fill(.green.opacity(0.1))
                .padding()

            VStack{
                Text("Question:")
                    .font(Font.custom("Rainbow Paper", size: 50))

                Text(textContent)
                    .lineLimit(10)
                    .font(Font.custom("Rainbow Paper", size: 40))
                    .multilineTextAlignment(.center)
                    .padding(25)
            }

            // Conditionally hide the image
            if let imageName = imageName, !imageName.isEmpty {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(5)
            }
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}
