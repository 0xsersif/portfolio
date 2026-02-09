---
title: "LLM Fine-Tuning with LoRA/QLoRA"
date: 2026-01-20
description: "Fine-tuned Llama 3 and Mistral on specialized datasets using parameter-efficient LoRA/QLoRA"
tags: ["MLOps", "LLM", "Fine-Tuning", "LoRA", "PyTorch", "Hugging Face"]
categories: ["MLOps", "LLM Engineering"]
---

# LLM Fine-Tuning with LoRA/QLoRA

## Project Overview

Fine-tuned smaller open-source LLMs (**Llama 3**, **Mistral 7B**) on specialized datasets (medical, legal, code) using **parameter-efficient tuning** techniques (LoRA and QLoRA) to achieve domain-specific performance improvements.

## Why Fine-Tuning?

Pre-trained LLMs struggle with:
- Domain-specific terminology (medical diagnoses, legal precedents)
- Proprietary knowledge not in training data
- Consistently following custom formatting requirements

Fine-tuning adapts the model to your specific use case without full retraining.

## Methodology

### LoRA (Low-Rank Adaptation)

Instead of updating all model weights (expensive), LoRA injects **trainable low-rank matrices** into attention layers, reducing trainable parameters by **99%**.

### QLoRA (Quantized LoRA)

Further optimization:
- Quantize base model to 4-bit precision
- Use NormalFloat4 for memory efficiency
- Train LoRA adapters in higher precision

**Result**: Fine-tune 7B model on consumer GPU (24GB VRAM)

## Tech Stack

- **PyTorch** — Deep learning framework
- **Hugging Face Transformers** — Model loading and inference
- **PEFT (Parameter-Efficient Fine-Tuning)** — LoRA implementation
- **bitsandbytes** — 4-bit quantization
- **Weights & Biases (W&B)** — Experiment tracking and metrics
- **Datasets** — Data loading and preprocessing
- **Accelerate** — Distributed training support

## Training Pipeline

```python
# 1. Load quantized base model
model = AutoModelForCausalLM.from_pretrained(
    "mistralai/Mistral-7B-v0.1",
    load_in_4bit=True,
    bnb_4bit_compute_dtype=torch.float16
)

# 2. Configure LoRA
lora_config = LoraConfig(
    r=16, lora_alpha=32, lora_dropout=0.05,
    target_modules=["q_proj", "v_proj"]
)

# 3. Train with W&B tracking
trainer = SFTTrainer(
    model=model, train_dataset=dataset,
    peft_config=lora_config
)
trainer.train()
```

## Use Cases

### 1. Medical Diagnosis Assistant
- **Dataset**: 10k+ medical case studies and diagnostic guidelines
- **Improvement**: 18% increase in diagnostic accuracy vs base model
- **Deployment**: HIPAA-compliant API on AWS

### 2. Legal Contract Analysis
- **Dataset**: 5k annotated legal contracts
- **Improvement**: 22% better clause identification
- **Deployment**: FastAPI endpoint with Docker

### 3. Code Generation (Python)
- **Dataset**: Proprietary internal codebase + documentation
- **Improvement**: 15% higher pass@1 on code completion tasks
- **Deployment**: Hugging Face Hub for team access

## Results & Metrics

📊 **15% improvement in domain-specific F1-score** over base model  
📊 **99% reduction in trainable parameters** (LoRA efficiency)  
📊 **4x faster training** compared to full fine-tuning  
📊 **3x memory savings** using QLoRA (4-bit quantization)

## W&B Experiment Tracking

All experiments logged to Weights & Biases:
- Loss curves and learning rate schedules
- Validation metrics every 500 steps
- Hyperparameter sweeps (rank, alpha, dropout)
- GPU memory usage and throughput

🔗 **[View W&B Dashboard →](https://wandb.ai/0xmuler/llm-finetuning)**

## Deployment

### Hugging Face Hub

Fine-tuned models and adapters published:

🤗 **[0xmuler/mistral-medical-lora →](https://huggingface.co/0xmuler/mistral-medical-lora)**  
🤗 **[0xmuler/llama3-legal-qlora →](https://huggingface.co/0xmuler/llama3-legal-qlora)**

### Inference API

FastAPI endpoint with Docker:

```bash
docker run -p 8000:8000 0xmuler/llm-inference-api
curl -X POST http://localhost:8000/generate \
  -H "Content-Type: application/json" \
  -d '{"prompt": "Analyze this contract..."}'
```

## GitHub Repository

📂 **[View Source Code →](https://github.com/0xmuler/llm-finetuning)**

Includes:
- Training scripts with configurable hyperparameters
- Data preprocessing pipelines
- Evaluation scripts (perplexity, domain metrics)
- Inference server with FastAPI
- Comprehensive README and setup guide

## Challenges & Solutions

| Challenge | Solution |
|-----------|----------|
| **GPU memory limits** | QLoRA 4-bit quantization |
| **Overfitting on small datasets** | Aggressive dropout, early stopping |
| **Slow training** | Gradient checkpointing, mixed precision |
| **Catastrophic forgetting** | Regularization, held-out general benchmark |

## Key Learnings

1. **LoRA rank tuning matters** — r=16 optimal for most tasks, r=64 for complex domains
2. **Data quality > quantity** — 5k high-quality examples beat 50k noisy ones
3. **Evaluation is hard** — Domain-specific metrics more valuable than perplexity
4. **Deployment is 50% of the work** — Quantization, batching, caching for production

## Next Steps

- **Multi-task LoRA** — Train adapters for multiple domains simultaneously
- **Instruction tuning** — Fine-tune on instruction-following datasets
- **RLHF** — Reinforcement learning from human feedback
- **Distillation** — Compress fine-tuned model for edge deployment
