# Supplemental ablation inventory

`ablation_run_manifest.csv` is a run-level inventory derived from the complete W&B
CSV export used during manuscript preparation. It preserves every exported record,
including unsuccessful runs and records without test metrics. The manifest is an
audit trail, not a claim that every row is an independent or directly comparable
ablation.

The `manuscript_disposition` field distinguishes the six representative records used
in the three main-text comparisons from completed supplement-only runs, unsuccessful
runs, repeated run signatures, records without exported test metrics, and experiments
from the later data-generation or tokenization campaign. The latter remain designated
as future work and are not used to support the primary Results.

Regenerate the manifest from the paper repository with:

```sh
python3 scripts/build_ablation_manifest.py \
  ../../research/phenotyping/GP-Transformer/data/wandb_export_2026-07-22T16_22_44.564-04_00.csv \
  supplement/ablation_run_manifest.csv
```
