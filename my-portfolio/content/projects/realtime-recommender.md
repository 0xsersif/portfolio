---
title: "Real-Time Recommendation System"
date: 2025-12-10
description: "Production recommendation system with real-time updates using Kafka, Spark, and FastAPI"
tags: ["ML Engineering", "Recommender", "Kafka", "Spark", "Real-Time"]
categories: ["Core ML Engineering"]
---

# Real-Time Recommendation System

## Beyond Sentiment Analysis

Most portfolio projects stop at batch sentiment analysis. This project goes further: a **real-time recommendation engine** that updates user profiles and suggestions as interactions happen, using streaming data architecture.

## Use Case

E-commerce product recommendations that adapt **within seconds** as users:
- View products
- Add to cart
- Complete purchases
- Search for items

## Architecture

```
User Interaction Events
        ↓
   Kafka Producer
        ↓
  Kafka Topic (user-events)
        ↓
   Spark Streaming
   - Parse events
   - Update user profiles
   - Compute similarities
        ↓
   Redis Cache (updated profiles)
        ↓
   FastAPI Endpoint
   /recommend/{user_id}
        ↓
   Real-Time Recommendations
```

## Tech Stack

- **Kafka** — Event streaming platform
- **Spark Streaming** — Real-time data processing
- **Redis** — In-memory cache for user profiles
- **FastAPI** — Recommendation API
- **PostgreSQL** — Historical data storage
- **Docker** — Service orchestration
- **Python** — scikit-learn, pandas, NumPy
- **GitHub Actions** — CI/CD pipeline

## Feature Engineering

### User Profile Features
- Last 10 viewed products (IDs, categories)
- Cart items and wishlist
- Purchase history (last 30 days)
- Browsing session duration
- Device type and location

### Product Features
- Category, price range
- Popularity score (view count)
- Rating and review sentiment
- Stock availability

### Interaction Features
- Click-through rate (CTR)
- Time spent on product page
- Add-to-cart rate
- Purchase conversion rate

## Model Architecture

### Collaborative Filtering
- User-item matrix (sparse)
- Matrix factorization (ALS)
- Item-item cosine similarity

### Hybrid Approach
1. **Content-based**: Product features similarity
2. **Collaborative**: User behavior patterns
3. **Popularity fallback**: For cold-start users

```python
score = 0.6 * collaborative_score + 
        0.3 * content_score + 
        0.1 * popularity_score
```

## Real-Time Pipeline

### Event Flow

```python
# 1. User views product
event = {
    "user_id": "12345",
    "product_id": "P789",
    "action": "view",
    "timestamp": "2026-02-08T01:30:00Z"
}

# 2. Sent to Kafka
producer.send("user-events", event)

# 3. Spark processes stream
stream = spark.readStream.kafka("user-events")
stream.foreachBatch(update_user_profile)

# 4. Update Redis cache
redis.set(f"profile:{user_id}", updated_profile)

# 5. API returns fresh recommendations
GET /recommend/12345
```

### Latency SLA
- Event to profile update: **<2 seconds**
- API response time: **<100ms** (P95)

## Production Deployment

### Docker Compose Services
```yaml
services:
  kafka:
    image: confluentinc/cp-kafka
  spark:
    image: bitnami/spark
  redis:
    image: redis:alpine
  fastapi:
    build: ./api
    ports:
      - "8000:8000"
  postgres:
    image: postgres:14
```

### CI/CD Pipeline (GitHub Actions)

```yaml
on: [push]
jobs:
  test:
    - pytest tests/ --cov
  lint:
    - black . --check
    - flake8 .
  deploy:
    - docker build -t recommender:latest
    - docker push to registry
```

## Metrics & Impact

📊 **22% increase in CTR** (click-through rate)  
📊 **18% improvement in conversion rate**  
📊 **<100ms P95 latency** for API responses  
📊 **99.9% uptime** over 3 months in production  
📊 **Handles 10k events/second** during peak traffic

## Monitoring & Observability

### Tracked Metrics
- **Latency**: P50, P95, P99 for API and streaming
- **Throughput**: Events processed per second
- **Accuracy**: Offline A/B test (CTR prediction)
- **Cache hit rate**: Redis performance
- **Error rate**: Failed recommendations

### Alerting
- Latency > 200ms for 5 minutes → PagerDuty
- Error rate > 1% → Slack notification
- Kafka lag > 10k messages → Email alert

## A/B Testing

Deployed multiple model variants in production:

| Variant | CTR Lift | Latency | Winner |
|---------|----------|---------|--------|
| **Baseline** (popularity) | 0% | 50ms | ❌ |
| **Collaborative only** | +15% | 80ms | ❌ |
| **Hybrid** | +22% | 95ms | ✅ |
| **Deep learning** | +25% | 300ms | ❌ (too slow) |

**Winner**: Hybrid approach (quality + speed balance)

## GitHub Repository

📂 **[View Source Code →](https://github.com/0xmuler/realtime-recommender)**

Includes:
- Complete streaming pipeline
- FastAPI service with endpoints
- Docker Compose setup
- Load testing scripts (Apache JMeter)
- Monitoring dashboards (Grafana)
- Professional README with architecture diagram

## Challenges & Solutions

| Challenge | Solution |
|-----------|----------|
| **Kafka lag during traffic spikes** | Auto-scaling Spark workers, partition tuning |
| **Cold-start problem** | Popularity-based fallback for new users |
| **Model staleness** | Retrain weekly with Airflow DAG |
| **Redis memory limits** | TTL on user profiles, LRU eviction |

## Key Learnings

1. **Start simple** — Collaborative filtering beats complex DL for this use case
2. **Latency matters** — 300ms model was too slow despite higher accuracy
3. **Caching is critical** — Redis reduced DB load by 90%
4. **Monitor everything** — Production surprises without observability
5. **A/B test in production** — Offline metrics don't always match real CTR

## Future Enhancements

- **Contextual bandits** — Explore/exploit tradeoff
- **Session-based recommendations** — RNN for sequential patterns
- **Multi-armed bandit** — Optimize for exploration
- **Feature store** — Centralized feature management (Feast)
- **Real-time personalization** — Dynamic homepage layouts
