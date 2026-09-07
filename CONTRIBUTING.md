# Contributing to BashPass

Contributions to BashPass are welcome. You can help by reporting issues, improving the code, or improving the documentation.

## Issues

If you find a bug, have a feature request, or have a question, open an [issue](https://github.com/AntonVanAssche/BashPass/issues) and provide enough information to explain the problem or suggestion.

## Code Contributions

Code contributions should be submitted through a pull request.

### Code Style

To ensure consistency and readability of the codebase, please follow these guidelines when contributing to BashPass:

- Bash Built-ins: Utilize Bash built-in commands whenever possible.
- Indentation: Please use **4** spaces for indentation.
- Line Length: Aim to keep lines below **100** characters long.
- Minimize External Commands: Limit the usage of external commands like `$(cmd)`.
- Naming Convention: Follow the `snake_case` convention for function and variable names.
- Output: Prefer `printf` over `echo`.
- Piping: Avoid excessive piping (`|`).
- Return Codes: Ensure return codes are meaningful and consistent.
- Syntax: Use single quotes for strings without variables, and double quotes for those with variables.
- Syntax: It's important to quote **EVERYTHING**.
- Syntax: Utilize `(( ))` and `[[ ]]` syntax for loops and conditionals where applicable.
- Syntax: Utilize compact test syntax for single-command tests, otherwise `if`/`fi` is suitable.
- Syntax: Variables should be enclosed in `{}`.
- Variables: Global variables should be in uppercase.
- Variables: Local variables should be in lowercase.
- Variables: Use `local` variables whenever feasible.
- Variables: Use `readonly` for variables that should not be changed, otherwise use `declare` or `local`.

Here are examples for clarity:

```bash
# Bad
if [[ "${var}" ]]; then
    printf '%s\n' "${var}"
fi

# Acceptable, but not preferred
test "${var}" && printf '%s\n' "${var}"

# Good
[[ "${var}" ]] && printf '%s\n' "${var}"

# Also good (Use this for longer lines).
[[ "${var}" ]] && \
    printf '%s\n' "${var}"
```

```bash
# Bad
str="This string doesn't contain any variables"

# Good
str='This string does not contain any variables'
str="This string contains a variable: ${var}"
```

```bash
# Bad
readonly var="This variable should not be changed"

# Good
readonly VAR="This variable should not be changed"

# Bad
func() {
    var="${1}"
}

# Good
func() {
    local var="${1}"
}
```

### Acceptance Criteria

For your contribution to be accepted, your changes must meet the 2 main criteria:

- **ShellCheck**: The code must pass ShellCheck without errors.
- **Bash 3.0 compatibility**: The code must remain compatible with Bash 3.0 and newer.

Source: [ShellCheck](https://github.com/koalaman/shellcheck)

```console
shellcheck bashpass
```

Source: [Bash 3.0](https://ftp.gnu.org/gnu/bash/bash-3.0.tar.gz)

```console
tar -xvf bash-3.0.tar.gz
cd bash-3.0/
./configure
make -j 4
```

Then use the resulting Bash binary to test BashPass and verify that the changes work as expected.

## Documentation Contributions

Documentation changes are welcome for both the man page and README:

- `man/bashpass.1`
- `README.md`

Keep documentation clear, concise, and consistent with the actual behavior of BashPass.
Avoid unnecessary detail and keep examples relevant to the feature being documented.

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](./LICENSE.md).
