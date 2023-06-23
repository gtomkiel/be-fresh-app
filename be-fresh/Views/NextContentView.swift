import SwiftUI

struct NextContentView: View {
    @EnvironmentObject var model: DefautlModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            VStack(spacing: 0.0) {
                Spacer(minLength: 30)
                Image("image2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 35.0)
                    .frame(width: 300.0, height: 300.0)
                Text("This app is powered by artificial intelligence to provide endless creative recipes personalized for you!")
                Spacer(minLength: 30)
            }
            .padding()
        }
    }
}

struct NextContentView_Previews: PreviewProvider {
    static var previews: some View {
        NextContentView()
    }
}
