local filters = PANDOC_SCRIPT_FILE:match '.*/'
package.path = filters..'?.lua;'..filters..'../libexec/?.lua;'..package.path

local utils = require 'utils'

local metadata = {}
local stdout = utils.sh 'git log -1 --tags=v[0-9]* --date=format:%B\\ %Y'
metadata.author = stdout:match 'Author:%s+([^\n\r]+)'
metadata.date = stdout:match 'Date:%s+([^\n\r]+)'

function Header (h)
  local text = utils.stringify (h.content)
  if h.level == 1 then
    metadata.header = text:sanitize()

  elseif text:upper():match '^NAME$' then
    metadata.title = nil
    metadata.header = nil
  elseif text:upper():match '^AUTHOR' then metadata.author = nil
  end
  return h
end

function Doc (body)
  body.blocks:map (function (block, i)
    if block.t == 'Header' and
      utils.stringify (block.content):upper():match '^SYNOPSIS$' then

      pandoc.walk_block (body.blocks[i+1], {
        Code = function (line)
          if not metadata.title then
            metadata.title = line.text:match '^(%w+)' -- `command
          end
        end,
        Str = function (section)
          if not metadata.section then
            metadata.section = section.text:match '%((%d)%)' or '1' -- (n)
          end
        end
      })
    end
  end)
end

function Meta (data)
  for key, value in pairs (metadata) do
    if data[key] == nil then data[key] = value end
  end
  return data
end

return {{ Header = Header }, { Doc = Doc }, { Meta = Meta }}
