local black = {
  formatCommand = "black --quiet --stdin-filename ${INPUT} -",
  formatStdin = true,
}

local pylint = {
  lintCommand = "pylint --output-format text --score no --msg-template {path}:{line}:{column}:{C}:{msg} ${INPUT}",
  lintStdin = false,
  lintFormats = { "%f:%l:%c:%t:%m" },
  lintOffsetColumns = 1,
  lintCategoryMap = { I = "N", R = "I", C = "I", W = "W", E = "E", F = "E" },
  lintSource = "pylint",
}

local cppcheck = {
  lintCommand = "cppcheck --language=c++ --template={line}:{column}:{severity}:{message} --enable=style --force --inconclusive --quiet ${INPUT}",
  lintStdin = false,
  lintFormats = {
    "%l:%c:%trror:%m",
    "%l:%c:%tarning:%m",
    "%l:%c:%ttyle:%m",
    "%l:%c:%terformance:%m",
    "%l:%c:%tortability:%m",
    "%l:%c:%tnformation:%m",
  },
  lintCategoryMap = { i = "N", s = "I", p = "W", w = "W", e = "E" },
  lintIgnoreExitCode = true,
  lintSource = "cppcheck",
}

local cpplint = {
  lintCommand = "cpplint --filter=-build/include_subdir,-build/header_guard,-build/c++11,-legal/copyright,-whitespace/line_length ${INPUT}",
  lintStdin = false,
  lintIgnoreExitCode = true,
  lintFormats = {
    "%f:%l:  %m [%t]",
    "%f:%l:%c %m [%t]",
  },
  lintCategoryMap = { ["1"] = "N", ["2"] = "I", ["3"] = "I", ["4"] = "W", ["5"] = "E" },
  lintSource = "cpplint",
}

local vint = {
  lintCommand = "vint --format '{file_path}:{severity}:{line_number}:{column_number}: {description} (see {reference})' --enable-neovim --style-problem --no-color -",
  lintStdin = true,
  lintFormats = {
    "%f:%trror:%l:%c: %m",
    "%f:%tarning:%l:%c: %m",
    "%f:%ttyle_problem:%l:%c: %m",
  },
  lintCategoryMap = { s = "I", w = "W", e = "E" },
  lintSource = "vint",
}

local shellcheck = {
  lintCommand = "shellcheck -f gcc -x",
  lintFormats = {
    "%f:%l:%c: %trror: %m",
    "%f:%l:%c: %tarning: %m",
    "%f:%l:%c: %tote: %m",
  },
  lintSource = "shellcheck",
}

local stylua = {
  formatCommand = "stylua -",
  formatStdin = true,
  rootMarkers = { ".stylua.toml", "stylua.toml" },
}

return {
  cmd = { "efm-langserver", "-logfile", "/tmp/efm.log", "-loglevel", "5" },
  init_options = { documentFormatting = true },
  filetypes = { "lua", "python", "cpp", "vim", "sh" },
  settings = {
    rootMarkers = { ".git/", ".vim/" },
    languages = {
      lua = {
        stylua,
      },
      python = {
        black,
        pylint,
      },
      cpp = {
        cppcheck,
        cpplint,
      },
      vim = {
        vint,
      },
      sh = {
        shellcheck,
      },
    },
  },
  on_attach_extra = function(client, bufnr)
    -- Use clangd for formatting
    if vim.api.nvim_buf_get_option(bufnr, "filetype") == "cpp" then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      client.server_capabilities.document_formatting = false
    end
  end,
}
