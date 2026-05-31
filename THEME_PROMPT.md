# NEXUS // AGENTS — Design System Brief

Paste this block before any UI brief you give another agent. It locks them into the same visual universe.

---

You are building UI in the "NEXUS" visual language: an immersive, cinematic sci-fi operator console. The mood is a dark, neon, futuristic gaming/film intro — think Blade Runner 2049 HUD, Apple Vision Pro demo, Death Stranding menus, Arc browser easter eggs. Every screen should feel like the operator console of a constellation of AI agents, not a "dashboard."

## 1 · Overall feel
- Dark, deep-space background — never pure black, always tinted indigo.
- Glowing neon accents (cyan, violet, magenta) over a near-black canvas.
- Floating, layered glassmorphism — cards that look like holograms.
- Parallax + depth — multiple z-layers that react to mouse/scroll.
- Cinematic, restrained motion — nothing bouncy, no Material ripples.
- Always a sense of *system* — frame counters, coords, sync indicators, tiny HUD elements in the corners.

## 2 · Color palette (exact)
```
--bg-0:        #02030a    /* primary canvas — near black, slight blue */
--bg-1:        #06061a    /* elevated surfaces */
--ink:         #e8ecff    /* primary text */
--ink-dim:     #9aa3c7    /* secondary text, labels */
--cyan:        #5ee9ff    /* primary accent — links, pings, active */
--violet:      #9b6bff    /* secondary accent — gradients */
--magenta:     #ff4fd8    /* tertiary accent — alerts, hot states */
--lime:        #b8ff5e    /* success */
--amber:       #ffb547    /* warning */
--line:        rgba(255,255,255,.08)   /* hairline borders */
--glass:       rgba(255,255,255,.04)   /* default glass tint */
--glass-strong:rgba(255,255,255,.07)
```
Gradient signature: `linear-gradient(120deg, #5ee9ff 0%, #9b6bff 50%, #ff4fd8 100%)`. Use it sparingly — on titles, primary buttons, and one or two accent strokes.

## 3 · Typography
Three fonts (Google Fonts):
- **Orbitron** — display, hero titles, brand, big numbers. Weights 700/900. Letter-spacing 0.01–0.06em. Used uppercase.
- **Space Grotesk** — body, descriptions, paragraphs. Weights 300–600.
- **JetBrains Mono** — labels, HUD chips, terminal, technical readouts, timestamps. Weights 300/400/500. Letter-spacing 0.18–0.32em on uppercase tags (very wide tracking is a signature).

Title pattern (3 rows): one solid, one gradient-clipped, one stroke-only. Hero title is 11vw clamp, line-height 0.88, all caps. Section titles are 5.6vw clamp, with one word in the gradient.

## 4 · Layout
- Full-bleed 100vh sections with 120px vertical padding, 8vw side padding.
- Sticky transparent HUD bar at top (glass + blur).
- HUD corners (4 corners of the viewport): tiny JetBrains Mono readouts showing coords, sector, operator, frame counter, temperature, UTC clock.
- Bento grids — featured tile (span 6×2 rows) + smaller tiles around it.
- Section eyebrows: `// 02 · SECTION NAME` — slash-slash + zero-padded number + caps + cyan + a leading 24px hairline.

## 5 · Core components
**Glass cards:** `background: var(--glass-strong); border: 1px solid var(--line); border-radius: 18–24px; backdrop-filter: blur(20–24px) saturate(180%); box-shadow: 0 30px 80px -30px rgba(0,0,0,.6), inset 0 1px 0 rgba(255,255,255,.06);` Hover: lift -6px, border-color cyan @ 30%, cyan glow shadow.

**Primary button:** pill (`border-radius: 999px`), gradient background (cyan→violet), black text, JetBrains Mono 11px, letter-spacing 0.24em, UPPERCASE, trailing arrow inside a black circle. Hover: -2px lift, brighter glow.

**Ghost button:** glass + 1px line border, pill, leading cyan dot with glow. Hover: border becomes cyan.

