-- I had trouble using nushell withing neovim.
--
-- if you use :r !ls with nvim running inside of nushell i get the same error as you above: "cant read file ...".
--
-- I think this might happen because of the "set shellredir" option.
-- By default this is set to "shellredir=>". ">" in this nushell context is not a valid file redirector.
-- It should be something like "| save %s".
--
-- There is one more step to get "r !ls" working in nushell after setting "set shellredir=| save %s".
-- You will still get the same error as above. When you run :5verbose r!ls you will see which command nvim tries to execute:
--
-- Log:
-- Executing command: "(ls) | save /var/folders/d7/6dndt7v55hnfdw_lb6vqfz0dmwspnq/T/nvim.jonas.leonhard/bXLj5v/0"
--
-- And if you run this command in nushell you will get:
--
-- Error: nu::shell::cant_convert
--
--   × Can't convert to string.
--    ╭─[entry #2:1:1]
--  1 │ (ls) | save /var/folders/d7/6dndt7v55hnfdw_lb6vqfz0dmwspnq/T/nvim.jonas.leonhard/Lvs8Cz/2
--    ·  ─┬
--    ·   ╰── can't convert record<name: string, type: string, size: filesize, modified: date> to string
--    ╰────
--
-- This is because ls returns a record instead of a string, which cannot be saved into a file. To fix this you could run something like:
-- ":r !ls | to text" or ":r !ls | get name"

if string.match(vim.o.shell, '/nu$') then
  vim.opt.shellredir = '| save %s'
end
