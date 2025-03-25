# ✨ AI-Enhanced Home Design with Augmented Reality (HDA) ✨

**Visualize Your Dream Home, Instantly.**

HDA revolutionizes interior design by tackling common homeowner frustrations: visualizing changes, managing costs, and avoiding misaligned expectations. Our platform integrates cutting-edge **Augmented Reality (AR)** for real-time spatial visualization and **Artificial Intelligence (AI)** for personalized design recommendations, layout optimization, color selection, and cost insights.

**Problem:** Homeowners struggle to visualize how furniture, colors, and layouts will look in *their* actual space, leading to costly mistakes and dissatisfaction. Traditional design processes can be slow, expensive, and lack personalization.

**Solution:** HDA provides an intuitive mobile application (built with Flutter for cross-platform reach) allowing users to:
1.  **Scan** their physical room.
2.  Virtually **place and manipulate** furniture and decor in AR.
3.  Receive **AI-powered design suggestions** tailored to their style and space.
4.  Experiment with **wall colors** instantly.
5.  Get **real-time dimension** and product information.
6.  **Save, share, and even shop** for their favorite items.

---


## 🔥 Key Features

HDA packs powerful features to streamline the home design process:

### 1. 🛋️ Real-time AR Furniture Placement & Manipulation

Place virtual furniture and decor items directly into your room using your phone's camera.

*   **Intuitive Placement:** Simply select an item from the catalog and tap to place it in the AR view.
*   **Precise Manipulation:**
    *   Move items: Left, Right, Up, Down, Forward, Backward.
    *   Rotate items: Spin furniture 360 degrees.
    *   Resize items: Scale furniture to fit your space accurately.
*   **Texture Swapping:** Instantly change the fabric or material of selected items.
*   **Real-time Dimensions:** See the dimensions (Width x Depth x Height) of the selected virtual object displayed on screen.
*   **Capture Scene:** Take photos of your AR design creations.

<p align="center">
  <img src="assets/AR2.jpg" alt="AR Measurement Result" width="200">
  <img src="assets/ar3.jpg" alt="AR Measurement Result" width="200">
  <img src="assets/topAR.jpg" alt="AR Measurement Result" width="200">
  <img src="assets/AR1.jpg" alt="AR Measurement Result" width="200">
</p>

<p align="center">
  <img src="assets/c1.jpg" alt="AR Measurement Result" width="200">
  <img src="assets/c2.jpg" alt="AR Measurement Result" width="200">
  <img src="assets/c3.jpg" alt="AR Measurement Result" width="200">
  <img src="assets/ARvertical.jpg" alt="AR Measurement Result" width="200">
  <img src="assets/verticalAR.jpg" alt="AR Measurement Result" width="200">
</p>


### 2. 📏 AR Measurement Tool

Measure distances and areas within your physical space using AR pins.

*   **Length Measurement:** Place two points to measure the distance between them.
*   **Height Measurement:** Measure vertical distances.
*   **Area Calculation:** Define points to calculate the approximate area of a surface (e.g., a wall or floor section).

<p align="center">
  <img src="assets/areaMeasurement.jpg" alt="AR Measurement Result" width="200">
  <img src="assets/heightMeasurement.jpg" alt="AR Measurement Result" width="200">
</p>

### 3. 🎨 AI Wall Color Changer

Experiment with wall colors without lifting a paintbrush!

*   **Upload or Capture:** Use an existing photo of your room or capture a new one directly through the app.
*   **AI Segmentation:** Our AI automatically identifies the walls in your image.
*   **Color Selection:** Choose your desired color from a palette or input a specific code.
*   **Instant Visualization:** See your walls transformed with the new color in seconds.
<p align="center">
  <img src="assets/wallPaint.jpg" alt="wall color" width="200">
  <img src="assets/wallColor.jpg" alt="wall color" width="200">
  <img src="assets/wall2.jpg" alt="wall color" width="200">
  <img src="assets/wall3.jpg" alt="wall color" width="200">
</p>

### 4. 😊 AI Mood-Based Design Suggestions

Not sure where to start? Get design inspiration based on your desired mood (e.g., Cozy, Modern, Minimalist, Vibrant). The AI suggests color palettes and furniture styles that align with the chosen mood.

*   **Select Mood:** Choose from predefined mood options.
*   **Receive Suggestions:** Get tailored recommendations for colors, textures, and furniture types.

<p align="center">
  <img src="assets/mood.jpg" alt="wall color" width="200">
   <img src="assets/mood2.jpg" alt="wall color" width="200">
  <img src="assets/mood3.jpg" alt="wall color" width="200">
</p>

### 5. 💡 AI Design Assistant & Image Generation

Get contextual design advice and visualize AI-generated concepts.

