# /converge

**Multi-approach convergence analysis for Claude Code.**

A skill that spawns parallel agents to tackle the same problem from different methodological angles, then consolidates results to check whether conclusions converge or diverge.

When approaches agree, you have high confidence. When they disagree, you've found something more valuable: genuine uncertainty and the specific assumptions driving it.

```
/converge Should we migrate from PostgreSQL to DynamoDB for our user events pipeline?
```

```
Convergence Analysis Report

Question: Should we migrate from PostgreSQL to DynamoDB for our user events pipeline?
Approaches Used: 4 independent methodologies
Overall Convergence: PARTIAL CONVERGENCE

Consolidated Finding:
3 of 4 approaches recommend staying on PostgreSQL with partitioning.
The cost-modeling approach favors DynamoDB at >50K events/sec.
Current load is 8K events/sec - migration is premature.

What Drives Disagreement:
The cost model diverges because it projects 10x growth over 18 months
based on sales pipeline. If growth materializes, revisit at 30K events/sec.
```

---

## The Problem

AI coding agents are confident. Give one a dataset, and it will pick a methodology, run the analysis, and hand you a conclusion. The trouble is that a different methodology might give you a different answer - and you'd never know.

[PyMC Labs](https://www.pymc-labs.com) identified this problem and built [decision-lab](https://github.com/pymc-labs/decision-lab), an agentic data science framework that runs multiple analytical approaches in parallel and checks whether results converge. Their key finding: when they tested against adversarial datasets where valid inference was impossible, a single-approach agent confidently recommended budget allocations, while their multi-approach agent tried 11 methods, found none converged, and correctly recommended collecting better data first.

This skill brings that methodology natively into Claude Code - no Docker, no external runtime, no additional dependencies. Just the core idea: **don't trust a single approach; triangulate.**

---

## Install

**One-liner:**

```bash
curl -fsSL https://raw.githubusercontent.com/bluzername/convergence-analysis/main/converge.md \
  -o ~/.claude/commands/converge.md
```

**Or clone and install:**

```bash
git clone https://github.com/bluzername/convergence-analysis.git
cd convergence-analysis
bash install.sh
```

**Manual:**

Copy `converge.md` to `~/.claude/commands/converge.md`. That's it.

---

## Usage

In any Claude Code session:

```
/converge <your analytical question or problem description>
```

### Examples

**Data science:**
```
/converge Analyze sales_data.csv and determine which marketing channels
drive the most incremental revenue
```

**Architecture decisions:**
```
/converge Should we use a monorepo or polyrepo for our 5 microservices?
```

**Business strategy:**
```
/converge Is it worth building an in-house billing system vs. using Stripe
for our B2B SaaS with 200 enterprise customers?
```

**Estimation:**
```
/converge How many engineers do we need to rebuild the checkout flow
in 3 months?
```

**Debugging:**
```
/converge Our API latency spiked 3x last Tuesday. Here are the metrics
from Datadog [paste data]. What caused it?
```

---

## How It Works

### Phase 1: Decompose

The skill analyzes your question and designs 3-5 **methodologically independent** approaches. Independence matters - "linear regression with different features" isn't independent; "linear regression vs. decision tree vs. domain-expert heuristic" is.

You see the planned approaches before execution:

| # | Approach | Methodology | Why Independent |
|---|----------|-------------|-----------------|
| 1 | Statistical | Regression analysis on historical data | Data-driven, parametric |
| 2 | Heuristic | Industry benchmarks and rules of thumb | Experience-driven, non-parametric |
| 3 | Simulation | Monte Carlo with uncertainty ranges | Stochastic, distribution-based |
| 4 | First-principles | Bottom-up cost/benefit decomposition | Analytical, assumption-explicit |

### Phase 2: Parallel Execution

All agents launch simultaneously. Each gets the same problem but a different methodology, with explicit instructions to stay in its lane. Each produces a structured report with conclusions, confidence levels, assumptions, and sensitivity analysis.

### Phase 3: Convergence Check

Results are consolidated into a comparison matrix:

| Dimension | Statistical | Heuristic | Simulation | First-principles | Convergent? |
|-----------|-----------|-----------|-----------|-----------------|-------------|
| Recommendation | Keep Postgres | Keep Postgres | Keep Postgres | Migrate to Dynamo | Partial |
| Break-even point | 45K evt/s | 50K evt/s | 42K evt/s | 30K evt/s | Partial |
| Confidence | HIGH | MEDIUM | HIGH | LOW | - |

The final report rates convergence as **STRONG**, **PARTIAL**, or **DIVERGENT** and - critically - when results diverge, it diagnoses *why* and recommends what data or experiment would resolve the disagreement.

---

## When to Use It

**Use `/converge` when:**
- The answer depends on assumptions you're not sure about
- Multiple valid analytical frameworks could apply
- The decision is high-stakes and you want to stress-test conclusions
- You suspect a single approach might give false confidence
- You want to identify what you *don't* know, not just what you do

**Don't use `/converge` when:**
- The question has a factual answer (use a search instead)
- You need a quick code fix, not analysis
- The problem is well-constrained with a single obvious methodology

---

## Acknowledgments

This skill is a native Claude Code implementation of the core methodology pioneered by **[PyMC Labs](https://www.pymc-labs.com)** in their **[decision-lab](https://github.com/pymc-labs/decision-lab)** project (Apache 2.0).

decision-lab is a full agentic data science framework with Docker-based sandboxed execution, a skill registry ([Decision Hub](https://hub.decision.ai)), and production-grade tooling for domains like marketing mix modeling. If you need the complete platform - especially for data science workloads with locked environments and reproducible pipelines - use decision-lab directly.

This skill extracts only the *convergence methodology* (multi-approach parallel analysis with divergence diagnosis) and implements it as a lightweight Claude Code prompt pattern, with no external dependencies.

**decision-lab contributors:**
- [PyMC Labs](https://github.com/pymc-labs) - Organization
- [benmaier](https://github.com/benmaier) - Lead contributor

---

## License

MIT
