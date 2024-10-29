import SwiftUI
import UIKit

struct ContentView: View {
    
    // Device information state variables
    @State private var deviceModel: String = ""
    @State private var systemVersion: String = ""
    @State private var systemName: String = ""
    @State private var type: String = ""
    
    var body: some View {
        VStack {
            // Display device information
            Text("Device Model: \(deviceModel)")
            Text("System Version: \(systemVersion)")
            Text("System Name: \(systemName)")
            Text("Type: \(type)")
            
            // Button to send information to the log server
            Button(action: {
                sendDeviceInfoToServer()
            }) {
                Text("Send Device Info")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
            }
        }
        .onAppear(perform: getDeviceInfo) // Get device info when view appears
        .padding()
    }
    
    // Function to gather device information
    func getDeviceInfo() {
        let device = UIDevice.current
        deviceModel = device.model
        systemVersion = device.systemVersion
        systemName = device.systemName
        
        // Check if the app is running on a simulator
#if targetEnvironment(simulator)
        type = "simulator"
#else
        type = "real"
#endif
    }
    
    // Function to send device information to a log server
    func sendDeviceInfoToServer() {
        guard let url = URL(string: "https://cbc1-2003-d8-6705-1800-ccd-a460-e96b-efc9.ngrok-free.app/logs") else { return }
        
        // Prepare the data to send
        let parameters: [String: Any] = [
            "deviceModel": deviceModel,
            "systemVersion": systemVersion,
            "systemName": systemName,
            "type": type
        ]
        
        // Convert the data to JSON
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        
        // Prepare the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        // Send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending data: \(error.localizedDescription)")
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                print("Data successfully sent to the server.")
            } else {
                print("Failed to send data.")
            }
        }
        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
