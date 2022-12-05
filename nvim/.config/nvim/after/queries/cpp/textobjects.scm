;; extends

(parameter_declaration
    (identifier) @param.inner) @param.outer

[(preproc_include) (preproc_def)] @include

(function_definition
  declarator: (function_declarator
    declarator: [
        (identifier) @function.name
        (qualified_identifier
            name: (identifier) @function.name)
]))
