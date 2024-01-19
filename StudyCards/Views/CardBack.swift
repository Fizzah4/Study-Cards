//
//  CardBack.swift
//  StudyCards
//
//  Created by Hurriya Ali on 12/12/23.
//

import SwiftUI

struct CardBack: View {
    @Binding var degree: Double
    let textContent: String
    let imageName: String?

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .stroke(.blue.opacity(0.5), lineWidth: 10)
                .padding()

            RoundedRectangle(cornerRadius: 20)
                .fill(.blue.opacity(0.1))
                .padding()

            VStack{
                Text("Answer:")
                    .font(Font.custom("Rainbow Paper", size: 50))

                // Display the image only on the answer side
                if let imageName = imageName, !imageName.isEmpty {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300) // Adjust size as needed
                        .padding(20) // Add padding if desired
                }

                Text(textContent)
                    .lineLimit(10)
                    .font(Font.custom("Rainbow Paper", size: 40))
                    .multilineTextAlignment(.center)
                    .padding(25)
            }
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}
