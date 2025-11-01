"use client";

import { useState, useRef } from "react";
import VideoGenerator from "@/components/VideoGenerator";

export default function Home() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-50 via-white to-blue-50">
      <div className="container mx-auto px-4 py-8">
        <header className="text-center mb-12">
          <h1 className="text-5xl font-bold text-gray-900 mb-4">
            Text to Video Converter
          </h1>
          <p className="text-xl text-gray-600 max-w-2xl mx-auto">
            Transform your long text into engaging videos with automatic narration and beautiful visuals
          </p>
        </header>
        
        <VideoGenerator />
        
        <footer className="mt-16 text-center text-gray-500 text-sm">
          <p>Convert your text into professional videos in seconds</p>
        </footer>
      </div>
    </div>
  );
}
