function Code (inline)
  return pandoc.Strong (inline.text)
end

function CodeBlock (block)
  local code = {}
  for line in block.text:gmatch '[^\n\r]+' do
    code[#code+1] = { pandoc.Strong (line) }
  end
  return pandoc.LineBlock (code)
end

return {{ Code = Code }, { CodeBlock = CodeBlock }}
