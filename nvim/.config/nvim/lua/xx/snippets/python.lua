---@diagnostic disable:undefined-global
local VISUAL = require("xx.snippets.utils").VISUAL
local line_begin = require("xx.snippets.utils").line_begin

local import_as = function(trigger, import_str, as_str)
  return s(trigger, t(string.format("import %s as %s", import_str, as_str)), line_begin(trigger))
end

local get_quoting_style = function()
  if vim.g.luasnip_python_quoting_style == "double" then
    return '"'
  else
    return "'"
  end
end

local snippets = {
  import_as("impnp", "numpy", "np"),
  import_as("imppd", "pandas", "pd"),
  import_as("impplt", "matplotlib.pyplot", "plt"),
  import_as("impo3d", "open3d", "o3d"),
  import_as("impo3c", "open3d.core", "o3c"),
  import_as("imptf", "tensorflow", "tf"),
  s("imptest", t "import pytest", line_begin("imptest")),
  s("fromty", t "from typing import ", line_begin("fromty")),
  s("impto", {
    t "import torch",
    c(1, {
      t "",
      t { "", "from torch import nn" },
    }),
  }, line_begin("impto")),
  s(
    "ifmain",
    fmt(
      [[
    if __name__ == {}__main__{}:
    	{}
  ]],
      {
        f(get_quoting_style),
        f(get_quoting_style),
        VISUAL "main()",
      }
    )
  ),
  s("tyignore", t "# type: ignore"),
  s(
    "nparr",
    fmt(
      [[
  np.array({}{}{})
  ]],
      {
        VISUAL(),
        i(1),
        c(2, {
          sn(1, { t ", dtype=np.", i(1, "float32") }),
          t "",
        }),
      }
    )
  ),
  s(
    "trten",
    fmt(
      [[
  torch.tensor({}{}{})
  ]],
      {
        VISUAL(),
        i(1),
        c(2, {
          sn(1, { t ", dtype=torch.", i(1, "float32") }),
          t "",
        }),
      }
    )
  ),
}

local auto_snippets = {
  s("npf3", t "np.float32"),
  s("npf6", t "np.float64"),
  s("npi3", t "np.int32"),
  s("npi6", t "np.int64"),
  s("trf3", t "torch.float32"),
  s("trf6", t "torch.float64"),
  s("tri3", t "torch.int32"),
  s("tri6", t "torch.int64"),
}

return snippets, auto_snippets
