import SwiftUI

struct Bookmarks: View {
    @State private var text: String = ""
    @State private var isShowingSheet = false

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
                        Text("Recipe #1")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.semibold)
                            .font(.system(size: 24))

                        Rectangle()
                            .frame(height: 150)
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
                            .frame(height: 150)
                            .foregroundColor(Color("greenColor"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    
                    VStack {
                        Text("Recipe #3")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.semibold)
                            .font(.system(size: 24))

                        Rectangle()
                            .frame(height: 150)
                            .foregroundColor(Color("greenColor"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    
                    VStack {
                        Text("Recipe #4")
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
        .padding([.leading, .trailing])
    }
}

struct Bookmarks_Previews: PreviewProvider {
    static var previews: some View {
        Bookmarks()
    }
}
