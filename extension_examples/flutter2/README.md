# Flutter QR - Current tab URL - Chrome extension

## Calls `chrome.tabs.query` to generate the QR Code using the URL of the current Chrome tab.

![Chrome extension in action](screenshots/qr-code-url-ext-demo.gif)

## Usage

To use this project as a Chrome extension, follow the steps below:

1. From the project directory, run:

   ```sh
   flutter build web --web-renderer html --csp
   ```

2. Go to the following URL from Chrome browser:

   ```url
   chrome://extensions
   ```

3. Enable the **Developer mode**.

4. Click **Load unpacked**. Select the `<project_dir>/build/web` folder.

This will install the extension to your Chrome browser and then you will be able to access the extension by clicking on the **extension icon**.
