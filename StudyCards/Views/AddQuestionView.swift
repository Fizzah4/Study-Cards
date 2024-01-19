//
//  AddQuestionView.swift
//  StudyCards
//
//  Created by Hurriya Ali on 12/12/23.
//

import SwiftUI

struct AddQuestionView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.question, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    @State var questionString = ""
    @State var answerString = ""
    @State var imageName = "" // Add this line for the image name

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            Section("Question") {
                HStack {
                    TextField("Type your question here", text: $questionString)
                    Text("*").foregroundColor(.red)
                }
            }
            Section("Answer") {
                HStack {
                    TextField("Type your answer here", text: $answerString)
                    Text("*").foregroundColor(.red)
                }
            }
            Section("Image Name") {
                HStack {
                    TextField("Type image name", text: $imageName)
                }
            }
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }
                .foregroundColor(.red)
                .frame(maxWidth: .infinity)

                if questionString != "" && answerString != "" && imageName != "" {
                    Button(action: {
                        addItem()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                    }
                } else {
                    Text("Save")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.question = questionString
            newItem.answer = answerString
            newItem.imageName = imageName.isEmpty ? nil : imageName // Ensure imageName is optional

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        AddQuestionView()
    }
}
