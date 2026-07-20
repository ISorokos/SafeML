---
title: SafeML Overview
description: Understand the SafeML runtime monitoring workflow, scope, and available implementations.
---

# SafeML overview

SafeML investigates active runtime monitoring for machine learning classifiers. Its core comparison is between statistical characteristics learned from trusted training data and characteristics calculated from incoming operational data.

## Monitoring workflow

1. Train a classifier on trusted, labelled data.
2. Estimate and store per-class distributions and statistical parameters.
3. Buffer incoming operational samples and group them using predicted labels.
4. Compare the resulting empirical distributions with their trusted references.
5. Interpret the distance using thresholds selected and validated during system design.

!!! warning "Thresholds are application-specific"
    The repository does not define a universally safe buffer size or confidence threshold. The README states that experts should select these design-time parameters for the application.

## Available implementations

| Implementation | Repository location | Highlights |
| --- | --- | --- |
| Python package | [`SafeML/`](https://github.com/ISorokos/SafeML/tree/master/SafeML) | Installable distance-measure functions. |
| Python examples | [`Implementation_in_Python/`](https://github.com/ISorokos/SafeML/tree/master/Implementation_in_Python) | Security and traffic-sign examples. |
| MATLAB | [`Implementation_in_MATLAB/`](https://github.com/ISorokos/SafeML/tree/master/Implementation_in_MATLAB) | Distance measures and several case studies. |
| R | [`Implementation_in_R/`](https://github.com/ISorokos/SafeML/tree/master/Implementation_in_R) | Synthetic and benchmark dataset examples. |

Continue with [Installation](installation.md) or jump to the [Quick Start](quick-start.md).
