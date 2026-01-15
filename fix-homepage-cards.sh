#!/bin/bash

echo "==============================="
echo "FIX: Homepage Cards for PaperMod"
echo "==============================="

# Enable unsafe HTML rendering for cards
if ! grep -q "goldmark" hugo.toml; then
cat >> hugo.toml <<EOL

[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = true
EOL
fi

# Create homepage with card layout
cat > content/_index.md <<EOL
---
title: "Home"
---

<style>
.cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 20px;
  margin-top: 30px;
}
.card {
  padding: 20px;
  border-radius: 12px;
  background: var(--entry);
  box-shadow: 0 4px 10px rgba(0,0,0,0.2);
  transition: transform 0.2s ease;
}
.card:hover {
  transform: scale(1.03);
}
.card h3 {
  margin-top: 0;
}
.card a {
  text-decoration: none;
  font-weight: bold;
}
</style>

## Welcome 👋

This is my DevOps Knowledge Hub.

<div class="cards">
  <div class="card">
    <h3>🐧 Linux</h3>
    <p>Commands, internals, troubleshooting.</p>
    <a href="/linux/">Open →</a>
  </div>

  <div class="card">
    <h3>🐳 Docker</h3>
    <p>Images, containers, networking.</p>
    <a href="/docker/">Open →</a>
  </div>

  <div class="card">
    <h3>☸️ Kubernetes</h3>
    <p>Pods, services, Helm.</p>
    <a href="/kubernetes/">Open →</a>
  </div>

  <div class="card">
    <h3>🔁 CI/CD</h3>
    <p>Pipelines, automation.</p>
    <a href="/cicd/">Open →</a>
  </div>

  <div class="card">
    <h3>🧠 Scenarios</h3>
    <p>Real-world DevOps problems.</p>
    <a href="/scenarios/">Open →</a>
  </div>

  <div class="card">
    <h3>✍️ Blog</h3>
    <p>Articles & learnings.</p>
    <a href="/blog/">Open →</a>
  </div>
</div>
EOL

echo "Homepage cards applied."
echo "Restart Hugo: hugo server -D"
echo "==============================="
