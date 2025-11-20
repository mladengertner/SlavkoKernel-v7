# SlavkoKernel v7 — Enterprise Multi‑Agent Orchestration (Ollama Ready, Audit‑Proof, Zero‑Excuses)

[![CI/CD](https://github.com/mladengertner/SlavkoKernel-v7/actions/workflows/ci.yml/badge.svg)](https://github.com/mladengertner/SlavkoKernel-v7/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Python 3.10+](https://img.shields.io/badge/Python-3.10+-blue.svg)](https://www.python.org/downloads/)
[![Docker Ready](https://img.shields.io/badge/Docker-Ready-2496ED.svg)](docker/docker-compose.yaml)
[![Ollama Hub](https://img.shields.io/badge/Ollama-Hub-FF6B35.svg)](https://ollama.ai)

---

## Overview
SlavkoKernel v7 is the orchestration backbone for teams who refuse downtime, ambiguity, and vendor lock‑in. It coordinates specialized agents (Write, Code, Think, Image, Eval) with strict council governance, cryptographic audit trails, and declarative pipelines. Built to ship fast, scale hard, and leave competitors chasing patch notes.

---

## Why it’s needed
Modern AI workflows break under real pressure: inconsistent outputs, opaque decisions, flaky pipelines, and zero auditability. SlavkoKernel v7 fixes that with council‑governed agents, deterministic manifests, and cryptographic audit logs that turn every run into a traceable, reproducible artifact. This is the orchestration layer for teams who can’t afford “maybe” or “it worked locally”.

---

## Problems it eliminates
- **Inconsistency:** Deterministic, declarative pipelines replace ad‑hoc prompts and fragile scripts.
- **Opacity:** Council voting and decision logs make outcomes explainable and defensible.
- **Vendor lock‑in:** Ollama‑first design with swappable models and standardized I/O contracts.
- **Operational drift:** Immutable manifests and signed audits enforce reproducibility over time.
- **Observability gaps:** Built‑in metrics, logs, and dashboards expose performance and failure modes.
- **Security blind spots:** TLS 1.3, RBAC, JWT, and scoped keys cut privilege creep and leakage.

---

## What makes it game‑changing
- **Governed intelligence:** Agents don’t “guess”; they vote, justify, and leave a signed trail.
- **Enterprise reproducibility:** YAML/JSON manifests produce identical runs — across teams and regions.
- **Audit‑proof by design:** Every decision is traceable end‑to‑end, with optional cryptographic sealing.
- **Zero‑friction ops:** One‑line boot, ready dashboards, health checks, and CI/CD out of the box.
- **Scales without drama:** Postgres + Redis + Ollama with clean boundaries and horizontal growth paths.
- **Developer delight:** Clean APIs, examples, and contracts — reduce onboarding from days to minutes.

---

## Competitive proof points
- **Council governance:** Thresholds, quorum, and decision logs — not just “best‑effort prompts.”
- **Cryptographic audits:** Optional signing turns runs into tamper‑evident records.
- **Ollama‑native:** Local, portable, model‑agnostic — control your stack end‑to‑end.
- **Observability built‑in:** Prometheus, Grafana, structured logs — no extra glue required.
- **CI/CD ready:** Tests, releases, images, SBOM, and scans — ship confidently from day one.

---

## Key features
- **Multi‑agent orchestration:** Role separation, council voting, quorum thresholds  
- **Auditability:** Immutable, cryptographically signed manifests and decision logs  
- **Declarative pipelines:** YAML/JSON workflows with strict reproducibility guarantees  
- **Ollama Hub integration:** SlavkoFusion, SlavkoProtocol, SlavkoScore modules  
- **Enterprise security:** TLS 1.3, RBAC, JWT, scoped API keys  
- **Observability:** Prometheus metrics, Grafana dashboards, structured logs  
- **Operational stack:** Docker Compose (Postgres, Redis, Ollama, monitoring)  
- **CI/CD:** GitHub Actions for tests, builds, releases, and SBOM generation

---

## Quick start

Clone and deploy:
```bash
git clone https://github.com/mladengertner/SlavkoKernel-v7.git
cd SlavkoKernel-v7
docker-compose up -d
```

Local dev:
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn slavkokernel.main:app --reload
```

Smoke test:
```bash
curl -s http://localhost:8000/health
```

---

## Architecture
- **API layer:** FastAPI entrypoint with RBAC/JWT enforcement and rate limits
- **Council orchestrator:** Schedules agents, applies consensus, seals decisions
- **Agents:** Write/Code/Think/Image/Eval with standardized I/O contracts
- **Persistence:** PostgreSQL (state, audit, manifests), Redis (queues, cache)
- **AI runtime:** Ollama models (local or remote) with per‑agent model mapping
- **Observability:** Prometheus exporters, Grafana dashboards, request tracing
- **Security:** TLS termination, secrets via environment/secret stores, strict CORS

---

## Configuration

Environment:
```bash
SLAVKO_ENV=production
SLAVKO_BIND=0.0.0.0:8000

SLAVKO_JWT_SECRET=change-this
SLAVKO_RBAC_DEFAULT_ROLE=viewer
SLAVKO_TLS_ENABLED=true

POSTGRES_HOST=postgres
POSTGRES_DB=slavko
POSTGRES_USER=slavko
POSTGRES_PASSWORD=change-this

REDIS_HOST=redis
REDIS_PASSWORD=change-this

OLLAMA_HOST=ollama
OLLAMA_PORT=11434
SLAVKO_OLLAMA_MODELS=llama3:8b,codellama:13b,mistral:7b
```

Pipeline (minimal):
```yaml
version: "7"
name: "slavko-demo"
inputs:
  prompt: "Ship a crisp summary with action items."
council:
  quorum: 3
  threshold: 0.66
agents:
  - id: write
    model: "llama3:8b"
    policy: "content:summary"
  - id: think
    model: "llama3:8b"
    policy: "reasoning:chain"
  - id: eval
    model: "codellama:13b"
    policy: "score:clarity,consistency"
audit:
  sign: true
  store: "postgres"
```

---

## Usage

Run a pipeline:
```bash
curl -s -X POST http://localhost:8000/v1/pipelines \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d @examples/pipelines/demo.json
```

Trigger council:
```bash
curl -s -X POST http://localhost:8000/v1/council/run \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{"pipeline":"slavko-demo","inputs":{"prompt":"Top risks and mitigations"}}'
```

Fetch audit:
```bash
curl -s http://localhost:8000/v1/audit/slavko-demo \
  -H "Authorization: Bearer YOUR_TOKEN"
```

---

## Ollama setup

Models:
```bash
ollama pull llama3:8b
ollama pull codellama:13b
ollama pull mistral:7b
```

Verify:
```bash
ollama list
```

Configure:
```bash
export OLLAMA_HOST=127.0.0.1
export OLLAMA_PORT=11434
```

---

## Observability

Metrics (examples):
```text
slavko_requests_total{route="/v1/council/run"} 42
slavko_agent_duration_seconds{agent="eval"} 1.23
slavko_quorum_achieved_total 7
```

Dashboards:
- **Import:** monitoring/dashboards/*.json
- **Logs:** JSON with request IDs, council decision IDs
- **Alerts:** Prometheus rules for quorum failures and agent timeouts

---

## CI/CD

Workflows:
- **ci.yml:** Lint, tests, type checks, SBOM, vulnerability scan
- **release.yml:** Semantic versioning, changelog, GitHub Releases
- **docker.yml:** Build/push images on tags `v*`

Branching:
- **main:** stable
- **develop:** next
- **feature/** and **fix/**: short‑lived, PR‑driven

---

## Security

- **Authentication:** Short‑lived JWT, optional refresh, rotated secrets
- **Authorization:** RBAC with scoped actions per endpoint
- **Transport:** TLS 1.3 for external traffic, strict cipher suites
- **Secrets:** Env or secret managers; never commit credentials
- **Auditing:** Immutable decision logs with optional signature verification

---

## Outcomes you can measure
- **Time‑to‑trust:** Minutes to a governed pipeline with reproducible outputs and visible metrics.
- **MTTR:** Faster incident resolution via structured logs and council decision traces.
- **Compliance readiness:** Instant audit artifacts for reviews, tenders, and risk committees.
- **Cost control:** Model swapability keeps performance and budgets aligned without rewrites.
- **Velocity:** CI/CD pipelines ship changes safely with SBOM and vulnerability gates.

---

## Roadmap
- **v7.1:** WebSocket streaming for real‑time agent coordination
- **v7.2:** Multi‑region orchestration support
- **v8.0:** Kubernetes operator + Helm charts
- **v8.1:** Enterprise analytics dashboard with advanced insights

---

## Contributing
- **Flow:** Fork → branch from `develop` → PR with atomic commits
- **Quality:** `make test` and `make lint` before PR
- **Docs:** Update examples and dashboards when adding features

---

## License
MIT — see [LICENSE](LICENSE).
```