*   **Upload Room Image:** Provide a photo of your current space.
*   **Specify Room Type:** Select the room category (Living Room, Kitchen, Bedroom, etc.).
*   **Receive Text Suggestions:** AI analyzes the image and provides actionable design tips, layout ideas, and item recommendations in text format.
*   **Text-to-Image Generation:** Convert the AI's textual suggestions (or your own prompts) into unique concept images, visualizing potential designs.

<p align="center">
  <img src="assets/suggest1.jpg" alt="wall color" width="200">
   <img src="assets/suggest2.jpg" alt="wall color" width="200">
  <img src="assets/suggest3.jpg" alt="wall color" width="200">
</p>

### 6. 🛒 Shopping & Saving Features

Found items you love? Save them for later or proceed towards making them a reality.

*   **Add to Favorites:** Save individual furniture items or entire design layouts.
*   **Add to Cart:** Curate a list of desired items (integration with actual e-commerce).
*   **Book Consultation:** Simulate booking a design consultation based on the curated items/design.

<p align="center">
   <img src="assets/furnitures.jpg" alt="order" width="200">
   <img src="assets/infoFur.jpg" alt="order" width="200">
   <img src="assets/cart1.jpg" alt="order" width="200">
   <img src="assets/myorder.jpg" alt="order" width="200">
   <img src="assets/detailOrder.jpg" alt="order" width="200">
</p>

### 7. 📲 Sharing Capabilities

Share your design creations and AI-generated concepts easily.

*   **Share AR Captures:** Export and share the photos taken within the AR view.
*   **Share AI Images:** Share the images generated by the AI Wall Color Changer and Text-to-Image features.
---

## ⚙️ How It Works (User Flow)

1.  **Scan Room:** User initiates AR mode and scans their physical space.
2.  **Browse & Select:** User explores the catalog and selects furniture/decor items.
3.  **Place & Arrange (AR):** User places items in AR, manipulating them (move, rotate, resize, change texture) until satisfied. Real-time dimensions are shown.
4.  **Measure (AR):** User optionally uses the AR tool to measure distances/areas.
5.  **AI Color Change:** User uploads/captures a room photo and applies virtual paint colors using AI segmentation.
6.  **AI Suggestions:** User uploads a room photo, selects type/mood, and receives AI text suggestions and/or generates concept images.
7.  **Save & Organize:** User saves favorite items, designs, and generated images.
8.  **Shop (Simulated):** User adds items to a cart or simulates booking.
9.  **Share:** User shares their creations via standard mobile sharing options.

---

## 🛠️ Technology Stack

*   **Frontend:** Flutter (Cross-platform Mobile App Development)
*   **Augmented Reality:** Native AR capabilities via Flutter plugins
*   **Backend & Database:** Firebase (Firestore for data storage, Firebase Storage for images, potentially Firebase Auth for users)
*   **Artificial Intelligence:**
    *   **Image Segmentation:** 
    *   **Design Recommendations/Text Generation**
    *   **Text-to-Image Generation:**
*   **State Management (Flutter):** 

---

## 🚀 Getting Started 

Instructions to get the project running locally.

1.  **Prerequisites:**
    *   Flutter SDK installed ([Flutter Installation Guide](https://flutter.dev/docs/get-started/install))
    *   Android Studio / VS Code (with Flutter plugins)
    *   An AR-compatible Android/iOS device.
    *   Firebase project setup.
2.  **Clone the repository:**
    ```bash
    git clone [Your Repository HTTPS/SSH Link]
    cd AI-Enhanced-Home-Design-AR
    ```
3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Configure Firebase:**
    *   Follow Firebase setup instructions for Flutter ([FlutterFire Overview](https://firebase.flutter.dev/docs/overview)).
    *   Place your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files in the correct directories (`android/app/` and `ios/Runner/`).
5.  **Configure API Keys (If necessary):**
    *   If using external AI APIs, ensure you have set up API keys securely (e.g., using environment variables or a configuration file - **DO NOT COMMIT KEYS DIRECTLY**). Add instructions here if needed.
6.  **Run the app:**
    ```bash
    flutter run
    ```
    *   Ensure your AR-compatible device is connected and selected.

---

## 📈 Future Scope

*   Enhanced AI recommendations (e.g., style transfer, lighting suggestions).
*   Wider range of furniture and decor models.
*   Real-time cost estimation integration with retailers.
*   Multi-user collaboration features.
*   Web-based viewer for shared designs.
*   Improved accuracy for AR measurements and placement.

---

## 👥 Team / Contributors

*   [Your Name/Team Member 1 Name] - [Role, e.g., Lead Developer, AR Specialist]
*   [Team Member 2 Name] - [Role, e.g., AI Engineer, UI/UX Designer]
    *   *(Add links to GitHub profiles if desired)*



**Made with ❤️ for the [Name of Hackathon]!**
