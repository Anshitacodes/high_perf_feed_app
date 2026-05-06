# High Performance Feed App

## Overview
This project is a Flutter-based mobile application that simulates a high-performance social media feed. The implementation focuses on smooth rendering, efficient memory usage, and responsive user interactions under real-world conditions using Riverpod for state management and Supabase as the backend.

---

## Features

### Infinite Feed
- REST-based data fetching with pagination (10 posts per request)
- Pull-to-refresh support
- Lazy loading as the user scrolls

### GPU Optimization
- Each post card is wrapped in `RepaintBoundary`
- Heavy `BoxShadow` applied without affecting scroll performance
- Prevents unnecessary repaints during fast scrolling

### RAM Optimization
- Images loaded using `cacheWidth` based on display size
- Ensures decoded image size matches UI requirements
- Reduces memory footprint and prevents OOM issues

### Hero Animation and Tiered Loading
- Smooth Hero transition from feed to detail screen
- Low-resolution thumbnail displayed instantly
- High-resolution image loaded asynchronously
- Fade-in transition using `AnimatedOpacity`

### Optimistic UI (Like System)
- Immediate UI update on user interaction
- Backend RPC executed asynchronously via Supabase
- Automatic UI rollback on failure
- Error feedback using Snackbar

### Edge Case Handling
- Spam click protection to prevent excessive API calls
- Offline handling with graceful state revert
- Stable UI performance under rapid scrolling

---

## Tech Stack
- Flutter
- Riverpod
- Supabase

---

## Demo
screen recording link here.
https://drive.google.com/file/d/1-YtQAzg_tvvXKZid40IEVR_z5oGU8RKO/view?usp=drive_link
---

## Project Structure
