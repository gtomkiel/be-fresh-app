import SwiftUI

struct Bookmarks: View {
    @State private var text: String = ""
    @State private var isShowingSheet = false
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BookMark.bookmark, ascending: true)],
        animation: .default)
    private var bookmarks: FetchedResults<BookMark>

    var body: some View {
        VStack() {
            HStack {
                Text("Bookmarks")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontWeight(.heavy)
                    .font(.system(size: 48))
                    .padding(.vertical, 20)
            }
            ScrollView {
                VStack() {
                    VStack {
                        ForEach(bookmarks) { bookmark in
                            NavigationLink(destination: RecipesView(recipeName: bookmark.title!, bookmark: bookmark, fromBookmarks: true)) {
                                Text(String(bookmark.title ?? "No title"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 24))
                                
                                Rectangle()
                                    .frame(height: 150)
                                    .foregroundColor(Color("greenColor"))
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                            }
                        }
                    }
                }
            }
        }
        .padding([.leading, .trailing])
    }
}

struct Bookmarks_Previews: PreviewProvider {
    static var previews: some View {
        Bookmarks()
    }
}
