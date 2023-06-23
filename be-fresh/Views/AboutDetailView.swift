import SwiftUI

struct AboutDetailView: View {
    var body: some View {
        Text("BeFresh is an app devoted to helping reduce food waste and help people keep track of their groceries and their expiry dates. It includes various innovative features such as recipe generation, a calendar detailing the expiration dates and much more!")
            .padding()
    }
}

struct AboutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AboutDetailView()
    }
}
