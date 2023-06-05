import SwiftUI
import CoreData

struct HomePage: View {
    @EnvironmentObject var model: DefautlModel // MARK -- DONT DELETE
    @StateObject var api = ApiCall(prompt: "Give me 5 recipe names in a unordered list using dots based on those products [chicken, tomato sauce, pasta, cheese, mushrooms] keep it short", temperature: "0")
    
    @State private var animate = false
    @State private var text = false
    @State private var launched = false
    
    var body: some View {
        NavigationView(){
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        HStack {
                            if (model.isLoggedIn && model.currentUser != nil) {
                                Text("Hello! " + model.currentUser!.firstName!)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fontWeight(.heavy)
                                    .font(.system(size: 48))
                            }
                        }
                        .padding(.vertical, 20)
                        .opacity(animate ? 1.0 : 0.0)


                        ScrollView() {
                            VStack {
                                Text("Upcoming expire dates")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 24))
                                Rectangle()
                                    .foregroundColor(Color("greenColor"))
                                    .frame(height: 264)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                                    .overlay(
                                        ProgressView()
                                    )
                            }
                            .opacity(animate ? 1.0 : 0.0)
                            .padding(.bottom, 20)
                            
                            
                            VStack {
                                Text("Todays recommendation")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 24))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Rectangle()
                                    .foregroundColor(Color("greenColor"))
                                    .frame(height: 264)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                                    .overlay{
                                        if (api.response.isEmpty) {
                                            ProgressView()
                                        } else {
                                            VStack {
                                                Text(api.response)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .italic()
                                                    .font(.system(size: 20, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .lineSpacing(25)
                                                    .padding(15)
                                                Spacer()
                                            }
                                            .opacity(text ? 1.0 : 0.0)
                                            .onAppear {
                                                if (!text){
                                                    withAnimation(Animation.spring().speed(0.8)) {
                                                        text.toggle()
                                                    }
                                                }
                                            }
                                        }
                                    }
                            }
                            .opacity(animate ? 1.0 : 0.0)
                            .padding(.bottom, 20)
                            Spacer()
                        }
                    }
                }
                .padding([.leading, .trailing])
                .background(Color(red: 253, green: 255, blue: 252))
                .onAppear {
                    if (!animate){
                        withAnimation(Animation.spring().speed(0.8)) {
                            animate.toggle()
                        }
                    }
                }
            }
        }
        .onAppear() {
            if (!launched) {
                api.fetchData()
                launched.toggle()
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
