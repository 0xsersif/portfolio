---
title: "Entwicklungs-Philosophie & MLOps Praktiken"
description: "Mein Ansatz zum Bauen von Produktions-ML-Systemen und zum Liefern von qualitativem Code"
---

# Entwicklungs-Philosophie

## Ich baue Produktions-ML-Systeme und ich liefere sie ab

Meine Philosophie konzentriert sich auf **produktionsorientierte Entwicklung**, **quantifizierte Auswirkungen** und **authentische technische Arbeit**.

---

## Produktionsorientiert: Über Notebooks hinausgehen

### Das Problem mit .ipynb Portfolios

Notebooks sind kein Produktionscode  
Keine Struktur, keine Tests, kein Deployment  
Können nicht in Produktionsumgebungen laufen  
Recruiter möchten echte Systeme sehen

### Die Lösung: Strukturierte Repositories

Python Module mit korrekten Importen  
FastAPI/Flask für Inference APIs  
Docker für reproduzierbare Umgebungen  
CI/CD Pipelines mit GitHub Actions  
Tests mit pytest (>80% Coverage)  
Monitoring mit MLflow, W&B

**Beispiel Struktur**:
```
ml-project/
├── src/
│   ├── data/
│   ├── models/
│   ├── api/
│   └── utils/
├── tests/
├── Dockerfile
├── requirements.txt
├── .github/workflows/
└── README.md
```

---

## Live Demos sind obligatorisch

### Warum Demos wichtig sind

Recruiter und Hiring Manager haben **keine Zeit**, Repos zu klonen und Code auszuführen. Live Demos beweisen:
- Dein Code funktioniert wirklich
- Du kannst in Produktion deployen
- Du verstehst DevOps/MLOps

### Deployment Plattformen

Hugging Face Spaces — Für LLM/NLP Projekte  
Streamlit Cloud — Für Dashboards und Demos  
AWS/GCP — Für skalierbare Produktionssysteme  
Docker Hub — Containerisierte Anwendungen  
GitHub Pages — Statische Sites und Portfolios

---

## Quantifizierte Auswirkungen: Die Zahlen zeigen

### Schlecht: Vage Aussagen

"Verbesserte Modell-Performance"  
"Gebaut ein Empfehlungssystem"  
"Optimiert die Pipeline"

### Gut: Messbare Metriken

**"Latenz um 40% reduziert"** (800ms → 480ms)  
**"F1-Score um 15% verbessert"** (0.72 → 0.83)  
**"$200k pro Jahr gespart"** durch Bestandsverwaltung

### Business Impact

ML Engineering geht um **echte Probleme lösen**:
- Kosten reduziert
- Umsatz erhöht
- Schnellere Entscheidungen
- Bessere Nutzererfahrung

Technische Arbeit immer an Business Outcomes binden.

---

## Echte Daten: Keine sauberen Kaggle Datasets

### Die Kaggle Falle

Iris, Titanic, MNIST sind **übernutzt und unrealistisch**:

- Perfekt bereinigt
- Keine fehlenden Werte
- Künstliche Problemstellungen
- Nicht repräsentativ für echte Probleme

### Das echte Leben

Messy data ist die **Norm**:
- Fehlende Werte und Duplikate
- Unausgewogene Klassen
- Datenversatz und Rauschen
- Echte Geschäftskonstraints

**Zeige Datenbereinigungsfähigkeiten**. Das ist was Recruiter sehen möchten.
