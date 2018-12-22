local links = {}

function Link (link)
  links[link.target] = link.content
  return link.content
end

function Str (link)
  if link.text:match '^https?://' then return pandoc.Emph (link.text) end
end

function Doc (body)
  local lines = {}
  for link, content in pairs (links) do
    content:extend { pandoc.Emph (' '..link) }
    lines[#lines+1] = content
  end

  local h1
  if not pandoc.utils.stringify (body):match 'SEE ALSO' then

    h1 = pandoc.Header (1, pandoc.Str "SEE ALSO")
  end
  body.blocks:extend { h1, pandoc.LineBlock (lines) }
  return body
end

return {{ Link = Link }, { Str = Str }, { Doc = Doc }}
