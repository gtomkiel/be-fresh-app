import SwiftUI

struct AboutView: View {
    @EnvironmentObject var model: DefautlModel

    var body: some View {
        VStack {
            Image("aboutIcon")
                .padding(.vertical)

            Group {
                Text("Be-fresh")
                Text("Version 1.0")
            }
            .font(.headline)
            .padding(.horizontal)

            Text("BeFresh is an app devoted to helping reduce food waste and help people keep track of their groceries and their expiry dates. It includes various innovative features such as recipe generation, a calendar detailing the expiration dates and much more!")
                .padding()

            Spacer()
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
