# Makefile for the historical recreation documentation paper.
#
# Source layout:
#   paper/paper.typ        — main typst document
#   paper/sections/*.typ   — section files included by paper.typ
#   paper/refs.yml         — hayagriva bibliography
#   paper/paper.pdf        — compiled output (build artifact)
#
# Usage:
#   make            Compile the paper to PDF (default = pdf)
#   make pdf        Compile the paper to PDF
#   make watch      Recompile on every save (typst watch mode, Ctrl+C to stop)
#   make view       Open the compiled PDF in the system viewer
#   make clean      Remove the compiled PDF
#   make check      Verify the paper compiles cleanly
#   make help       Show available targets

# Disable legacy implicit rules — speeds parsing and prevents surprise matches.
.SUFFIXES:

PAPER_DIR := paper
SRC       := $(PAPER_DIR)/paper.typ
# The compiled PDF lives at the repo root so the canonical release file is
# easy to find and link to from outside the repo (e.g., reenactment events).
PDF       := Conversion_Damascus_Engraving_Documentation.pdf

# Pure-make wildcard expansion (no shell, no find latency, deterministic).
SOURCES := $(wildcard $(PAPER_DIR)/*.typ $(PAPER_DIR)/sections/*.typ $(PAPER_DIR)/*.yml)

.PHONY: all pdf watch view clean check check-typst help

## all: Compile paper to PDF (default target)
all: pdf

## pdf: Compile paper to PDF
pdf: $(PDF)

$(PDF): $(SOURCES) | check-typst
	@echo "==> Compiling $(SRC) -> $(PDF)"
	@typst compile $(SRC) $(PDF)
	@bytes=$$(wc -c < $(PDF) | tr -d ' '); \
	if command -v pdfinfo >/dev/null 2>&1; then \
		pages=$$(pdfinfo $(PDF) 2>/dev/null | awk '/^Pages:/ {print $$2}'); \
		echo "==> Wrote $(PDF) ($$bytes bytes, $$pages pages)"; \
	else \
		echo "==> Wrote $(PDF) ($$bytes bytes)"; \
	fi

## watch: Recompile on every save (typst watch, Ctrl+C to stop)
watch: | check-typst
	@echo "==> Watching $(SRC) for changes (Ctrl+C to stop)"
	@typst watch $(SRC)

## view: Open the compiled PDF in the system viewer
view: pdf
	@opener=$$(command -v xdg-open 2>/dev/null || command -v open 2>/dev/null); \
	if [ -n "$$opener" ]; then \
		"$$opener" $(PDF); \
	else \
		echo "No GUI opener available. The PDF is at $(PDF)"; \
	fi

## clean: Remove the compiled PDF
clean:
	@if [ -n "$(PDF)" ] && [ -f "$(PDF)" ]; then \
		rm -f $(PDF); \
		echo "==> Removed $(PDF)"; \
	else \
		echo "==> Nothing to clean"; \
	fi

## check: Verify the paper compiles cleanly
check: pdf
	@echo "==> Compile succeeded — $(PDF) is up to date."

# Internal: verify typst is on PATH. Used as an order-only prerequisite.
check-typst:
	@command -v typst >/dev/null || { \
		echo "Error: typst is not installed."; \
		echo "Install via 'cargo install --locked typst-cli', 'pacman -S typst', 'brew install typst', or 'nix shell nixpkgs#typst'."; \
		exit 1; \
	}

## help: Show available targets with brief descriptions
help:
	@echo "Available targets:"
	@grep -E '^##' $(MAKEFILE_LIST) | sed -E 's/^## /  /'
