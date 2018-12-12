[man]down
=========
_[Pandoc]_ [template] and [filter]s for converting markdown to [`man` page][man]s.

[Filter]s
---------
Filters can be specified individually with `--lua-filter filter`, but the default _[mandown]_ filter is recommended to apply all of the filters, in appropriate order:

| Filter `.lua`            | Description                                                    |
|:-------------------------|:---------------------------------------------------------------|
| [mandown]                | Applies all filters in appropriate order.                      |
| [metadata][metadata.lua] | Extract the below [metadata](#metadata) as Pandoc [variable]s. |
| [code-bold]              | Render `inline` and [fenced] code blocks as **bold**.          |

### [Metadata]
[`--metadata`]/[`--variable`][variable]s can be passed directly on the command line, else are extracted from the markdown source as follows:

| [Variable]            | Source                                                                    |
|:----------------------|:--------------------------------------------------------------------------|
| [`author`][variable]  | Extract [`GIT_AUTHOR`] details from the latest [GitHub Release] `commit`. |
| [`date`][variable]    | Latest [GitHub Release] date.                                             |
| [`title`][variable]   | The `command` first described in the `SYNOPSIS` section.                  |
| [`section`][`header`] | Any `(n)` immediately following `command`, else `(1)`.                    |
| [`header`]            | Taken from the main `h1` header, and stripped of any formatting.          |
| [`footer`][`header`]  | [Semantic version] tag `v0.0.0` of the latest [GitHub Release].           |

Example
-------
~~~ sh
pandoc --from gfm src.md --lua-filter mandown --to man --template mandown > bin.1
~~~

Install
-------
easily with _[Homebrew]_:
~~~ sh
brew tap danielbayley/pandoc
brew install pandoc pandoc-mandown
~~~
then, in your _[formula]_:
~~~ rb
depends_on "pandoc" #=> :build
depends_on "danielbayley/pandoc/pandoc-mandown" #=> :build
~~~

License
-------
[MIT] © [Daniel Bayley]

[MIT]:              LICENSE.md
[Daniel Bayley]:    https://github.com/danielbayley

[pandoc]:           https://pandoc.org
[template]:         https://pandoc.org/MANUAL#templates
[filter]:           https://pandoc.org/lua-filters

[metadata]:         https://pandoc.org/MANUAL.html#metadata-blocks
[`--metadata`]:     https://pandoc.org/MANUAL.html#templates
[variable]:         https://pandoc.org/MANUAL.html#variables-set-by-pandoc
[`header`]:         https://pandoc.org/MANUAL.html#variables-for-man-pages

[mandown]:          filters/mandown.lua
[metadata.lua]:     filters/metadata.lua
[code-bold]:        filters/code-bold.lua

[man]:              https://en.wikipedia.org/wiki/Man_page

[`GIT_AUTHOR`]:     https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables#_committing
[fenced]:           https://help.github.com/articles/creating-and-highlighting-code-blocks/#fenced-code-blocks
[github release]:   https://help.github.com/articles/about-releases
[semantic version]: https://semver.org

[homebrew]:         https://brew.sh
[formula]:          https://docs.brew.sh/Formula-Cookbook
