import SwiftUI

struct Bookmarks: View {
    @State private var text: String = ""
    @State private var isShowingSheet = false
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BookMark.bookmark, ascending: true)],
        animation: .default
    )
    private var bookmarks: FetchedResults<BookMark>

    var body: some View {
        VStack {
            HStack {
                Text("Bookmarks")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontWeight(.heavy)
                    .font(.system(size: 48))
                    .padding(.vertical, 20)
            }
            ScrollView {
                VStack {
                    ForEach(bookmarks) { bookmark in
                        NavigationLink(destination: RecipesView(recipeName: bookmark.title!, bookmark: bookmark, fromBookmarks: true, delete: UserDefaults.standard.bool(forKey: "RemoveRename"))) {
                            Text(bookmark.title!)
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(Color.white)
                                .padding(20)
                                .background(
                                    Rectangle()
                                        .foregroundColor(Color("greenColor"))
                                        .cornerRadius(15)
                                        .shadow(radius: 5)
                                )
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
