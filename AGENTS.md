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
back-matter/                 # appendix-1.tex, vita.tex
figures/
  eps/ pdf/                  # generic template figures
  pennycress-unet/           # Chapter 2 figures
  gxe-tf/                    # Chapter 3 figures
  mentor-rl/                 # Chapter 4 figures
  lit-review/                # Chapter 1 figures
references/
  references-dissertation.bib
```
 
`\graphicspath` already includes `figures/`, `figures/eps/`, `figures/pdf/` — reference
figures by filename, and put new chapter figures in the matching `figures/<topic>/` subfolder.
 
## Building
 
Canonical build is the makefile:
 
```
make          # pdflatex -> bibtex -> pdflatex -> pdflatex
make clean     # removes aux/bbl/log/etc.
```
 
`latexmk -pdf my-dissertation` also works locally. Bibliography uses **biblatex**
(`[style=numeric]`) loaded via `\addbibresource`; citations render as IEEE-style numeric
brackets. If citations don't resolve, the bib backend (biber vs. bibtex) may need attention —
flag it rather than rewriting the bib setup.
 
Always confirm the document still compiles after edits before considering a change done.
 
## Chapter map (one line each)
 
- **Ch 1 — Literature review.** Five sections: deep learning history; computer vision; language
  modeling; HPC (scaling laws + distributed training); deep learning for biology. The final
  section is the payload — it carries the three subsections that ground Ch 2, Ch 3, and Ch 4.
  See "Chapter 1 conventions" below; the IMRaD rules do **not** apply to this chapter.
- **Ch 2 — Pennycress (*Thlaspi arvense*) seed pod phenotyping.** Image-based deep learning
  segmentation (U-Net) linked to population genetics (GWAS) and network biology (PEN → MENTOR).
- **Ch 3 — Maize genomic prediction.** `FullTransformer`: marker dosage tokens and
  environmental covariate tokens in one sequence, a Top-K mixture-of-experts feed-forward
  layer, and an environment-affine calibration head (G×E).
- **Ch 4 — MENTOR-RL.** Agentic reasoning system for mechanistic hypothesis generation over
  biological networks; trained on OLCF Frontier.
## Genre conventions (IMRaD manuscript chapters)
 
Each research chapter is written as close to a **submission-ready research manuscript** as
possible, in strict **IMRaD** form, with one added subsection. A chapter is not a planning
document, a work plan, or a collection of notes; it is a manuscript that happens to be read
by a committee. This mirrors the contract in the source paper repos — see
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

1. Finish the line-level pass. Known remaining items: `sec:ch1-transformer` re-explains ViT in
   one clause without a `\ref` callback to `sec:ch1-tfseg`, where it is already treated
   substantively; the Bahdanau/Sutskever chronology in `sec:ch1-lm-pretransformer` says "less
   than a year later" when Bahdanau's preprint actually preceded Sutskever's; italics-on-first-use
   is applied to the biology terms but skipped for several others; trailing whitespace on
   paragraph-final lines.
2. Decide on `hinton2012improving`. The ILSVRC-yields list in `sec:ch1-imagenet` currently
   attributes dropout to `srivastava2014dropout` (2014) in a passage about what the competition
   produced in 2012. The key is **not** in `references-dissertation.bib`; adding it means adding
   the entry here *and* in the `latex/lit-review` copy.
3. Close the setup gaps below.
4. Sync `chapter-1.tex` back from `latex/lit-review`.

**Coverage gaps — Ch 1 as setup for the later chapters:**

- **Ch 2's network-biology half is not set up.** `chapter-2.tex` uses GWAS (23×), MENTOR (27×),
  PPN (13×), and iRF-LOOP (8×). `chapter-1.tex` mentions GWAS once in passing, mentions MENTOR
  only inside `sec:ch1-llmmech` (the Chapter 4 subsection), and never mentions PPN or iRF-LOOP.
  `sec:ch1-phenotyping` grounds only the segmentation half of Chapter 2.
- **Ch 3's calibration is not set up.** `chapter-3.tex` uses "calibration" 20× and the
  environment-affine calibration head is one of its stated contributions; `chapter-1.tex` never
  introduces calibration as a concept or a problem.

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
- Maintain consistent **PEN** vs. **PPN** usage (don't mix the two for the same object).
## LaTeX conventions
 
- **Label scheme (chapters):** every label carries its chapter number, so labels never collide
  when a chapter is re-synced from its source paper repo. Type prefix first, then `chN-`:
  `sec:ch3-training`, `fig:ch2-pc-ppn`, `tab:ch4-tools`, `eq:ch3-envpcc`, `alg:ch3-eval-pcc`.
  Chapter labels themselves are `ch2:pennycress`, `ch3:gxe`, `ch4:mentor-rl`, `ch1:lit-review`.
  Use `tab:` (not `tbl:`) and `eq:` (not `eqn:`). Front-matter and back-matter labels are
  outside this scheme. **When syncing a chapter from its paper repo, re-apply this prefix** —
  paper labels arrive unscoped.
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
## Related code repos (not in this repo)
 
- `pennycress-unet` — the Chapter 2 segmentation codebase (note: *not* `pennycress-segmentation`).
---
 
*Scope note: this file captures durable project context, conventions, and working style. It
deliberately omits in-flight analysis state (specific metrics, open reconciliation items), which
lives in working notes and changes too often to belong here.*