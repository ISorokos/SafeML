---
title: SafeML FAQ
description: Answers about SafeML buffer sizes, thresholds, supported languages, and interpretation.
---

# Frequently asked questions

## How should I choose the buffer size?

The project README says an expert should define the buffer size at design time. It must be long enough to represent the statistical characteristics of incoming data. Validate the choice against the expected data rate, distribution, and detection latency.

## How should I choose a confidence or distance threshold?

Treat it as an application-specific hyperparameter selected during the offline phase after training the classifier. Evaluate false alarms and missed shifts on representative validation scenarios.

## Does a small distance prove that a classifier is safe?

No. The distance describes similarity under a selected measure and sample window. It does not by itself establish correctness, robustness, or safety.

## Which languages are supported?

The repository contains Python, MATLAB, and R implementations. Coverage and examples differ between languages.

## Is SafeML only for classifiers?

The current repository and original paper focus primarily on classification. The README identifies regression, clustering, and time-series classification as areas for extension; do not assume equivalent support without reviewing the relevant project material.
