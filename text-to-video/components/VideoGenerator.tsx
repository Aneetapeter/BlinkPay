"use client";

import { useState, useRef, useEffect } from "react";

interface VideoSettings {
  fontSize: number;
  backgroundColor: string;
  textColor: string;
  duration: number;
  voiceEnabled: boolean;
}

export default function VideoGenerator() {
  const [text, setText] = useState("");
  const [isGenerating, setIsGenerating] = useState(false);
  const [progress, setProgress] = useState(0);
  const [videoUrl, setVideoUrl] = useState<string | null>(null);
  const [settings, setSettings] = useState<VideoSettings>({
    fontSize: 48,
    backgroundColor: "#1a1a2e",
    textColor: "#ffffff",
    duration: 3,
    voiceEnabled: true,
  });

  const canvasRef = useRef<HTMLCanvasElement>(null);
  const videoRef = useRef<HTMLVideoElement>(null);

  const wordCount = text.trim().split(/\s+/).filter(Boolean).length;
  const charCount = text.length;

  const splitTextIntoChunks = (text: string, wordsPerChunk: number = 15): string[] => {
    const words = text.trim().split(/\s+/);
    const chunks: string[] = [];
    
    for (let i = 0; i < words.length; i += wordsPerChunk) {
      chunks.push(words.slice(i, i + wordsPerChunk).join(" "));
    }
    
    return chunks;
  };

  const wrapText = (
    ctx: CanvasRenderingContext2D,
    text: string,
    x: number,
    y: number,
    maxWidth: number,
    lineHeight: number
  ): number => {
    const words = text.split(" ");
    let line = "";
    let currentY = y;

    for (let n = 0; n < words.length; n++) {
      const testLine = line + words[n] + " ";
      const metrics = ctx.measureText(testLine);
      const testWidth = metrics.width;

      if (testWidth > maxWidth && n > 0) {
        ctx.fillText(line, x, currentY);
        line = words[n] + " ";
        currentY += lineHeight;
      } else {
        line = testLine;
      }
    }
    ctx.fillText(line, x, currentY);
    return currentY;
  };

  const generateVideoFrame = (
    canvas: HTMLCanvasElement,
    text: string,
    settings: VideoSettings
  ) => {
    const ctx = canvas.getContext("2d");
    if (!ctx) return;

    canvas.width = 1920;
    canvas.height = 1080;

    ctx.fillStyle = settings.backgroundColor;
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    ctx.fillStyle = settings.textColor;
    ctx.font = `${settings.fontSize}px Arial, sans-serif`;
    ctx.textAlign = "center";
    ctx.textBaseline = "middle";

    const maxWidth = canvas.width - 200;
    const lineHeight = settings.fontSize * 1.5;
    const startY = canvas.height / 2 - (lineHeight * 2);

    wrapText(ctx, text, canvas.width / 2, startY, maxWidth, lineHeight);
  };

  const speakText = async (text: string): Promise<number> => {
    return new Promise((resolve) => {
      if (!settings.voiceEnabled || !window.speechSynthesis) {
        resolve(settings.duration * 1000);
        return;
      }

      const utterance = new SpeechSynthesisUtterance(text);
      utterance.rate = 0.9;
      utterance.pitch = 1;
      utterance.volume = 1;

      const startTime = Date.now();
      
      utterance.onend = () => {
        const duration = Date.now() - startTime;
        resolve(Math.max(duration, settings.duration * 1000));
      };

      utterance.onerror = () => {
        resolve(settings.duration * 1000);
      };

      window.speechSynthesis.speak(utterance);
    });
  };

  const generateVideo = async () => {
    if (!text.trim() || !canvasRef.current) return;

    setIsGenerating(true);
    setProgress(0);
    setVideoUrl(null);

    try {
      const canvas = canvasRef.current;
      const chunks = splitTextIntoChunks(text);
      const stream = canvas.captureStream(30);
      
      const mediaRecorder = new MediaRecorder(stream, {
        mimeType: "video/webm;codecs=vp9",
        videoBitsPerSecond: 2500000,
      });

      const recordedChunks: Blob[] = [];

      mediaRecorder.ondataavailable = (event) => {
        if (event.data.size > 0) {
          recordedChunks.push(event.data);
        }
      };

      mediaRecorder.onstop = () => {
        const blob = new Blob(recordedChunks, { type: "video/webm" });
        const url = URL.createObjectURL(blob);
        setVideoUrl(url);
        setIsGenerating(false);
        setProgress(100);
      };

      mediaRecorder.start();

      for (let i = 0; i < chunks.length; i++) {
        generateVideoFrame(canvas, chunks[i], settings);
        setProgress(((i + 1) / chunks.length) * 90);
        
        const duration = await speakText(chunks[i]);
        await new Promise((resolve) => setTimeout(resolve, duration));
      }

      mediaRecorder.stop();
      
      if (settings.voiceEnabled && window.speechSynthesis) {
        window.speechSynthesis.cancel();
      }

    } catch (error) {
      console.error("Error generating video:", error);
      setIsGenerating(false);
      alert("Error generating video. Please try again.");
    }
  };

  const downloadVideo = () => {
    if (!videoUrl) return;

    const a = document.createElement("a");
    a.href = videoUrl;
    a.download = `text-to-video-${Date.now()}.webm`;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
  };

  useEffect(() => {
    return () => {
      if (videoUrl) {
        URL.revokeObjectURL(videoUrl);
      }
    };
  }, [videoUrl]);

  return (
    <div className="max-w-6xl mx-auto">
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <div className="space-y-6">
          <div className="bg-white rounded-2xl shadow-lg p-6">
            <label className="block text-sm font-semibold text-gray-700 mb-2">
              Your Text
            </label>
            <textarea
              value={text}
              onChange={(e) => setText(e.target.value)}
              placeholder="Enter your long text here... The text will be automatically split into slides and converted into a video with narration."
              className="w-full h-64 p-4 border-2 border-gray-200 rounded-xl focus:border-purple-500 focus:ring-2 focus:ring-purple-200 outline-none transition-all resize-none"
            />
            <div className="flex justify-between text-sm text-gray-500 mt-2">
              <span>{wordCount} words</span>
              <span>{charCount} characters</span>
            </div>
          </div>

          <div className="bg-white rounded-2xl shadow-lg p-6">
            <h3 className="text-lg font-semibold text-gray-800 mb-4">
              Video Settings
            </h3>
            
            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Font Size: {settings.fontSize}px
                </label>
                <input
                  type="range"
                  min="24"
                  max="72"
                  value={settings.fontSize}
                  onChange={(e) =>
                    setSettings({ ...settings, fontSize: parseInt(e.target.value) })
                  }
                  className="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-purple-600"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Duration per Slide: {settings.duration}s
                </label>
                <input
                  type="range"
                  min="2"
                  max="10"
                  value={settings.duration}
                  onChange={(e) =>
                    setSettings({ ...settings, duration: parseInt(e.target.value) })
                  }
                  className="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-purple-600"
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Background Color
                  </label>
                  <input
                    type="color"
                    value={settings.backgroundColor}
                    onChange={(e) =>
                      setSettings({ ...settings, backgroundColor: e.target.value })
                    }
                    className="w-full h-12 rounded-lg cursor-pointer"
                  />
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Text Color
                  </label>
                  <input
                    type="color"
                    value={settings.textColor}
                    onChange={(e) =>
                      setSettings({ ...settings, textColor: e.target.value })
                    }
                    className="w-full h-12 rounded-lg cursor-pointer"
                  />
                </div>
              </div>

              <div className="flex items-center">
                <input
                  type="checkbox"
                  id="voiceEnabled"
                  checked={settings.voiceEnabled}
                  onChange={(e) =>
                    setSettings({ ...settings, voiceEnabled: e.target.checked })
                  }
                  className="w-5 h-5 text-purple-600 rounded focus:ring-2 focus:ring-purple-500"
                />
                <label htmlFor="voiceEnabled" className="ml-3 text-sm font-medium text-gray-700">
                  Enable Voice Narration
                </label>
              </div>
            </div>
          </div>

          <button
            onClick={generateVideo}
            disabled={isGenerating || !text.trim()}
            className="w-full bg-gradient-to-r from-purple-600 to-blue-600 text-white font-semibold py-4 px-6 rounded-xl hover:from-purple-700 hover:to-blue-700 disabled:from-gray-400 disabled:to-gray-500 disabled:cursor-not-allowed transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5"
          >
            {isGenerating ? "Generating Video..." : "Generate Video"}
          </button>

          {isGenerating && (
            <div className="bg-white rounded-2xl shadow-lg p-6">
              <div className="flex items-center justify-between mb-2">
                <span className="text-sm font-medium text-gray-700">Progress</span>
                <span className="text-sm font-medium text-purple-600">{Math.round(progress)}%</span>
              </div>
              <div className="w-full bg-gray-200 rounded-full h-3 overflow-hidden">
                <div
                  className="bg-gradient-to-r from-purple-600 to-blue-600 h-full rounded-full transition-all duration-300"
                  style={{ width: `${progress}%` }}
                />
              </div>
            </div>
          )}
        </div>

        <div className="space-y-6">
          <div className="bg-white rounded-2xl shadow-lg p-6">
            <h3 className="text-lg font-semibold text-gray-800 mb-4">
              Preview
            </h3>
            
            <canvas
              ref={canvasRef}
              className="w-full border-2 border-gray-200 rounded-lg hidden"
            />

            {videoUrl ? (
              <div className="space-y-4">
                <video
                  ref={videoRef}
                  src={videoUrl}
                  controls
                  className="w-full rounded-lg shadow-md"
                />
                <button
                  onClick={downloadVideo}
                  className="w-full bg-green-600 text-white font-semibold py-3 px-6 rounded-xl hover:bg-green-700 transition-all shadow-lg hover:shadow-xl"
                >
                  Download Video
                </button>
              </div>
            ) : (
              <div className="aspect-video bg-gray-100 rounded-lg flex items-center justify-center">
                <div className="text-center text-gray-400">
                  <svg
                    className="w-16 h-16 mx-auto mb-4"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z"
                    />
                  </svg>
                  <p className="text-sm">Your video will appear here</p>
                </div>
              </div>
            )}
          </div>

          <div className="bg-gradient-to-br from-purple-50 to-blue-50 rounded-2xl p-6 border border-purple-100">
            <h3 className="text-lg font-semibold text-gray-800 mb-3">
              How it works
            </h3>
            <ul className="space-y-2 text-sm text-gray-600">
              <li className="flex items-start">
                <span className="text-purple-600 mr-2">1.</span>
                <span>Enter your long text in the text area</span>
              </li>
              <li className="flex items-start">
                <span className="text-purple-600 mr-2">2.</span>
                <span>Customize video settings (colors, font size, duration)</span>
              </li>
              <li className="flex items-start">
                <span className="text-purple-600 mr-2">3.</span>
                <span>Click Generate Video to create your video</span>
              </li>
              <li className="flex items-start">
                <span className="text-purple-600 mr-2">4.</span>
                <span>Preview and download your video</span>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
}
