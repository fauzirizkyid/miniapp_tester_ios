import SwiftUI

struct ContentView: View {
    let miniAppService: MiniAppRepository = MiniAppService() // ✅ Inject dependency

    var body: some View {
        VStack {
            Text("Welcome to My MiniApp")
                .font(.largeTitle)
                .padding()

            Button(action: {
                miniAppService.launchMiniApp() // ✅ Calls launchMiniApp() correctly
            }) {
                Text("Open Mini App")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}
