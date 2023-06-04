import SwiftUI

struct Bookmarks: View {
    @State private var text: String = ""
    @State private var isShowingSheet = false

    var body: some View {
        VStack(spacing: 32) {
            ScrollView {
                VStack(spacing: 32) {
                    HStack {
                        Text("Bookmarks")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.heavy)
                            .font(.system(size: 48))
                            .padding(.vertical, 20)
                    }
                    
                    VStack {
                        Text("Recipe #1")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.semibold)
                            .font(.system(size: 24))

                        Rectangle()
                            .frame(height: 104)
                            .foregroundColor(Color("greenColor"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    
                    VStack {
                        Text("Recipe #2")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.semibold)
                            .font(.system(size: 24))

                        Rectangle()
                            .frame(height: 104)
                            .foregroundColor(Color("greenColor"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                }
            }
            .padding([.leading, .trailing])
            Spacer()
        }
    }
}

struct Bookmarks_Previews: PreviewProvider {
    static var previews: some View {
        Bookmarks()
    }
}
