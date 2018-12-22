local filters = PANDOC_SCRIPT_FILE:match '.*/'
package.path = filters..'?.lua;'..filters..'../libexec/?.lua;'..package.path

local utils = require 'utils'
local aliases = require 'aliases'

function Header (h)
  local text = pandoc.utils.stringify (h.content)

  if h.level == 1 then text = "DESCRIPTION"
  else text = text:sanitize():upper()
  end

  if h.level > 2 then h.level = 2 else h.level = 1 end

  for replace, pattern in pairs (aliases) do
    if pattern and #pattern > 0 then
      for i in ipairs (pattern) do
        if text:lower():match (pattern[i]) then text = replace end
      end
    end
  end
  h.content = { pandoc.Str (text) }
  return h
end

return {{ Header = Header }}
