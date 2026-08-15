# Site Accessibility (A11y) & Code Quality Audit Report

This report documents the accessibility (a11y) and structural audit of **C.W.A. - Coder with Attitude** (Jekyll static site). It includes findings, actionable checklists with checkboxes, and resources on how to resolve each issue.

---

## 1. Structure & Semantic Landmarks

* **Finding:** The site layout (`default.html`) uses `<header>`, `<section>`, and `<footer>`, but lacks a primary `<main>` landmark element (or `role="main"`).
* **Impact:** Screen reader users and assistive technologies rely on the `<main>` landmark to quickly navigate directly to the primary page content without parsing the header repeatedly.
* **Resources & Fixes:**
  * [W3C ARIA Main Landmark Pattern](https://www.w3.org/WAI/ARIA/apg/patterns/landmark-regions/#main)
  * [MDN: `<main>` element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/main)

- [ ] Wrap the primary content container in `<main>` or add `role="main"` in `default.html`.

---

## 2. Skip Navigation Links

* **Finding:** There is currently no "Skip to main content" link at the top of the document body.
* **Impact:** Keyboard-only users are forced to tab through all navigation items, headers, and secondary links on every page before reaching the main content.
* **Resources & Fixes:**
  * [WebAIM: Skip Navigation Links](https://webaim.org/techniques/skipnav/)
  * [CSS-Tricks: Skipping to Main Content](https://css-tricks.com/the-how-and-why-of-skip-links/)

- [ ] Add an accessible "Skip to content" link as the first focusable element in `default.html`.

---

## 3. Heading Hierarchy (WCAG 1.3.1)

* **Finding:** Several markdown posts and pages contain multiple top-level `<h1>` headings or skip heading levels (e.g., jumping from `<h1>` to `<h3>`).
* **Impact:** Screen readers use heading structures to generate a page outline. Broken hierarchies disorient users trying to scan the page content.
* **Resources & Fixes:**
  * [W3C Accessibility Tutorials: Headings](https://www.w3.org/WAI/tutorials/page-structure/headings/)
  * [WebAIM: Semantic Structure](https://webaim.org/techniques/semanticstructure/)

- [ ] Audit all markdown posts (`_posts/`) to ensure a single `<h1>` per page and sequential heading increments (`<h1>` -> `<h2>` -> `<h3>`).

---

## 4. Image Alternative Text (WCAG 1.1.1)

* **Finding:** Some images or banners across blog posts lack descriptive `alt` attributes or rely on ambiguous file names.
* **Impact:** Visually impaired users utilizing screen readers miss critical context conveyed by images.
* **Resources & Fixes:**
  * [WebAIM Alternative Text Guide](https://webaim.org/techniques/alttext/)
  * [W3C Images Tutorial](https://www.w3.org/WAI/tutorials/images/)

- [ ] Ensure all `<img>` tags have descriptive `alt` attributes (or `alt=""` if decorative).

---

## 5. Color Contrast & Focus Indicators (WCAG 1.4.3 & 2.4.7)

* **Finding:** The dark-themed remote theme (`pages-themes/hacker`) requires verification that link text colors meet minimum contrast ratios (4.5:1 for normal text) and that keyboard focus outlines (`:focus`) are clearly visible.
* **Impact:** Low-vision users may struggle to read low-contrast text, and keyboard users may lose track of their current focus position.
* **Resources & Fixes:**
  * [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
  * [MDN: Using `:focus` pseudo-class](https://developer.mozilla.org/en-US/docs/Web/CSS/:focus)

- [ ] Test color contrast ratios of text and background elements against WCAG AA standards.
- [ ] Ensure visible focus rings are maintained on interactive elements.

---

## Summary Action Checklist

- [ ] Wrap main content in `<main>` landmark (`default.html`)
- [ ] Add "Skip to content" keyboard navigation link
- [ ] Fix heading hierarchy across blog posts (`_posts/`)
- [ ] Add/verify descriptive `alt` text on all images
- [ ] Verify keyboard focus indicators and contrast ratios
