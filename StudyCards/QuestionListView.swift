//
//  QuestionListView.swift
//  StudyCards
//
//  Created by Hurriya Ali on 12/12/23.
//

import SwiftUI

struct QuestionListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.question, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State var showAddQuestionView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    Text(item.question!)
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {showAddQuestionView = true}) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Questions")
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .sheet(isPresented: $showAddQuestionView, content:  {
            AddQuestionView()
        })
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let item = items[index]
                
                // Debug print statements
                print("Deleting item: \(item)")
                print("Item imageName: \(item.imageName)")
                
                // Delete the item
                viewContext.delete(item)
            }
            
            do {
                try viewContext.save()
            } catch {
                // Handle the error
                print("Error saving context: \(error)")
            }
        }
    }
    struct QuestionListView_Previews: PreviewProvider {
        static var previews: some View {
            QuestionListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
