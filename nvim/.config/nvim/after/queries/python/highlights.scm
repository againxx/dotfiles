(
    (identifier) @python.self (#any-of? @python.self "self" "cls")
)

(
    (string) @python.docstring (#match? @python.docstring "^r\?\(\"\|'\)\{3\}")
)
