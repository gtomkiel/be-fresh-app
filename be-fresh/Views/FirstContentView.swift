import SwiftUI

struct FirstContentView: View {
    @EnvironmentObject var model: DefautlModel

    var body: some View {
        ZStack {
            VStack(spacing: 0.0) {
                Spacer(minLength: 30)
                Image("image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 35.0)
                    .frame(width: 300.0, height: 300.0)
                Text("Did you know 1/3 of all food produced lands in the landfill? Be the change, BeFresh!")
                Spacer(minLength: 30)
            }
            .padding()
        }
    }
}

struct FirstContentView_Previews: PreviewProvider {
    static var previews: some View {
        FirstContentView()
    }
}
