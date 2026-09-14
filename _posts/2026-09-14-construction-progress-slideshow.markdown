---
layout: post
title: "Construction Site Progress Slideshow"
date: 2026-09-14 12:00:00 +0200
modified: 2026-09-14 12:00:00 +0200
draft: false
categories: [Project, Construction]
tags: [Construction, Progress, Slideshow, Timeline]
---

Here is a chronological visual timeline of the construction site progress, captured from start to finish. I'll add new impressions as soon as they're available.

<div class="slideshow-container">
  <div class="slide-header">
    <span id="slide-counter" class="badge">1 / 15</span>
    <span id="slide-date" class="date-badge">August 21, 2026 - 19:50</span>
  </div>

  <div class="slide-main">
    <button class="nav-btn prev-btn" onclick="prevSlide()" title="Previous Image">&#10094;</button>
    <div class="image-wrapper">
      <img id="main-slide-img" src="/images/ass/IMG_6983.jpg" alt="Construction Progress" loading="eager" />
    </div>
    <button class="nav-btn next-btn" onclick="nextSlide()" title="Next Image">&#10095;</button>
  </div>

  <div class="controls-bar">
    <button id="play-pause-btn" class="control-btn" onclick="togglePlay()">⏸ Pause</button>
    <div class="timeline-slider-wrapper">
      <input type="range" id="timeline-slider" min="0" max="14" value="0" oninput="slideFromSlider(this.value)">
    </div>
  </div>

  <div class="thumbnail-strip" id="thumbnail-strip">
    <!-- Thumbnails populated by JS -->
  </div>
</div>

<style>
.slideshow-container {
  background: #1a1a1a;
  border-radius: 12px;
  padding: 1.5rem;
  box-shadow: 0 10px 30px rgba(0,0,0,0.3);
  color: #fff;
  max-width: 900px;
  margin: 1.5rem auto;
}

.slide-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
  font-family: monospace;
  font-size: 0.95rem;
}

.badge, .date-badge {
  background: rgba(255,255,255,0.1);
  padding: 0.3rem 0.8rem;
  border-radius: 20px;
  color: #e0e0e0;
}

.slide-main {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #000;
  border-radius: 8px;
  overflow: hidden;
  height: 500px;
}

.image-wrapper {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.image-wrapper img {
  max-width: 100%;
  max-height: 100%;
  object-fit: contain;
  transition: opacity 0.3s ease-in-out;
}

.nav-btn {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  background: rgba(0, 0, 0, 0.6);
  color: white;
  border: none;
  font-size: 1.5rem;
  padding: 1rem 0.8rem;
  cursor: pointer;
  z-index: 10;
  border-radius: 4px;
  transition: background 0.2s;
}

.nav-btn:hover {
  background: rgba(255, 255, 255, 0.3);
}

.prev-btn { left: 10px; }
.next-btn { right: 10px; }

.controls-bar {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-top: 1rem;
  padding: 0.5rem 0;
}

.control-btn {
  background: #2ea44f;
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 6px;
  cursor: pointer;
  font-weight: bold;
  transition: background 0.2s;
  white-space: nowrap;
}

.control-btn:hover {
  background: #2c974b;
}

.timeline-slider-wrapper {
  flex-grow: 1;
}

#timeline-slider {
  width: 100%;
  cursor: pointer;
  accent-color: #2ea44f;
}

.thumbnail-strip {
  display: flex;
  gap: 8px;
  overflow-x: auto;
  margin-top: 1rem;
  padding-bottom: 0.5px;
  scrollbar-width: thin;
}

.thumbnail-strip::-webkit-scrollbar {
  height: 6px;
}

.thumbnail-strip::-webkit-scrollbar-thumb {
  background: #444;
  border-radius: 3px;
}

.thumbnail {
  flex: 0 0 70px;
  height: 50px;
  border-radius: 4px;
  overflow: hidden;
  cursor: pointer;
  opacity: 0.5;
  border: 2px solid transparent;
  transition: all 0.2s;
}

.thumbnail img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.thumbnail.active {
  opacity: 1;
  border-color: #2ea44f;
  transform: scale(1.05);
}

.thumbnail:hover {
  opacity: 0.8;
}

@media (max-width: 768px) {
  .slide-main {
    height: 350px;
  }
}
</style>

