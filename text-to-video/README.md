# Text to Video Converter

A modern web application that converts long text into engaging videos with automatic narration and beautiful visuals.

## Features

- 📝 **Text Input**: Enter any long-form text content
- 🎨 **Customizable Design**: Adjust font size, colors, and duration
- 🎙️ **Voice Narration**: Automatic text-to-speech narration (optional)
- 🎬 **Video Generation**: Creates professional-looking videos from your text
- 📥 **Download**: Save your generated videos in WebM format
- 📊 **Real-time Progress**: Track video generation progress
- 📱 **Responsive Design**: Works on all device sizes

## How It Works

1. **Enter Text**: Paste or type your long text into the text area
2. **Customize Settings**: 
   - Adjust font size (24-72px)
   - Choose background and text colors
   - Set duration per slide (2-10 seconds)
   - Enable/disable voice narration
3. **Generate Video**: Click the "Generate Video" button
4. **Preview & Download**: Watch your video and download it

## Technology Stack

- **Next.js 16** - React framework with App Router
- **TypeScript** - Type-safe development
- **Tailwind CSS** - Modern styling
- **HTML5 Canvas** - Video frame rendering
- **MediaRecorder API** - Video recording
- **Web Speech API** - Text-to-speech narration

## Getting Started

### Prerequisites

- Node.js 18+ installed
- Modern web browser with MediaRecorder API support

### Installation

```bash
# Install dependencies
npm install

# Run development server
npm run dev

# Build for production
npm run build

# Start production server
npm start
```

### Usage

1. Open your browser and navigate to `http://localhost:3000`
2. Enter your text in the text area
3. Customize video settings as desired
4. Click "Generate Video"
5. Wait for the video to be generated
6. Preview and download your video

## Video Generation Process

The application:
1. Splits your text into manageable chunks (15 words per slide)
2. Renders each chunk on a canvas with your chosen styling
3. Optionally narrates each chunk using text-to-speech
4. Records the canvas as a video stream
5. Combines all frames into a single video file
6. Provides the video for preview and download

## Browser Compatibility

- Chrome/Edge: Full support
- Firefox: Full support
- Safari: Partial support (MediaRecorder API limitations)
- Opera: Full support

## Limitations

- Video format: WebM (VP9 codec)
- Maximum recommended text length: 5000 words
- Voice narration requires browser support for Web Speech API
- Video quality depends on browser's MediaRecorder implementation

## Tips for Best Results

- Keep text chunks concise for better readability
- Use high contrast between text and background colors
- Adjust font size based on text length
- Enable voice narration for better engagement
- Test different duration settings for optimal pacing

## License

MIT License - Feel free to use and modify as needed.

## Support

For issues or questions, please open an issue on the repository.
