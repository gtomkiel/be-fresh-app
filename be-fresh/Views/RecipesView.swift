import CoreData
import SwiftUI

struct RecipesView: View {
    var delete: Bool
    var bookmark: BookMark?
    var fromBookmarks: Bool
    @StateObject private var api: ApiCall
    @State private var text = false
    @State private var launched = false
    @State private var saved = false

    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode

    let recipeName: String

    init(recipeName: String, bookmark: BookMark?, fromBookmarks: Bool, delete: Bool) {
        self.bookmark = bookmark
        self.fromBookmarks = fromBookmarks
        self.recipeName = recipeName
        self.delete = delete
        self._api = StateObject(wrappedValue: ApiCall(
            prompt: "Give me formatted recipe for \(recipeName) with title at the beginning",
            temperature: "0.7"
        ))
    }

    var body: some View {
        VStack {
            HStack {
                Text("Details")
                Spacer()
            }
            .font(.system(size: 48))
            .fontWeight(.heavy)
            .padding(.bottom, 10)
            ScrollView {
                if self.fromBookmarks == false {
                    if api.response.isEmpty {
                        Rectangle()
                            .foregroundColor(Color("greenColor"))
                            .frame(height: 150)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .overlay {
                                if api.response.isEmpty {
                                    ProgressView()
                                } else {
                                    VStack {
                                        Text(api.response)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .fontWeight(.medium)
                                            .font(.system(size: 20))
                                            .foregroundColor(Color.white)
                                            .padding(10)
                                        Spacer()
                                    }
                                }
                            }
                    } else {
                        Text(api.response)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color.white)
                            .padding(10)
                            .background(
                                Rectangle()
                                    .foregroundColor(Color("greenColor"))
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                            )
                            .opacity(text ? 1.0 : 0.0)
                            .onAppear {
                                if !text {
                                    withAnimation(Animation.spring().speed(0.8)) {
                                        text.toggle()
                                    }
                                }
                            }
                    }
                } else {
                    Text(self.bookmark!.bookmark ?? "")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.white)
                        .padding(10)
                        .background(
                            Rectangle()
                                .foregroundColor(Color("greenColor"))
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        )
                        .opacity(text ? 1.0 : 0.0)
                        .onAppear {
                            if !text {
                                withAnimation(Animation.spring().speed(0.8)) {
                                    text.toggle()
                                }
                            }
                        }
                }
            }
        }
        .padding()
        .onAppear {
            if !launched {
                api.fetchData()
                launched.toggle()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if self.delete == true && self.fromBookmarks == true {
                    Button(action: {
                        PersistenceController.shared.deleteBookmark(bookmakr: self.bookmark!)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "trash")
                                .font(.system(size: 15))
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                }
                Button(action: {
                    addBookmark(text: String(api.response), title: String(self.recipeName))
                    self.saved = true

                }) {
                    if (self.bookmark?.bookmark) != nil {}
                    else {
                        if self.saved {
                            Image(systemName: "bookmark.fill")
                        } else {
                            Image(systemName: "bookmark")
                        }
                    }
                }
            }
        }
        .accentColor(Color("greenColor"))
    }

    private func addBookmark(text: String, title: String) {
        withAnimation {
            let newBookMark = BookMark(context: PersistenceController.shared.container.viewContext)
            newBookMark.bookmark = text
            newBookMark.title = title
            do {
                try PersistenceController.shared.container.viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            print(newBookMark)
        }
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView(recipeName: "test", bookmark: nil, fromBookmarks: false, delete: UserDefaults.standard.bool(forKey: "RemoveRename"))
    }
}
