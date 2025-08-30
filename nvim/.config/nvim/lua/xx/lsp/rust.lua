return {
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        disabled = { "unresolved-proc-macro" },
      },
      check = {
        command = "clippy",
      }
    }
  }
}
