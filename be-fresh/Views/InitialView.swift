import SwiftUI

struct InitialView: View {
    @EnvironmentObject var model: DefautlModel
    @Environment(\.dismiss) private var dismiss

    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            FirstContentView()
                .tag(0)
            NextContentView()
                .tag(1)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

        VStack {
            Text("Start!")
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .center)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(Color.white)
                .padding(20)
                .onTapGesture {
                    withAnimation {
                        UserDefaults.standard.set(true, forKey: "FirstTime")
                        model.first = true
                        dismiss()
                    }
                }
                .background(
                    Rectangle()
                        .foregroundColor(Color("greenColor"))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                )
        }
        .padding()
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
