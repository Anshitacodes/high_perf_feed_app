# high_perf_feed_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
:::writing{variant="standard" id="48291"}
High Performance Feed App
Overview

This Flutter application implements a high-performance social media feed focusing on GPU optimization, RAM efficiency, and responsive UI using Riverpod for state management.

Features
1. Infinite Feed
Implemented using REST APIs with pagination (10 posts per request)
Pull-to-refresh supported
2. GPU Optimization
Each post card is wrapped in RepaintBoundary
Heavy BoxShadow used without affecting scroll performance
3. RAM Optimization
Images use cacheWidth to match UI size
Prevents unnecessary memory usage
4. Hero Animation & Tiered Loading
Smooth Hero transition from feed to detail screen
Thumbnail loads instantly
High-resolution image loads asynchronously with fade-in effect
5. Optimistic UI (Likes)
UI updates instantly on like
Supabase RPC runs in background
Handles failure with UI rollback and Snackbar
6. Edge Case Handling
Spam click protection using request control
Offline support with automatic revert on failure
Smooth scrolling without frame drops
Tech Stack
Flutter
Riverpod
Supabase
Demo

(Attach your screen recording link here)

Notes
Demo images sourced from placeholder APIs
Focus was on performance and architecture rather than design
:::
