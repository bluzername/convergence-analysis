---
name: converge
description: "Multi-approach convergence analysis. Spawns parallel agents that tackle the same problem from different methodological angles, then consolidates to check whether results converge or diverge. Inspired by pymc-labs/decision-lab."
---

# Convergence Analysis

You are conducting a **multi-approach convergence analysis** - a methodology where multiple independent analytical approaches are applied to the same problem in parallel. When results converge across approaches, confidence is high. When they diverge, it flags genuine uncertainty and identifies what drives disagreement.

This methodology is inspired by [decision-lab](https://github.com/pymc-labs/decision-lab) by PyMC Labs, which demonstrated that single-approach analysis often produces false confidence, while multi-approach convergence testing surfaces real uncertainty.

## User's Request

$ARGUMENTS

## Execution Protocol

### Phase 1: Problem Decomposition

Before spawning any agents, analyze the user's request and determine:

1. **The core question**: What specific question needs answering?
2. **The data/context available**: What inputs do the agents have to work with?
3. **3-5 distinct analytical approaches**: Each must be methodologically independent. Examples:
   - Statistical vs. heuristic vs. simulation-based
   - Frequentist vs. Bayesian vs. non-parametric
   - Top-down vs. bottom-up estimation
   - Quantitative vs. qualitative framework
   - Conservative vs. moderate vs. aggressive assumptions
   - Different modeling families (linear, tree-based, neural, rule-based)
   - First-principles reasoning vs. empirical/analogical reasoning

Present the planned approaches to the user in a brief table:

| # | Approach | Methodology | Why Independent |
|---|----------|-------------|-----------------|
| 1 | ... | ... | ... |
| 2 | ... | ... | ... |
| 3 | ... | ... | ... |

### Phase 2: Parallel Agent Execution

Launch **all agents in parallel** using the Agent tool. Each agent gets:

1. **The same core question and data**
2. **A specific methodology to follow** (and instruction NOT to use other approaches)
3. **A structured output format** (see below)

**Agent Prompt Template** (adapt per approach):

```
You are conducting a focused analysis using ONLY the [APPROACH_NAME] methodology.

## Problem
[THE CORE QUESTION]

## Context & Data
[AVAILABLE DATA/CONTEXT]

## Your Methodology
[SPECIFIC INSTRUCTIONS FOR THIS APPROACH]

## Constraints
- Use ONLY the assigned methodology. Do not mix approaches.
- Be explicit about assumptions you're making.
- Quantify uncertainty where possible.
- Flag any limitations of your approach honestly.

## Required Output Format

Write your findings as a structured report:

### Conclusion
[Your primary finding/recommendation in 1-3 sentences]

### Key Metrics/Findings
[Quantitative results, estimates, scores - whatever is relevant]

### Confidence Level
[HIGH / MEDIUM / LOW] - with justification

### Assumptions Made
[Bullet list of assumptions]

### Limitations of This Approach
[What this methodology cannot capture]

### Sensitivity
[What inputs/assumptions, if changed, would alter your conclusion?]
```

### Phase 3: Convergence Consolidation

After all agents complete, perform consolidation:

#### 3a. Results Matrix

Create a comparison table:

| Dimension | Approach 1 | Approach 2 | Approach 3 | Convergent? |
|-----------|-----------|-----------|-----------|-------------|
| Primary conclusion | ... | ... | ... | Yes/No |
| Key metric | ... | ... | ... | Yes/No |
| Confidence | ... | ... | ... | - |
| Critical assumption | ... | ... | ... | - |

#### 3b. Convergence Assessment

Rate overall convergence:

- **STRONG CONVERGENCE**: All approaches reach the same conclusion (possibly with different magnitudes). High confidence in the finding.
- **PARTIAL CONVERGENCE**: Most approaches agree, but one or more diverge. Investigate what drives the outlier.
- **DIVERGENCE**: Approaches reach meaningfully different conclusions. This is a valuable finding - it means the answer genuinely depends on methodology/assumptions.

#### 3c. Divergence Diagnosis (if applicable)

When results diverge:
1. **Identify the fork**: What specific assumption or methodological choice causes the split?
2. **Characterize the sensitivity**: How much does the conclusion change with each driver?
3. **Recommend resolution**: What additional data, experiment, or analysis would resolve the disagreement?

#### 3d. Final Report

Structure the final output as:

---

## Convergence Analysis Report

**Question**: [The original question]
**Approaches Used**: [Count] independent methodologies
**Overall Convergence**: [STRONG / PARTIAL / DIVERGENCE]

### Consolidated Finding
[The finding that accounts for all approaches. If convergent: the shared conclusion with high confidence. If divergent: what we know, what we don't, and what would resolve it.]

### Approach Comparison
[The results matrix from 3a]

### What Drives Agreement
[Factors all approaches agree on]

### What Drives Disagreement (if any)
[The specific assumptions or methodological choices that cause divergence]

### Confidence & Caveats
[Overall confidence level, accounting for convergence/divergence]

### Recommended Next Steps
[If divergent: experiments or data that would resolve it. If convergent: actions to take based on high-confidence finding.]

---

## Critical Rules

1. **Never fewer than 3 approaches.** Two is a coin flip; three starts to reveal patterns.
2. **Approaches must be genuinely independent.** "Linear regression with different features" is NOT independent. "Linear regression vs. decision tree vs. domain-expert heuristic" IS.
3. **Launch agents in parallel.** Use a single message with multiple Agent tool calls. Never run them sequentially.
4. **Divergence is a finding, not a failure.** When approaches disagree, the most valuable output is identifying WHY they disagree and what would resolve it. Never paper over disagreement.
5. **Be honest about limitations.** If the problem doesn't suit multi-approach analysis (e.g., it's a simple lookup), say so and just answer directly.
6. **Adapt approaches to the domain.** Data science problems get statistical approaches. Architecture decisions get different evaluation frameworks. Business strategy gets different analytical lenses. Don't force statistical methods onto non-statistical problems.
