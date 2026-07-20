---
title: SafeML Tutorial Workflow
description: Plan a SafeML experiment from trusted reference data through runtime monitoring and response evaluation.
---

# Tutorial: plan a monitoring experiment

## 1. Define the monitoring question

State which classifier input or feature distribution you want to compare and what operational change the monitor is intended to reveal.

## 2. Build the trusted reference

Use representative, reviewed training or validation data. Store samples or empirical distributions per class as required by the experiment.

## 3. Select a distance measure

Start with one of the implemented ECDF measures and document why it fits the data. The [API Reference](../reference/api.md) lists the package functions.

## 4. Evaluate operational windows

Apply the same preprocessing to buffered operational data and calculate its distance from the corresponding reference.

## 5. Calibrate and test the response

Evaluate candidate window sizes and thresholds on representative normal and shifted data. Define what the surrounding system should do when the result is uncertain or exceeds a threshold.

!!! important
    This workflow describes an experiment, not evidence of safety by itself. A deployed safety mechanism needs requirements, validation, failure analysis, and integration appropriate to its domain.
