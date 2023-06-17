import SwiftUI

struct RecipesView: View {
    @StateObject private var api: ApiCall
    @State private var text = false
    @State private var launched = false
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BookMark.bookmark, ascending: true)],
        animation: .default)
    private var bookmarks: FetchedResults<BookMark>

    let recipeName: String

    init(recipeName: String) {
        self.recipeName = recipeName
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
            }
            Spacer()
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
                Button(action: {
                    addBookmark(text: "new bookmark")
                }) {
                    Image(systemName: "bookmark")
                }
            }
        }
    }
    private func addBookmark(text: String) {
        withAnimation {
            let newBookMark = BookMark(context: viewContext)
            print(newBookMark)
            newBookMark.bookmark = text
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView(recipeName: "test")
    }
}
