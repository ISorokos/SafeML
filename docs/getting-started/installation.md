---
title: Install SafeML
description: Install the SafeML Python package or clone the repository for Python, MATLAB, and R examples.
---

# Installation

## Python package

Create a virtual environment, upgrade pip, and install SafeML:

=== "Windows PowerShell"

    ```powershell
    python -m venv .venv
    .venv\Scripts\Activate.ps1
    python -m pip install --upgrade pip
    python -m pip install SafeML
    ```

=== "macOS and Linux"

    ```bash
    python -m venv .venv
    source .venv/bin/activate
    python -m pip install --upgrade pip
    python -m pip install SafeML
    ```

The package metadata declares `numpy` and `spm1d` as dependencies.

## Clone the complete repository

The complete examples and non-Python implementations are stored in the repository:

```bash
git clone https://github.com/ISorokos/SafeML.git
cd SafeML
```

!!! tip
    Use the packaged modules for small Python experiments. Clone the repository when following the MATLAB, R, notebook, or dataset-specific examples.
