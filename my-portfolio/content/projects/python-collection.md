---
title: "CS50P Python Projects Collection"
date: 2025-08-05
description: "Curated collection of Python projects from Harvard's CS50P, demonstrating fundamentals to advanced concepts"
tags: ["Python", "CS50", "Education"]
categories: ["Full-Stack"]
---

# Python Projects Collection

## CS50P & 1337 School-Inspired Portfolio

A curated collection of Python projects demonstrating fundamental to advanced concepts through practical problem-solving.

## Certification

✅ **CS50P: Introduction to Programming with Python (Harvard)**  
Completed Harvard's rigorous Python course covering functions, testing, file I/O, OOP, and more.

## Project Highlights

### 1. DNA Profiling Tool
**Concept**: Identify individuals by analyzing STR (Short Tandem Repeats) in DNA sequences

**Skills**:
- File I/O with CSV
- String manipulation
- Dictionary data structures
- Algorithm optimization

```python
def longest_match(sequence, subsequence):
    """Find longest run of subsequence in sequence"""
    longest = 0
    for i in range(len(sequence)):
        count = 0
        while sequence[i:i+len(subsequence)*(count+1)] == subsequence*(count+1):
            count += 1
        longest = max(longest, count)
    return longest
```

### 2. Finance Web App (Flask)
**Concept**: Stock trading simulator with real API integration

**Skills**:
- Flask web framework
- SQL database (SQLite)
- API integration (IEX Cloud)
- Session management
- Form validation

**Features**:
- User authentication
- Buy/sell stocks with live prices
- Portfolio tracking
- Transaction history

### 3. Filter (Image Processing)
**Concept**: Apply image filters (grayscale, blur, edges) using array manipulation

**Skills**:
- 2D array operations
- Image processing algorithms
- NumPy-like operations (pure Python)

**Filters**:
- Grayscale
- Sepia tone
- Gaussian blur
- Edge detection (Sobel)

### 4. Speller (Spell Checker)
**Concept**: Implement fast spell-checking using hash tables

**Skills**:
- Hash table implementation
- File parsing
- Performance optimization
- Memory management

**Performance**:
- Checks 140,000+ words in <1 second
- Custom hash function for optimal distribution

### 5. Regex Parser
**Concept**: Validate email addresses, phone numbers, URLs using regex

**Skills**:
- Regular expressions mastery
- Pattern matching
- Input validation

```python
import re

def validate_email(email):
    pattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
    return re.match(pattern, email) is not None
```

## Tech Stack

- **Python 3.10+**
- **Flask** — Web framework
- **SQLite** — Database
- **pytest** — Testing framework
- **regex** — Pattern matching
- **requests** — API calls

## Code Quality

✅ **PEP 8 Compliant** — `black` formatter, `flake8` linter  
✅ **Type Hints** — `mypy` for static type checking  
✅ **Comprehensive Tests** — `pytest` with >90% coverage  
✅ **Documentation** — Docstrings for all functions

## GitHub Repository

📂 **[View All Projects →](https://github.com/0xmuler/cs50p-python-projects)**

Each project includes:
- Detailed README
- Requirements and setup
- Example usage
- Test suite

## Key Learnings

1. **Pythonic Solutions** — List comprehensions, generators, context managers
2. **Testing is Essential** — `pytest` catches bugs before production
3. **Clean Code Matters** — Readable code is maintainable code
4. **Problem Decomposition** — Break problems into smaller functions
5. **Documentation is Code** — Future me thanks present me

## Course Topics Covered

- Functions and variables
- Conditionals and loops
- Exceptions and error handling
- File I/O (CSV, JSON, binary)
- Regular expressions
- Object-oriented programming
- Libraries and APIs
- Testing with pytest

## Favorite Problem: "Fiftyville"

**Concept**: SQL detective game — solve a mystery using database queries

**Skills**:
- Complex SQL (JOINs, subqueries, aggregations)
- Logical reasoning
- Data analysis

**Solution**: 15+ queries to identify thief, accomplice, and destination

## What's Next

Building on this foundation toward ML/MLOps:
- Applying Python to ML pipelines
- Scaling from scripts to production systems
- MLOps tools (MLflow, DVC, FastAPI)
