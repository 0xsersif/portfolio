---
title: "LLM Evaluation Dashboard"
date: 2026-01-28
description: "Dashboard for evaluating RAG systems, comparing chunking strategies, and minimizing hallucinations"
tags: ["MLOps", "LLM", "Evaluation", "Streamlit", "MLflow"]
categories: ["MLOps", "LLM Engineering"]
---

# LLM Evaluation Dashboard

## Problem Statement

RAG systems are hard to evaluate. How do you:
- Compare different chunking strategies (semantic vs fixed-size)?
- Measure hallucination rates across prompt variations?
- A/B test retrieval methods (dense vs hybrid)?
- Track performance over time?

This project builds a **comprehensive evaluation framework** with visual dashboards to systematically improve RAG system quality.

## Architecture

```
Evaluation Dataset (Golden Q&A Pairs)
            ↓
┌───────────┴───────────┐
│   Test Configurations │
│ - Chunking: 3 types   │
│ - Prompts: 5 variants │
│ - Retrieval: 2 methods│
└───────────┬───────────┘
            ↓
    Run Experiments (MLflow)
            ↓
    Compute Metrics
    - Answer accuracy
    - Hallucination rate  
    - Retrieval precision
    - Latency
            ↓
    Streamlit Dashboard
    (Interactive Comparison)
```

## Tech Stack

- **Streamlit** — Interactive dashboard UI
- **MLflow** — Experiment tracking and runs comparison
- **LangChain** — RAG system orchestration
- **pytest** — Automated evaluation tests
- **pandas** — Data manipulation and analysis
- **plotly** — Interactive visualizations
- **Docker** — Reproducible environment

## Evaluation Metrics

### 1. Answer Accuracy
Compare generated answer to golden answer:
- **Exact match** — Binary correctness
- **BLEU score** — N-gram overlap
- **ROUGE score** — Recall-oriented similarity
- **Semantic similarity** — Embedding cosine distance

### 2. Hallucination Detection
Check if answer contains hallucinated information:
- **Source attribution** — All facts cite retrieved documents
- **Out-of-scope detection** — Correctly says "I don't know"
- **Factual consistency** — NLI model checks answer vs sources

### 3. Retrieval Quality
Evaluate document retrieval:
- **Precision@K** — Relevant docs in top K
- **Recall@K** — Coverage of all relevant docs
- **MRR (Mean Reciprocal Rank)** — Position of first relevant doc
- **Latency** — Time to retrieve + rank documents

## Tested Configurations

### Chunking Strategies
1. **Fixed-size** — 512 tokens, 50 token overlap
2. **Semantic** — Split by paragraph/section headers
3. **Recursive** — Hierarchical chunking with parent-child

### Prompt Variations
1. **Zero-shot** — Direct question answering
2. **Few-shot** — 3 examples in prompt
3. **Chain-of-thought** — "Think step-by-step..."
4. **Constrained** — "Answer using only provided context"
5. **Structured** — JSON output format

### Retrieval Methods
1. **Dense** — Pure embedding similarity (FAISS)
2. **Hybrid** — Dense + BM25 sparse retrieval

## Dashboard Features

### Experiment Comparison View
- Side-by-side metrics for all configurations
- Interactive filters (chunking, prompt, retrieval)
- Sort by any metric (accuracy, latency, etc.)

### Hallucination Analysis
- Per-question hallucination breakdown
- Examples of hallucinated answers
- Confidence score distribution

### Latency Profiling
- P50, P95, P99 latency percentiles
- Breakdown: retrieval vs generation time
- Identify slow queries

### Error Analysis
- Failed questions grouped by topic
- Common failure patterns
- Suggested improvements

## Results & Insights

📊 **Semantic chunking improved accuracy by 12%** vs fixed-size  
📊 **Hybrid retrieval reduced hallucinations by 35%**  
📊 **Constrained prompts cut hallucination rate from 18% → 6%**  
📊 **FAISS optimization reduced latency from 800ms → 400ms**

### Winning Configuration

| Component | Best Approach |
|-----------|---------------|
| **Chunking** | Semantic (paragraph boundaries) |
| **Prompt** | Constrained + few-shot examples |
| **Retrieval** | Hybrid (dense + BM25) |
| **Top-K** | 5 documents |
| **Re-ranking** | Cross-encoder final pass |

**Final Metrics**:  
✅ 85% answer accuracy  
✅ 6% hallucination rate  
✅ 420ms average latency

## Live Demo

🚀 **[Try the Dashboard on Streamlit Cloud →](https://0xmuler-llm-eval.streamlit.app)**

Upload your own evaluation dataset and run experiments.

## GitHub Repository

📂 **[View Source Code →](https://github.com/0xmuler/llm-evaluation-dashboard)**

Includes:
- Full evaluation framework
- Golden Q&A dataset (100+ examples)
- MLflow experiment tracking setup
- Streamlit dashboard code
- Automated pytest suite
- Docker Compose for one-command deployment

## Example Evaluation Run

```python
from llm_eval import RAGEvaluator

evaluator = RAGEvaluator(
    dataset="golden_qa.json",
    chunking="semantic",
    prompt_template="constrained",
    retrieval="hybrid"
)

results = evaluator.run()
# Logs to MLflow automatically

print(results.summary())
# Accuracy: 0.85, Hallucination: 0.06, Latency: 420ms
```

## Automated Testing

CI/CD pipeline (GitHub Actions) runs on every PR:

```yaml
- Run evaluation on 20-question smoke test
- Fail if accuracy < 75%
- Fail if hallucination > 10%
- Fail if P95 latency > 1000ms
```

## Key Learnings

1. **Golden datasets are essential** — Can't improve what you don't measure
2. **Metrics must match use case** — BLEU ≠ semantic correctness
3. **Ablation studies reveal insights** — Change one variable at a time
4. **Latency-quality tradeoffs** — Faster retrieval may hurt accuracy
5. **Visualizations drive decisions** — Dashboard convinced stakeholders

## Challenges & Solutions

| Challenge | Solution |
|-----------|----------|
| **Creating golden dataset** | Hired domain experts for annotation |
| **Expensive LLM calls** | Cache LLM responses, use cheaper models for eval |
| **Evaluation is subjective** | Multiple annotators, inter-rater agreement |
| **Complex UI** | Streamlit with clear filters and tooltips |

## Future Enhancements

- **Multi-modal evaluation** — Test with images, tables, charts
- **Adversarial testing** — Inject misleading docs, test robustness
- **Online evaluation** — Monitor production queries automatically
- **Cost tracking** — Compare configurations by $/1000 queries
- **Custom metrics** — Domain-specific evaluation criteria
