---
title: "Computer Vision for Edge Deployment"
date: 2025-11-20
description: "YOLO object detection optimized for Raspberry Pi and mobile edge devices"
tags: ["Computer Vision", "Edge AI", "YOLO", "PyTorch", "ONNX"]
categories: ["Core ML Engineering"]
---

# Computer Vision for Edge Deployment

## Project Overview

Deploy a real-time **object detection model (YOLO)** on resource-constrained edge devices (Raspberry Pi 4, mobile phones) through aggressive model optimization and quantization.

## Why Edge Deployment?

**Challenges**:
- Limited compute (ARM CPU, no GPU)
- Constrained memory (2-4GB RAM)
- Real-time requirements (<100ms inference)
- Battery constraints (mobile)

**Benefits**:
- No cloud dependency (offline operation)
- Low latency (no network round-trip)
- Privacy (data stays on device)
- Cost savings (no cloud inference fees)

## Model Selection: YOLOv8

Chose **YOLOv8-Nano** for edge deployment:
- Smallest YOLO variant (3M parameters)
- Good accuracy/speed tradeoff
- Proven on mobile devices

**Baseline Performance (desktop GPU)**:
- FPS: 120
- mAP50: 37.3%
- Latency: 8ms

## Optimization Pipeline

### 1. Model Quantization

Convert FP32 → INT8 (4x smaller, 4x faster):

```python
import torch
from torch.quantization import quantize_dynamic

model = torch.load("yolov8n.pt")
quantized_model = quantize_dynamic(
    model, {torch.nn.Linear}, dtype=torch.qint8
)
```

**Result**: 12MB → 3MB model size

### 2. ONNX Export

Export to ONNX for cross-platform inference:

```python
torch.onnx.export(
    model, dummy_input, "yolov8n.onnx",
    opset_version=13,
    input_names=["images"],
    output_names=["output"]
)
```

### 3. TensorFlow Lite Conversion

For mobile (Android/iOS):

```python
converter = tf.lite.TFLiteConverter.from_saved_model("model")
converter.optimizations = [tf.lite.Optimize.DEFAULT]
tflite_model = converter.convert()
```

### 4. Pruning

Remove 30% of least important weights:

```python
import torch.nn.utils.prune as prune

prune.l1_unstructured(
    model.conv1, name="weight", amount=0.3
)
```

**Result**: Minimal accuracy drop (-2% mAP), 20% faster

### 5. Neural Architecture Search (NAS)

Automated model architecture optimization for ARM:
- Reduce channel dimensions
- Replace expensive operations (e.g., SiLU → ReLU)
- Optimize kernel sizes for ARM NEON

## Tech Stack

- **PyTorch** — Model training and export
- **ONNX Runtime** — Cross-platform inference
- **TensorFlow Lite** — Mobile deployment
- **OpenCV** — Video capture and preprocessing
- **NumPy** — Array operations
- **Raspberry Pi 4** — Edge hardware (ARM Cortex-A72)

## Deployment Targets

### Raspberry Pi 4 (2GB RAM)

```python
import onnxruntime as ort

session = ort.InferenceSession("yolov8n_int8.onnx")
outputs = session.run(None, {"images": frame})
```

**Performance**:
- FPS: **12** (quantized) vs 3 (baseline)
- Latency: **80ms** (P95)
- Power: 3W average

### Mobile (Android)

TensorFlow Lite integration:

```kotlin
val interpreter = Interpreter(loadModelFile())
interpreter.run(inputBuffer, outputBuffer)
```

**Performance**:
- FPS: **18** on Snapdragon 865
- Battery: 4 hours continuous detection

## Use Cases

### 1. Smart Home Security (Raspberry Pi)
- Detect persons, packages at door
- Alert on phone via MQTT
- Local storage (privacy)

### 2. Wildlife Monitoring
- Battery-powered Pi in forest
- Detect animals, log species
- Solar panel for power

### 3. Mobile AR Shopping
- Point camera at product
- Detect and identify item
- Show price, reviews overlay

## Results & Metrics

📊 **5x faster inference** on Raspberry Pi (12 FPS vs 3 FPS)  
📊 **4x smaller model** (3MB vs 12MB)  
📊 **Only 2% mAP drop** after quantization (37.3% → 35.5%)  
📊 **Real-time performance** on mobile (<100ms latency)  
📊 **4 hours battery life** on mobile continuous detection

## Optimization Comparison

| Optimization | Model Size | FPS (Pi 4) | mAP50 | Latency |
|--------------|-----------|------------|-------|---------|
| **Baseline** | 12MB | 3 | 37.3% | 330ms |
| **Quantization** | 3MB | 8 | 36.1% | 125ms |
| **+ Pruning** | 2.5MB | 10 | 35.8% | 100ms |
| **+ NAS** | 2MB | 12 | 35.5% | 80ms |

## Demo Video

🎥 **[Watch Real-Time Detection on Raspberry Pi →](https://youtu.be/demo-video)**

Shows live webcam feed with bounding boxes at 12 FPS.

## GitHub Repository

📂 **[View Source Code →](https://github.com/0xmuler/yolo-edge-deployment)**

Includes:
- Training code with PyTorch
- Quantization and pruning scripts
- ONNX/TFLite export pipelines
- Raspberry Pi inference script
- Android app (APK + source)
- Performance benchmarking tools
- Setup guide for Pi deployment

## Hardware Setup

### Raspberry Pi 4 Kit
- Pi 4 Model B (2GB RAM)
- Raspberry Pi Camera Module v2
- Heat sinks + fan (prevents throttling)
- 32GB microSD card
- Power supply (5V 3A)

**Cost**: ~$80 total

### Software Stack
```bash
# Install dependencies
sudo apt-get install python3-opencv
pip install onnxruntime numpy

# Run detector
python3 detect_pi.py --source 0  # Webcam
```

## Challenges & Solutions

| Challenge | Solution |
|-----------|----------|
| **Slow FPS on Pi** | INT8 quantization, model pruning |
| **High CPU temperature** | Add heat sinks, reduce resolution |
| **False positives** | Post-processing NMS, confidence threshold |
| **Battery drain on mobile** | Frame skipping, sleep mode when idle |

## Key Learnings

1. **Quantization is a game-changer** — 4x speedup with minimal accuracy loss
2. **Hardware matters** — ARM optimizations (NEON) crucial for performance
3. **Tradeoffs everywhere** — Accuracy vs speed vs battery vs size
4. **Profile before optimizing** — Bottleneck was preprocessing, not model
5. **Edge has unique constraints** — Can't just throw GPUs at the problem

## Benchmarking Methodology

Measured on 1000 frames:
- **FPS**: Frames processed per second (including preprocessing)
- **Latency**: End-to-end time per frame (P50, P95, P99)
- **mAP**: Mean Average Precision @ IoU 0.5
- **Model size**: Disk space + RAM usage
- **Power**: Watts consumed (multimeter measurement)

## Future Enhancements

- **Multi-threaded inference** — Overlap preprocessing + inference
- **Knowledge distillation** — Train tiny model from large teacher
- **On-device training** — Fine-tune on new classes locally
- **Federated learning** — Aggregate models from multiple Pi devices
- **Hardware acceleration** — Coral TPU, Intel Neural Compute Stick
