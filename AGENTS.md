# AGENTS.md
 
Guidance for AI coding agents (Claude Code, Codex, etc.) working in this repository.
This is the canonical instruction file; `CLAUDE.md` imports it so both agents share it.
 
## What this repo is
 
A LaTeX **dissertation *proposal*** for a PhD comprehensive exam at the University of
Tennessee, Knoxville (Bredesen Center / Data Science Engineering). Author: Peter Kruse;
advisor: Dr. Daniel Jacobson. This is a *proposal*, not a thesis — see "Genre conventions"
below, because the genre rules differ from a full dissertation.
 
Working title: *Deep Learning for Biological Discovery Across Omics Layers: From Phenomics
to Agentic Reasoning.* The proposal spans three linked research chapters framed as stages of
biological discovery — **measurement → prediction → interpretation** — plus a literature
review.
 
## Repository layout
 
```
my-dissertation.tex          # main file; \input's everything. Build target.
utthesis.cls                 # UTK thesis/dissertation class (do not edit unless necessary)
makefile                     # build recipe
chapters/
  chapter-1.tex              # Literature review
  chapter-2.tex              # Pennycress seed pod phenotyping (most developed)
  chapter-3.tex              # Maize genomic prediction (GxE transformer)
  chapter-4.tex              # MENTOR-RL: agentic reasoning over biological networks
front-matter/                # abstract, acknowledgements, dedication, nomenclature, quote
back-matter/                 # appendix-1.tex (Ch2 supplementary tables), vita.tex
figures/
  eps/ pdf/                  # generic template figures
  pennycress-unet/           # Chapter 2 figures
  gxe-tf/                    # Chapter 3 figures
  mentor-rl/                 # Chapter 4 figures — TikZ .tex sources, not images
  lit-review/                # Chapter 1 figures
references/
  references-dissertation.bib
supplement/                  # README.md + ablation_run_manifest.csv (Ch 3 run inventory)
```
 
`\graphicspath` already includes `figures/`, `figures/eps/`, `figures/pdf/` — reference
figures by filename, and put new chapter figures in the matching `figures/<topic>/` subfolder.
 
**Chapter 4 figures are TikZ, not graphics.** `figures/mentor-rl/*.tex` are standalone TikZ
pictures pulled in as `\resizebox{\linewidth}{!}{\input{figures/mentor-rl/<name>}}`, not
`\includegraphics`. Their shared style file, `figures/mentor-rl/mentor-rl-style.tex`, is
`\input` in the preamble of `my-dissertation.tex` — a new Ch 4 figure should reuse those
styles rather than define its own colors.

`supplement/ablation_run_manifest.csv` is a **derived** artifact: it is regenerated from the
G×E paper repo's W&B export via `scripts/build_ablation_manifest.py` (command in
`supplement/README.md`). Do not hand-edit rows.
 
## Building
 
Canonical build is the makefile:
 
```
make           # pdflatex -> makeindex (nomenclature) -> biber -> pdflatex -> pdflatex
make clean     # removes aux/bbl/log/etc.
```
 
`latexmk -pdf my-dissertation` also works locally. Bibliography uses **biblatex**
(`[style=numeric]`) with **biber** as the backend — this is settled, do not switch it to
bibtex. Citations render as IEEE-style numeric brackets. The `makeindex ... -s nomencl.ist`
step builds `front-matter/nomenclature`; if a new abbreviation does not appear, it is usually
that step, not the bibliography.
 
Always confirm the document still compiles after edits before considering a change done.
 
## Chapter map (one line each)
 
- **Ch 1 — Literature review.** Five sections: deep learning history; computer vision; language
  modeling; HPC (scaling laws + distributed training); deep learning for biology. The final
  section is the payload — it carries the three subsections that ground Ch 2, Ch 3, and Ch 4.
  See "Chapter 1 conventions" below; the IMRaD rules do **not** apply to this chapter.
