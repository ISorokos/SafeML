---
title: SafeML Python Quick Start
description: Calculate empirical distribution distances with the SafeML Python package.
---

# Python quick start

SafeML's package modules accept two one-dimensional sample collections and return a distance value.

```python
from SafeML.WassersteinDistance import Wasserstein_Dist

reference = [0.0, 0.1, 0.2, 0.3, 0.4]
current = [0.1, 0.2, 0.3, 0.4, 0.5]

distance = Wasserstein_Dist(reference, current)
print(f"Wasserstein distance: {distance:.3f}")
```

## Compare multiple windows

```python
from SafeML.Kolmogorov_Smirnov_Distance import Kolmogorov_Smirnov_Dist

reference = [0.0, 0.1, 0.2, 0.3, 0.4]
windows = {
    "near": [0.05, 0.15, 0.25, 0.35, 0.45],
    "shifted": [1.0, 1.1, 1.2, 1.3, 1.4],
}

for name, samples in windows.items():
    value = Kolmogorov_Smirnov_Dist(reference, samples)
    print(name, value)
```

!!! caution
    A distance value is not a calibrated probability of failure. Evaluate the measure, window size, threshold, and response against representative data for the intended application.

Next, review the [usage examples](../guides/index.md) and [API reference](../reference/api.md).