**HUD chips / eyebrows:** glass pill + leading pulsing 6px dot (cyan/magenta/lime), JetBrains Mono 10–11px, letter-spacing 0.24–0.32em, UPPERCASE.

**Sci-fi terminal:** dark glass box, 3 traffic-light dots, `agent@host — /path` title bar, JetBrains Mono body, prompt `nexus >` in cyan, output in dim grey, ✓ in lime, ! in amber, ✗ in magenta. Blinking cyan block cursor.

**Navigation:** pill-shaped glass container, JetBrains Mono caps 10.5px, active item has a tiny cyan dot to its left (not an underline).

## 6 · Motion
- Boot loader on first paint: brand + thin progress bar + status log text → fades after ~2.2s.
- Scroll-reveal: opacity 0 + translateY 40px → in. `cubic-bezier(.2,.8,.2,1)` over 1s. Stagger with `reveal-d2 / d3 / d4` (100ms each).
- Hero glass cards parallax on mouse — translate3d + rotateX/rotateY, multiplied by a per-card "depth" attribute.
- Hero title has a subtle RGB-split glitch on the stroked row every 4s.
- Custom cursor: tiny solid cyan dot + lagging 38px ring (mix-blend screen). Ring expands to 64px and turns magenta on interactive elements.
- Marquee strip: large outline-stroke Orbitron caps scrolling sideways with cyan dot separators.
- Counters animate from 0 to N with eased deceleration on intersection.
- Hover on list items: 14px left slide + faint cyan gradient wash.
- Never use spring bounces. Always smooth ease-out or cubic-bezier.

## 7 · WebGL / background
Mandatory immersive background:
- Three.js (r128+) scene as a fixed full-viewport canvas, behind all UI.
- Volumetric nebula via custom GLSL fragment shader on a fullscreen plane — 6-octave fbm noise, blended between cyan / violet / magenta / near-black, with a vignette and a warm "mouse spot."
- 3,000–5,000 GPU-shaded particles arranged on a squashed galactic disk, additive blending, drifting with sin/cos seeded motion, slow rotation, parallax on cursor + scroll.
- 4–6 wireframe geometry "drifters" — icosahedron, octahedron, torus, dodecahedron — slowly rotating, low opacity, scene fog.
- Foreground overlay: SVG film grain (low opacity) + scanlines (repeating-linear-gradient) + radial vignette.

For local 3D inside cards (orbs, schematics): separate Three.js canvases per card, transparent background, wireframe + orbiting rings + a small particle cloud. Always rotating.

## 8 · Copy / voice
Write like a sci-fi operator console, not marketing.
- Section eyebrows are numbered: `// 02 · THE AGENTS`.
- Headlines are 3-beat, period-ended: "Six minds. One mesh. Zero latency."
- Buttons are verbs: "Activate the mesh", "Open queue", "Request access".
- Body copy stays under 2 sentences per card. No fluff, no superlatives.
- Use the words: mesh, agent, signal, sync, drift, lattice, observer, operator, frequency, channel, console.
- Numbers feel important — show repos indexed, docs generated, latency in ms, coverage %.
- Timestamps + coordinates in HUD corners are aesthetic, not informational. Use plausible values.

## 9 · Tech baseline
- HTML/CSS/JS single-file or framework-agnostic.
- Three.js r128 from cdnjs, GSAP 3.12 from cdnjs (or framer-motion if React).
- Google Fonts: Orbitron, Space Grotesk, JetBrains Mono.
- No icon libraries — draw small marks with CSS or inline SVG.
- No Material/Bootstrap/AntD components — everything bespoke.
- Mobile: collapse bentos to single column, hide HUD corners + nav, keep the 3D background but lower particle count to ~1500.

## 10 · What to avoid
- Light mode. Never.
- Solid drop shadows, hard corners on inputs.
- Stock illustrations, 3D blobs from Spline templates, gradient blobs.
- Material Design ripples, large border radii on buttons (>24px).
- Centered hero layouts with a single big button (too SaaS-landing).
- Emojis in UI copy.
- "Get started for free" CTA language.
- Any color outside the palette above.

---

End of brief. Build like it's a 2030s mission-control console.
