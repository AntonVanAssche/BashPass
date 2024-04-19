# 1. Reporting Bugs

If you come across a bug, feel free to report it by opening a new [issue](https://github.com/AntonVanAssche/BashPass/issues), and selecting the `Bug report` template.

# 2. Feature Requests

If you'd like a new feature to be added, feel free to open a new [issue](https://github.com/AntonVanAssche/BashPass/issues), and select the `Feature request` template.

# 3. Questions

If you have any questions, feel free to open a new [issue](https://github.com/AntonVanAssche/BashPass/issues), and select the `Question or Support Request` template.

# 4. Security Vulnerabilities

If you discover a security vulnerability within BashPass, please open a new [issue](https://github.com/AntonVanAssche/BashPass/issues) and select the ` Report a security vulnerability ` template.

# 5. Guide for Code Contributions

## 5.1 Branch Model

BashPass is developed mainly through the master branch, and pull requests should be [fork based](https://help.github.com/articles/using-pull-requests/).

## 5.2 Code Style

To ensure consistency and readability of the codebase, please follow these guidelines when contributing to BashPass:

- Bash Built-ins: Utilize Bash built-in commands whenever possible.
- Indentation: Please use **4** spaces for indentation.
- Line Length: Aim to keep lines below **100** characters long.
- Minimize External Commands: Limit the usage of external commands like `$(cmd)`.
- Naming Convention: Follow the `snake_case` convention for function and variable names.
- Output: Prefer `printf` over `echo`.
- Piping: Avoid excessive piping (`|`).
- Return Codes: Ensure return codes are meaningful and consistent.
- Symtax: Use single quotes for strings without variables, and double quotes for those with variables.
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

## 5.3 Acceptance Criteria

For your contribution to be accepted, your changes must meet the 2 main criteria:

- **ShellCheck**: Ensure your code passes ShellCheck.
- **Bash 3.0 Compatibility**: Make sure your code is compatible with Bash 3.0 and above.

```console
$ shellcheck bashpass
```

Source: [Bash 3.0](https://ftp.gnu.org/gnu/bash/bash-3.0.tar.gz)

```console
$ tar -xvf bash-3.0.tar.gz
$ cd bash-3.0/
$ ./configure
$ make -j 4
```

# 6. Guide for Documentation Contributions

## 6.1 Branch model

All documentation regarding BashPass is maintained in the master branch, and pull requests should be [fork based](https://help.github.com/articles/using-pull-requests/).

## 6.2 Documentation Location

BashPass has 2 types of documentation:
- **man pages**: `docs/man/raw/`
- **GitHub wiki**: `docs/wiki/`

## 6.3 Documentation Style

To make sure that the documentation is useful and consistent, please follow these guidelines when writing and updating documentation:

- Use clear and concise language.
- Write in a style that is easy for non-technical users to understand.
- Use proper grammar and spelling.
- Provide examples wherever possible.

# 7. License

By contributing, you agree that your contributions will be licensed under the [MIT License](./LICENSE.md).