- **Ch 2 — Pennycress (*Thlaspi arvense*) seed pod phenotyping.** Image-based deep learning
  segmentation benchmarked across CNN / transformer / foundation-model architectures
  (boundary-down-weighted U-Net wins), 52 tissue-resolved phenotypes over 12,253 pods from
  768 accessions, then carried into biology via heritability screening → GWAS → **PPN** →
  **iRF-LOOP** → **GRIN** pruning → **MENTOR** modules → **MENTOR-IA** interpretation.
- **Ch 3 — Maize genomic prediction.** `FullTransformer`: 2,224 marker dosage tokens and 702
  environmental covariate tokens in one sequence, a Top-K mixture-of-experts feed-forward
  layer, and an environment-affine calibration head (G×E). Trained on 143,050 pre-2024 G2F
  plot records; evaluated retrospectively on 9,486 records from the 2024 competition cohort.
  **Headline numbers are in flux** — see "Live numbers" below before quoting a rank.
- **Ch 4 — MENTOR-RL.** Agentic reasoning system for mechanistic hypothesis generation over
  biological networks; trained on OLCF Frontier. Two-stage: Stage 1 is a supervised
  world-model curriculum over a multiplex lattice; Stage 2 post-trains a tool-using agent
  with DPO and GRPO against deterministic, schema-grounded rewards. Chapter-internal names:
  **MENTOR-EV** (the dendrogram/hierarchy view) and **RWR-LOE** (seeded random-walk
  neighborhoods). This is the only *unexecuted* chapter — see its genre carve-out below.

## Live numbers (verify before quoting)

These move between drafts, and stale copies of them are the most common error in this repo.
Check the chapter source rather than repeating a number from memory or from this file.

- **Ch 3 competition placement.** `chapter-3.tex` (`Competition Context`,
  `tab:ch3-external-results`) and the Ch 3 paragraph of `front-matter/abstract.tex` currently
  say macro-environment PCC **0.423**, MSE **55.40**, **sixth** place, 0.027 behind a winning
  0.45. **As of 2026-08-17 a newer G2F competition manuscript revises the comparison table and
  the placement changes.** Any of rank, gap-to-winner, the table rows, the Discussion opener,
  and the Executive Summary may need to change together — they are four separate copies of the
  same claim. Do not update one without the others.
- **Ch 2 counts** (12,253 pods / 768 accessions / 347 annotated pods / 52 traits / 34 traits
  past the H² screen / 85.58% mIoU) appear in both `chapter-2.tex` and the Executive Summary.
- **Ch 4 preliminary S0 result** (45.6% → 85.9% hard-subset accuracy under atomic
  tokenization) appears in `sec:ch4-prelim` and the Executive Summary.

## Genre conventions (IMRaD manuscript chapters)
 
**Applies to Ch 2 and Ch 3 only.** Ch 1 is a literature review and Ch 4 is a proposal chapter;
both have their own contracts below.

Each *completed* research chapter is written as close to a **submission-ready research
manuscript** as possible, in strict **IMRaD** form, with one added subsection. A chapter is not
a planning document, a work plan, or a collection of notes; it is a manuscript that happens to
be read by a committee. This mirrors the contract in the source paper repos — see
`latex/gxe-transformer-paper/AGENTS.md` for the fully worked version.
 
**Required chapter structure:**
 
