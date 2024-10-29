# LogAnywhere

A practical guide for building a log server using Express.js, ngrok and Swift. This setup allows devices without localhost access to send logs via an ngrok URL, making remote logging easy and accessible.

## Getting Started

### Starting the Log Server

1. **Clone the repository:**

   ```sh
   git clone https://github.com/yourusername/LogAnywhere.git
   cd LogAnywhere
   ```

2. **Change to log server directory:**

   ```sh
   cd log-server
   ```

3. **Install dependencies:**

   ```sh
   npm install
   ```

4. **Start the server:**
   ```sh
   node server.js
   ```

### Setting Up ngrok

To expose your local server to the internet, you need to use ngrok. Follow the instructions in the [ngrok README](https://github.com/wickenico/LogAnywhere/tree/5605a96c05df98a6860892e8ea5c7f4107aa3a6a/ngrok) to set up ngrok and obtain a public URL.

### Using the Swift App to Send Logs

1. **Open the Swift project:**

   - Navigate to the `DeviceInfoLogger` directory.
   - Open `SwiftApp.xcodeproj` in Xcode.

2. **Configure the ngrok URL:**

   - In the Swift project, locate the configuration file where the server URL is set.
   - Replace the existing URL with your ngrok URL.

3. **Run the Swift app:**
   - Build and run the app on your device or simulator.
   - Use the app interface to send logs to your server.

### Example

Here's an example of how to send a log from the Swift app:

```swift
let logMessage = "This is a test log message."
sendLog(message: logMessage)
```

Your logs should now be visible on the server console.
