---@diagnostic disable:undefined-global
local snippets = {
  s("amain", {
    t "#[tokio::main]",
    d(1, function(_, snip)
      if #snip.captures == 0 then
        return sn(nil, {
          t { "", "async fn main() {", "\t" },
          i(1),
          t { "", "}" },
        })
      else
        return sn(nil, t"")
      end
    end, {}),
  }, {
    callbacks = {
      [-1] = {
        [events.pre_expand] = function(node, event_args)
          local row, _ = unpack(event_args.expand_pos)
          local next_line = vim.api.nvim_buf_get_lines(0, row + 1, row + 2, false)[1]
          local main_fn = next_line:match "^%s*(fn main.*)$"
          if main_fn then
            vim.api.nvim_buf_set_lines(0, row + 1, row + 2, false, { "async " .. main_fn })
            node.captures[1] = main_fn
          elseif next_line:match "^%s*async%s+fn main.*$" then
            node.captures[1] = next_line
          end
        end,
      },
    },
  }),
}

return snippets
