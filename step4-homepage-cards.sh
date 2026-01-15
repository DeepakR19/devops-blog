#!/bin/bash

echo "==============================="
echo "STEP 4: Homepage Card Layout Setup"
echo "==============================="

mkdir -p content

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
    <p>Commands, internals, troubleshooting, and notes.</p>
    <a href="/linux/">Explore →</a>
  </div>

  <div class="card">
    <h3>🐳 Docker</h3>
    <p>Images, containers, networking, volumes.</p>
    <a href="/docker/">Explore →</a>
  </div>

  <div class="card">
    <h3>☸️ Kubernetes</h3>
    <p>Pods, deployments, services, Helm.</p>
    <a href="/kubernetes/">Explore →</a>
  </div>

  <div class="card">
    <h3>🔁 CI/CD</h3>
    <p>Jenkins, GitHub Actions, pipelines.</p>
    <a href="/cicd/">Explore →</a>
  </div>

  <div class="card">
    <h3>🧠 Scenarios</h3>
    <p>Real-world DevOps problems & solutions.</p>
    <a href="/scenarios/">Explore →</a>
  </div>

  <div class="card">
    <h3>✍️ Blog</h3>
    <p>Articles, learnings, and writeups.</p>
    <a href="/blog/">Explore →</a>
  </div>
</div>
EOL

echo "Homepage cards added successfully."
echo "==============================="
