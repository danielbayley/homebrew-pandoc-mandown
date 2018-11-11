[man]down
=========
_[Pandoc]_ [template] and [filter]s for converting markdown to [`man` page][man]s.

[Filter]s
---------
Filters can be specified individually with `--lua-filter filter`, but the default _[mandown]_ filter is recommended to apply all of the filters, in appropriate order:

| Filter `.lua` | Description                               |
|:--------------|:------------------------------------------|
| [mandown]     | Applies all filters in appropriate order. |

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

[mandown]:          filters/mandown.lua

[man]:              https://en.wikipedia.org/wiki/Man_page

[homebrew]:         https://brew.sh
[formula]:          https://docs.brew.sh/Formula-Cookbook