<script>
const slides = [
  { path: "/images/ass/IMG_6983.jpg", date: "August 21, 2026 - 19:50" },
  { path: "/images/ass/IMG_6984.jpg", date: "August 21, 2026 - 19:50" },
  { path: "/images/ass/IMG_7031.jpg", date: "August 30, 2026 - 14:31" },
  { path: "/images/ass/IMG_7032.jpg", date: "August 30, 2026 - 14:46" },
  { path: "/images/ass/IMG_7033.jpg", date: "August 30, 2026 - 14:46" },
  { path: "/images/ass/IMG_7034.jpg", date: "August 30, 2026 - 14:46" },
  { path: "/images/ass/IMG_7046.jpg", date: "September 04, 2026 - 19:51" },
  { path: "/images/ass/IMG_7047.jpg", date: "September 04, 2026 - 19:51" },
  { path: "/images/ass/IMG_7048.jpg", date: "September 04, 2026 - 19:51" },
  { path: "/images/ass/IMG_7049.jpg", date: "September 04, 2026 - 19:51" },
  { path: "/images/ass/IMG_7050.jpg", date: "September 04, 2026 - 19:51" },
  { path: "/images/ass/IMG_7092.jpg", date: "September 10, 2026 - 19:29" },
  { path: "/images/ass/IMG_7091.jpg", date: "September 10, 2026 - 19:29" },
  { path: "/images/ass/IMG_7089.jpg", date: "September 11, 2026 - 07:46" },
  { path: "/images/ass/IMG_7090.jpg", date: "September 11, 2026 - 07:46" }
];

let currentIndex = 0;
let isPlaying = true;
let slideInterval = setInterval(nextSlide, 3500);

const mainImg = document.getElementById('main-slide-img');
const slideCounter = document.getElementById('slide-counter');
const slideDate = document.getElementById('slide-date');
const timelineSlider = document.getElementById('timeline-slider');
const playPauseBtn = document.getElementById('play-pause-btn');
const thumbnailStrip = document.getElementById('thumbnail-strip');

function initThumbnails() {
  thumbnailStrip.innerHTML = '';
  slides.forEach((slide, idx) => {
    const thumb = document.createElement('div');
    thumb.className = `thumbnail ${idx === 0 ? 'active' : ''}`;
    thumb.onclick = () => goToSlide(idx);
    thumb.innerHTML = `<img src="${slide.path}" alt="Thumb ${idx + 1}" loading="lazy" />`;
    thumbnailStrip.appendChild(thumb);
  });
}

function updateSlide() {
  mainImg.style.opacity = '0.2';
  setTimeout(() => {
    mainImg.src = slides[currentIndex].path;
    mainImg.style.opacity = '1';
  }, 150);

  slideCounter.textContent = `${currentIndex + 1} / ${slides.length}`;
  slideDate.textContent = slides[currentIndex].date;
  timelineSlider.value = currentIndex;

  const thumbs = thumbnailStrip.children;
  for (let i = 0; i < thumbs.length; i++) {
    thumbs[i].classList.toggle('active', i === currentIndex);
  }
  if (thumbs[currentIndex]) {
    thumbs[currentIndex].scrollIntoView({ behavior: 'smooth', inline: 'center', block: 'nearest' });
  }
}

function nextSlide() {
  currentIndex = (currentIndex + 1) % slides.length;
  updateSlide();
}

function prevSlide() {
  currentIndex = (currentIndex - 1 + slides.length) % slides.length;
  updateSlide();
}

function goToSlide(index) {
  currentIndex = index;
  updateSlide();
}

function slideFromSlider(val) {
  currentIndex = parseInt(val);
  updateSlide();
}

function togglePlay() {
  if (isPlaying) {
    clearInterval(slideInterval);
    playPauseBtn.textContent = '▶ Play';
    isPlaying = false;
  } else {
    slideInterval = setInterval(nextSlide, 3500);
    playPauseBtn.textContent = '⏸ Pause';
    isPlaying = true;
  }
}

document.addEventListener('keydown', (e) => {
  if (e.key === 'ArrowRight') {
    nextSlide();
  } else if (e.key === 'ArrowLeft') {
    prevSlide();
  } else if (e.key === ' ') {
    e.preventDefault();
    togglePlay();
  }
});

initThumbnails();
</script>
