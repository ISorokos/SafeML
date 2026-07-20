---
title: Contribute to SafeML
description: Contribute code, examples, and documentation to the SafeML project on GitHub.
---

# Contributing

Before making a change, discuss it with the maintainers through a [GitHub issue](https://github.com/ISorokos/SafeML/issues) or another maintainer-approved channel.

## Suggested workflow

1. Fork the repository and create a focused branch.
2. Make the change and update relevant documentation.
3. Test the implementation or build the documentation locally.
4. Open a pull request explaining the change and its impact.

Read the repository's [contributing guide](https://github.com/ISorokos/SafeML/blob/master/CONTRIBUTING.md) and [code of conduct](https://github.com/ISorokos/SafeML/blob/master/CODE_OF_CONDUCT.md) before submitting work.

## Build these docs locally

```bash
python -m pip install -r docs/requirements.txt
python -m mkdocs build -f mkdocs.yml --clean --strict
python -m mkdocs serve -f mkdocs.yml
```
