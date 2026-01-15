---
title: "Home"
---

<style>
.dashboard {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
  gap: 24px;
  margin-top: 30px;
}

.card {
  background: var(--entry);
  border-radius: 14px;
  padding: 24px;
  text-decoration: none;
  color: inherit;
  box-shadow: 0 10px 25px rgba(0,0,0,0.25);
  transition: all 0.25s ease;
  display: block;
}

.card:hover {
  transform: translateY(-6px);
  box-shadow: 0 18px 40px rgba(0,0,0,0.35);
}

.card h3 {
  margin: 0;
  font-size: 1.2rem;
}

.card p {
  opacity: 0.8;
  margin-top: 8px;
  font-size: 0.95rem;
}
</style>

# DevOps Knowledge Hub

Everything I learn and practice in DevOps — structured and documented.

<div class="dashboard">

<a class="card" href="/linux/">
  <h3>🐧 Linux</h3>
  <p>Commands, internals, troubleshooting</p>
</a>

<a class="card" href="/git/">
  <h3>🌱 Git</h3>
  <p>Version control, workflows, branching</p>
</a>

<a class="card" href="/cicd/">
  <h3>🔁 CI/CD</h3>
  <p>Pipelines, automation, deployments</p>
</a>

<a class="card" href="/cloud/">
  <h3>☁️ Cloud</h3>
  <p>AWS, Azure, GCP fundamentals</p>
</a>

<a class="card" href="/docker/">
  <h3>🐳 Docker</h3>
  <p>Containers, images, volumes</p>
</a>

<a class="card" href="/kubernetes/">
  <h3>☸️ Kubernetes</h3>
  <p>Pods, services, scaling</p>
</a>

<a class="card" href="/terraform/">
  <h3>🏗 Terraform</h3>
  <p>IaC, modules, state</p>
</a>

<a class="card" href="/ansible/">
  <h3>⚙️ Ansible</h3>
  <p>Automation, playbooks</p>
</a>

<a class="card" href="/scenarios/">
  <h3>🧠 Scenarios</h3>
  <p>Real-world DevOps problems</p>
</a>

</div>
