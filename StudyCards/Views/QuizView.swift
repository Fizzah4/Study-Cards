
//
//  QuizView.swift
//  StudyCards
//
//  Created by Hurriya Ali on 12/12/23.
//

// QuizView.swift
import SwiftUI

struct QuizView: View {
    @State var backDegree = 90.0
    @State var frontDegree = 0.0
    @State var isFlipped = false
    @State var questionNum = 0

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.question, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        VStack {
            ZStack {
                // Display only the question without the image
                CardFront(degree: $frontDegree, textContent: items[questionNum].question!, imageName: nil )


                // Display the answer with the image
                CardBack(degree: $backDegree, textContent: items[questionNum].answer!, imageName: items[questionNum].imageName)
            }.onTapGesture {
                flipCard()
            }

            HStack {
                if questionNum > 0 {
                    Button(action: {
                        if !isFlipped {
                            flipCard()
                        }
                        questionNum -= 1
                    }) {
                        Text("< Previous")
                    }.frame(maxWidth: .infinity)
                } else {
                    Text("< Previous")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.secondary)
                }
            }

            // CARD NUMBERS
            Text("Card \(questionNum + 1) of \(items.count)")

            if questionNum < (items.count - 1) {
                Button(action: {
                    if !isFlipped {
                        flipCard()
                    }
                    questionNum += 1
                }) {
                    Text("Next >")
                }.frame(maxWidth: .infinity)
            } else {
                Text("Next >")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }

    func flipCard() {
        isFlipped.toggle()

        withAnimation(.linear(duration: 0.2)) {
            if isFlipped {
                backDegree = 90
                frontDegree = 0
            } else {
                frontDegree = -90
                backDegree = 0
            }
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
