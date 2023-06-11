import SwiftUI

struct AboutView: View {
    @EnvironmentObject var model: DefautlModel
    
    var body: some View {
        VStack(alignment: .center) {
            Image("aboutIcon")
                .padding(.vertical)
            
            Group {
                Text("Be-fresh")
                Text("Version 1.0")
            }
            .font(.headline)
            .padding(.horizontal)
            
            List {
                
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(Color(red: 217, green: 217, blue: 217))
                    .cornerRadius(15)
                    
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(Color(red: 217, green: 217, blue: 217))
                    .cornerRadius(15)
                    .overlay {
                        NavigationLink {
                            AboutDetailView()
                        } label: {
                            Text("What's Be Fresh?")
                        }
                    }
            }
            .listStyle(.plain)
            
            Group {
                Text("Copyright © 2023 Apple Inc.")
                Text("All rights reserved.")
            }
            .font(.footnote)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