1. **Introduction** — scientific problem, prior work, knowledge gap, study objective. Close
   with the study-design paragraph *baked in as prose*: open with the design question ("We
   designed this study to explore whether …"), walk through what the study actually did in
   past tense with concrete quantities attached, and put any remaining aim in one restrained
   closing clause.
2. **Methods** — completed, reproducible procedures only. Do not describe unexecuted variants
   as study methods.
3. **Results** — observed, verified findings only. Interpretation stays brief; do not use
   Results to promise later experiments.
4. **Discussion** — interpret the findings and compare them with prior work.
5. **Limitations and Future Work** — the one concession to the proposal genre, as a subsection
   at the end of the Discussion. It is more developed than a paper's would be because it
   doubles as the remaining-dissertation-work plan. Incomplete analyses live here, explicitly
   labeled, and nowhere else.
 
Everything outside that final subsection reads as a completed study in past tense.
 
**Retired conventions — do not reintroduce:**
 
- **No "Study Objectives" subsection** and no enumerated `\label{obj:...}` list. Retired
  2026-07-29; the Introduction's closing paragraph already states the objectives as prose.
- **No per-chapter publication preamble.** Publication status and venue targets live in one
  place: the `Completion Plan and Expected Outputs` section of
  `front-matter/abstract.tex` (the Executive Summary).
- **No per-chapter Conclusion section.** The Discussion carries the interpretation; a separate
  Conclusion duplicates it.
 
**Still in force:**
 
- **No** thesis-level introduction chapter, **no** standalone conclusion chapter, **no**
  contributions statement.
- Keep chapters **independent**: do **not** add forward-references to Chapter 4 / MENTOR-RL
  from the Chapter 2 introduction.

## Chapter 4 conventions (proposal chapter)

Chapter 4 describes work that has **not been executed**, so IMRaD does not apply and past tense
would be a misrepresentation. Its skeleton is:

```
Introduction
Proposed Methods          # future/present tense: "we define", "the agent must"
  Multiplex Lattice / Context Ontology / Three Structural Views
  Stage 1: Multiplex World Model
    Deterministic Runtime and Tool Contract / Supervised Curriculum
    Corpus Generation and Validation / Splits and Leakage Control
  Stage 2: Mechanistic Agent
    Agent Loop and Structured State / Task Cases and Targets / Task Corpora
    Trajectory Generation / Reward Design / Terminal Reward Decomposition for GRPO
  Training Pipeline and Curriculum
  Evaluation                # Stage 1 eval, Stage 2 eval, Ablation Studies
Expected Results          # Expected Empirical / Expected Behavioral / Deliverables
Discussion
  Preliminary Results       # the ONLY place completed Ch 4 work is reported, in past tense
  Plan of Work
  Limitations and Future Work
```

**Rules specific to this chapter:**

- **Tense is load-bearing.** Everything outside `sec:ch4-prelim` is proposed and stays in
  future or timeless present. `sec:ch4-prelim` is the one past-tense subsection — the S0
  tokenization result and the Frontier infrastructure runs. Do not let executed and proposed
  work blur together in either direction.
- **`Expected Results` is not `Results`.** It states what an outcome would mean, not what was
  observed. No numbers there that are not already in `sec:ch4-prelim`.
- **Do not assert a base model or parameter count** beyond what the chapter states. It names
  gpt-oss-120b only in the infrastructure context.
- Stage 2 is the densest part of the chapter (~3,350 words, 10 display equations across six
  subsubsections) and is the current cleanup target.

## Chapter 1 conventions (literature review)

Chapter 1 is the one chapter outside the IMRaD contract above. It is a **thesis-level
literature review**: argumentative and synthetic, not a chronicle. Its job is to make the
Executive Summary's thesis statement — that heterogeneous biological data require
problem-specific inductive biases — follow from the prior work rather than be asserted.

**Standing rules:**

- **Argument, not chronicle.** Do not write one paragraph per paper. Each subsection opens with
  the problem or claim, groups the works that bear on it, and closes on what remains unsolved —
  which is what licenses the next subsection. `sec:ch1-llmmech` and `sec:ch1-genomicpred` are
  the reference standard; match them.
- **Inductive bias is the spine.** Every modality section closes by naming the inductive bias
  its architecture encodes and whether biological data satisfy it. This is the thread that
  carries the chapter into the biology section.
- **One substantive treatment per work.** Later mentions are one-clause callbacks with a
  `\ref{}`, never a re-explanation. ImageNet/ILSVRC, Hubel & Wiesel, and ReLU/dropout/GPU have
  all been covered two or three times in past drafts — check before adding.
- **Foundations are committee-known.** Pre-2012 history earns space only where something
  downstream depends on it. Compress rather than narrate.
- **Cohesion over word count.** Word budgets are **not** the goal — do not trim to hit a number,
  and do not report progress as a word count. The goal is a review that flows: each paragraph
  follows from the one before it, and no detail appears that the chapter does not later use.
  Cut on the question "does anything downstream need this?", never on "is this section too
  long?". A longer passage that reads well beats a shorter one that reads clipped.
- **Proportion still matters, as a symptom.** The draft was once 80% general deep learning and
  20% biology while all three research chapters are biological. That imbalance is worth fixing
  because it means the foundations carry detail nothing uses — but fix it by removing unused
  detail, not by rationing words.

**Settled — do not reopen** (as of 2026-08-06):

- Cybernetics and Connectionism are merged into one subsection. The enabler and RL passages are
  prose, not lists. The duplicate ImageNet / Hubel & Wiesel / ReLU passes are gone.
- The roadmap sits at the chapter opening, and `sec:ch1-history` has its label.
- `Vision-Based Phenotyping` is written.
- `Transformer-Based Segmentation` **stays a separate subsection.** The earlier instruction to
  fold ViT/SAM into `sec:ch1-segmentation` applied when `sec:ch1-tfseg` was an empty stub; it is
  now a written subsection and Peter decided against folding it. Do not re-fold it.
- The `Synthesis` section exists and closes the chapter on measurement → prediction →
  interpretation.
- Every major section now closes on the inductive-bias thread and carries a forward `\ref`.

**Open work, in order:**

1. Line-level pass — mostly closed as of 2026-08-17. Done: the ViT callback in
   `sec:ch1-transformer` now points at `sec:ch1-tfseg`; the Bahdanau/Sutskever chronology reads
   "In concurrent work" (both preprints are September 2014, Bahdanau's first); trailing
   whitespace stripped. **Still open:** italics-on-first-use is applied to the biology terms but
   skipped for several others.
2. `hinton2012improving` — **resolved 2026-08-17.** The entry was added to
   `references-dissertation.bib` and verified against the arXiv record (arXiv:1207.0580,
   submitted 3 July 2012; Hinton, Srivastava, Krizhevsky, Sutskever, Salakhutdinov).
   `sec:ch1-imagenet` now attributes dropout to it rather than to `srivastava2014dropout` in the
   2012 ILSVRC passage — the preprint predates AlexNet's NeurIPS appearance, so it is the
   citation that work actually had. `srivastava2014dropout` remains correct where
   `sec:ch1-deeplearning` treats dropout generally. **The bib entry has not been mirrored into
   `latex/lit-review` yet** — do that with the chapter sync.
3. Close the setup gaps below.
4. Sync `chapter-1.tex` **from this repo out to `latex/lit-review`** — as of 2026-08-17 the
   proposal copy is the newer one. It leads on the opening paragraph, the `dl-timeline` caption,
   two `sec:ch1-cybernetics` paragraphs, and the network-methods material in `sec:ch1-llmmech`.
   The direction was the reverse in earlier drafts; check which copy is ahead before syncing.

**Coverage gaps — Ch 1 as setup for the later chapters** (counts re-verified 2026-08-17):

- ~~**Network-based methods have no home in Ch 1.**~~ **Closed 2026-08-17.** `sec:ch1-llmmech`
  was renamed `Mechanistic Interpretation of Biological Networks` and now runs: interactome and
  hierarchy → GWAS returns loci not mechanism → networks and iRF-LOOP construction → RWR
  propagation and GRIN refinement → MENTOR modules → the reading gap → the language model half →
  Chapter 4. Each in-house tool is paired with its external antecedent (`tong2006fast`,
  `kohler2008walking`, `vanunu2010associating`, `cowen2017network`, `uffelmann2021genome`) so the
  section reads as a review rather than a tour of Jacobson-lab software. **Keep it that way** —
  do not add an in-house method here without the external principle it instantiates.
- **Ch 3's calibration is not set up.** The last remaining coverage gap. `chapter-3.tex` uses
  "calibration" 20× and the environment-affine calibration head is one of its stated
  contributions; `chapter-1.tex` never introduces calibration as a concept or a problem.
  `sec:ch1-genomicpred` is the place for it, and the rank-versus-absolute-scale framing there
  should match whatever the G×E paper ends up leading with.

**Known accuracy traps in this chapter** (fix if encountered; do not reintroduce):

- ViT was not a response to W-Net and was *less* data-efficient than CNNs at comparable scale.
- AlexNet (2012) predates `srivastava2014dropout`; its dropout reference is `hinton2012improving`.
- Superhuman ILSVRC top-5 belongs to `he2015delving`, not to ResNet.
- The Universal Approximation Theorem addresses representational capacity, not learnability, so
  it is not a complete rebuttal of Minsky and Papert.
- The MDP formalism is Bellman/Howard; Sutton's contribution is temporal-difference learning.
- `guo2025deepseek` describes **two** models. The RL-only training and the emergent backtracking
  and self-correction belong to DeepSeek-**R1-Zero**; DeepSeek-**R1** adds a cold-start SFT stage
  before the RL phase. Do not attribute R1-Zero's result to R1.
- Distributed representations predate `bengio2003neural` — Elman (1990), cited two paragraphs
  later in the same subsection, and LSA. Bengio's contribution is learning them *within a
  language model*, not introducing them.
- Chapter 4 names no base model or parameter count. Do not assert a model scale for
  `ch4:mentor-rl` in Chapter 1 that Chapter 4 does not state.
## Writing style guide (apply to all prose)
 
- **"we" voice** throughout.
- **"deep learning"** — unhyphenated, even as an adjective.
- **"seed pod"** — two words. **"gene set"** — two words.
- **"pennycress"** — lowercase except sentence-initial.
- **"natural accessions"** (not "naturally occurring accessions").
- **"nearest annotated genes"** for GWAS-to-gene mapping.
- First use of a technical term in *italics* (not bold).
- IEEE numeric bracket citations.
- **PEN and PPN are different objects — do not treat them as variants of one name.** A *predictive
  expression network* (PEN) is built by iRF-LOOP over expression data, which is the published
  application in `cliff2019high`; a *predictive phenotype network* (PPN) is the same method applied
  to extracted phenotypes, which is what Chapter 2 does. Both are defined in
  `front-matter/nomenclature.tex`. Chapter 2 correctly uses PPN throughout (12×) and PEN nowhere,
  because its networks are over phenotypes. When Chapter 1 describes iRF-LOOP generically, PEN is
  the right term; when it points forward to Chapter 2, PPN is. Never swap one for the other.
- **System-name casing is inconsistent across chapters and not yet settled.** Ch 2 writes plain
  uppercase `MENTOR` / `MENTOR-IA`; Ch 4 writes `\textsc{Mentor-RL}`, `\textsc{Mentor-EV}`,
  `\textsc{Mentor}`. Match the chapter you are editing; do not normalize across chapters as a
  drive-by change (it is a whole-document pass and belongs on the polish list).
## LaTeX conventions
 
- **Label scheme (chapters):** every label carries its chapter number, so labels never collide
  when a chapter is re-synced from its source paper repo. Type prefix first, then `chN-`:
  `sec:ch3-training`, `fig:ch2-pc-ppn`, `tab:ch4-tools`, `eq:ch3-envpcc`, `alg:ch3-eval-pcc`.
  Chapter labels themselves are `ch2:pennycress`, `ch3:gxe`, `ch4:mentor-rl`, `ch1:lit-review`.
  Use `tab:` (not `tbl:`) and `eq:` (not `eqn:`). Front-matter and back-matter labels are
  outside this scheme — `back-matter/appendix-1.tex` legitimately carries `tbl:heritability-all`
  and `tbl:multiplex-layers`, and Chapter 2 references them across that boundary. Leave them.
  **When syncing a chapter from its paper repo, re-apply this prefix** — paper labels arrive
  unscoped.
- Put a non-breaking space `~` before every `\cite{}` and `\ref{}` (e.g. `as shown in~\ref{...}`).
- A `\todocite{...}` command is defined (renders red, bracketed). **Use `\todocite{description}`
  for any missing citation — never invent a citation key or fabricate a reference.**
- A `\comment{...}` command is defined (renders blue, bracketed, small sans). This is **Peter's**
  channel for leaving review notes in the source. Treat any `\comment{}` you encounter as an
  instruction or question directed at you, address it, and delete it once resolved. Do not add
  `\comment{}` to his prose unprompted — raise points in chat instead. Set `\showcommentsfalse`
  in `my-dissertation.tex` to hide all comments for a committee build; they stay in the source.
- `\textsc{MENTOR}` for the MENTOR system at first mention; this needs `\usepackage[T1]{fontenc}`.
  If small caps render incorrectly, fall back to plain `MENTOR` or `\textbf{MENTOR}` rather than
  shipping broken output.
- Wrap any `\renewcommand` overrides of title-page macros in `\makeatletter` / `\makeatother`.
- The `lineno` package is loaded for review line numbers — leave it in place.
## How Peter likes to work (important)
 
- **Paragraph-by-paragraph, minimally invasive edits.** Preserve the existing prose structure and
  voice. Do **not** produce full rewrites of sections that already exist.
- **Keep edits in Peter's own words.** When condensing or restructuring, reuse his existing
  sentences and phrasing wherever they survive the cut — **delete, reorder, and splice rather
  than re-express**. Compress by removing words, not by substituting your own. New wording is
  for genuine gaps only: a missing transition, a hedge on an overclaim, a sentence bridging two
  paragraphs that are now adjacent. A condensed paragraph should read as though Peter wrote it
  short, not as though someone else rewrote it. This governs the Chapter 1 compression work —
  hitting a word budget is never a license to paraphrase.
- Deliver changes in **human-readable old → new format**, not raw diff syntax, so they're easy to
  review.
- For sections Peter has already edited, **only flag substantive corrections**; don't re-litigate
  settled phrasing. Comprehensive review is welcome for newer/unwritten sections.
- Peter implements changes himself and returns revised drafts for further feedback — propose and
  explain edits rather than mass-applying them unprompted.
- If a critique misreads intent, expect a clear rebuttal; accept it cleanly and revise without
  pushback.
## Framing principles
 
- **Benchmarks** (Ch 2): scope conclusions as "best architecture *for this fixed pipeline*," not
  universal claims. Acknowledge that small-tile regimes may disadvantage foundation models /
  transformers relative to their native operating points.
- **MENTOR-IA** (Ch 2): frame as a preliminary proof-of-concept demonstrating scope. Hedge
  affirmatively — state scope plainly, don't apologize, and avoid superlatives implying
  comprehensiveness ("deep", "thorough", "full", "comprehensive").
## Data / analysis file handling
 
When touching the Chapter 2 analysis data (heritability tables, snp2gene files, edge lists):
 
- Look columns up **by name, not by hardcoded index** — column order varies between files.
- One H² spreadsheet has a sheet literally named `triaits_GWAS_hits` (the typo is real) — match it
  exactly.
- The authoritative SNP-to-gene file is the one suffixed `..._FINAL.txt`; prefer it over earlier
  variants.
## Related repos (not in this repo)

**Source manuscript repos.** Each research chapter is a genre-adapted fork of a standalone
paper repo. Chapters are synced *from* these; when syncing, re-apply the `chN-` label prefix and
preserve the proposal-genre additions (the `Limitations and Future Work` subsection, the
Executive Summary's claims, and any cross-chapter `\ref`s) rather than overwriting them.

- `latex/pennycress-unet-paper` — Chapter 2 source.
- `latex/gxe-transformer-paper` — Chapter 3 source; also holds the fully worked IMRaD contract
  in its own `AGENTS.md`, and the `scripts/build_ablation_manifest.py` that regenerates
  `supplement/ablation_run_manifest.csv`.
- `latex/mentor-rl-methods` — Chapter 4 source.
- `latex/lit-review` — Chapter 1 source. `chapter-1.tex` is edited here *and* there; changes
  need to land in both, and the bib entries do too.

**Code.**

- `pennycress-unet` — the Chapter 2 segmentation codebase (note: *not* `pennycress-segmentation`).
---
 
*Scope note: this file captures durable project context, conventions, and working style. It
deliberately omits in-flight analysis state (specific metrics, open reconciliation items), which
lives in working notes and changes too often to belong here.*