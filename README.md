# quarto test

This reproduces a bug when building a [quarto](https://quarto.org) book which
includes a html widget. The
[`_quarto.yml`](https://github.com/mpadge/quarto-test/blob/main/_quarto.yml)
includes rendering for both html and pdf. The
[`makefile`](https://github.com/mpadge/quarto-test/blob/main/makefile) includes
by default "html" and "pdf". `make html` works fine, but `make pdf` (`quarto
render index.Rmd -t pdf`) fails.

The `index.Rmd` has a YAML header with `always_allow_html: true`. Removing this
causes failure because "Functions that produce HTML output found in document
targetting pdf output." This happens even though the lines are embedded within
a conditional statement:
```
::: {.content-hidden when-format="pdf"}
```
(And the same error arises regardless of how that conditional clause is
expressed.)

That error message goes on to recommend inserting `always_allow_html: true`, as
in the current version in this repo. Doing that leads to an xelatex error:

```
LaTex Error: Missing \begin{document}
```

This happens because the HTML lines for the widget created in `index.Rmd` are
inserted directly into `index.tex`.

---

## Summary

The `.content-hidden` conditional clause does not seem to be hiding the content
in the rendered `index.tex`, preventing it being compiled.
