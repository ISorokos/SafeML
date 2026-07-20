---
title: SafeML Python API Reference
description: Reference for the empirical distribution distance and confidence functions included in SafeML 0.3.
---

# Python API reference

The package currently exposes functions through individual modules. Import functions from the module paths shown below.

| Module | Function | Purpose |
| --- | --- | --- |
| `SafeML.Kolmogorov_Smirnov_Distance` | `Kolmogorov_Smirnov_Dist(XX, YY)` | Kolmogorov–Smirnov ECDF distance. |
| `SafeML.KuiperDistance` | `Kuiper_Dist(XX, YY)` | Kuiper ECDF distance. |
| `SafeML.Anderson_Darling_Distance` | `Anderson_Darling_Dist(XX, YY)` | Anderson–Darling distance. |
| `SafeML.CVM_Distance` | `CVM_Dist(XX, YY)` | Cramér–von Mises distance. |
| `SafeML.WassersteinDistance` | `Wasserstein_Dist(XX, YY)` | Wasserstein distance. |
| `SafeML.DTS_Distance` | `DTS_Dist(XX, YY)` | DTS distance implemented by the project. |
| `SafeML.ChernoffDistance` | `chernoff_distance(s, means, variances, univariate=False)` | Chernoff-distance calculation. |
| `SafeML.Wilson_Interval_Confidence` | `Wilson_Interval_Confidence(p, n, z=3.29)` | Wilson confidence interval calculation. |

Several `*_Dist_PVal` modules also include distance and p-value functions for their named measures. Consult the [package source](https://github.com/ISorokos/SafeML/tree/master/SafeML) for the implementation details and exact return values.

!!! note
    Argument names follow the source code. `XX` and `YY` are expected to be finite, non-empty one-dimensional sample collections compatible with NumPy operations.
