package.path = PANDOC_SCRIPT_FILE:match ('.*/')..'?.lua;'..package.path

local List = require 'pandoc.List'
local metadata = require 'metadata'
local refs = {}

function Para (block)
  local command, n, args
  pandoc.walk_block (block, {
    Code = function (line)
      command, args = line.text:match '^(%w+)( ?.*)$' -- `command [args]`
    end,
    Str = function (section) n = section.text:match '%((%d)%)' end -- (n)
  })

  if not command then return
  elseif os.execute ('man '..command..' > /dev/null 2>&1') then n = n or '1'
  elseif command == metadata.title then n = metadata.section
  else return
  end

  local ref = { pandoc.Code (command), pandoc.Str ('('..n..')') }
  refs[command] = ref
  if args then args = pandoc.Code (args) end
  return pandoc[block.tag] { ref[1], ref[2], args }
end

function Doc (body)
  if not pandoc.utils.stringify (body):match 'SEE ALSO' then
    body.blocks:extend { pandoc.Header (1, pandoc.Str "SEE ALSO") }
  end

  local sort = {}
  for ref in pairs (refs) do sort[#sort+1] = ref end
  table.sort (sort)

  local block = List:new {}
  for i, ref in pairs (sort) do
    block:extend (refs[ref])
    if i < #sort then block:extend { pandoc.Str ',', pandoc.Space() } end
  end
  body.blocks:extend { pandoc.Para (block) }
  return body
end

return {{ Para = Para }, { Doc = Doc }, table.unpack (metadata) }
