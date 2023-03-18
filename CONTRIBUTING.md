# Contributing to BashPass

Your contributions are always welcome, whether it's:

-   Reporting a bug
-   Discussing the current state of the code
-   Submitting a fix
-   Proposing new features
-   Documentation

## Bug reports using Github's [issues](https://github.com/TuX-sudo/BashPass/issues)

If you come across a bug, feel free to report it by opening a new [issue](https://github.com/TuX-sudo/BashPass/issues), and selecting the `Bug report` template.

### Write bug reports with detail, background, and sample code

When you decide to open an issue, please use the appropriate template provided.

**Great Bug Reports** tend to have:

-   A quick summary and/or background
-   Steps to reproduce
-   Be specific!
-   Give sample code if you can. Includes sample code that _anyone_ with a base Bash knowledge can understand and run.
-   What you expected would happen
-   What actually happens
-   The version of the software
-   Notes (possibly including why you think this might be happening, or stuff you tried that didn't work)

## Feature requests using Github's [issues](https://github.com/TuX-sudo/BashPass/issues)

We are always open for new feature that could be added, feel free to suggest them by opening a new [issue](https://github.com/TuX-sudo/BashPass/issues), and selecting the `Feature request` template.

## Code and Documentation Changes

If you're interested in contributing to BashPass, we welcome both code and documentation changes.
Here is what you need to know:

### Code Changes

Pull requests are the best way to propose changes to the codebase.
To submit a code change, follow these steps:

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request.

#### Use a Consistent Coding Style

To ensure consistency and readability of the codebase, please follow these guidelines when contributing to BashPass:

##### Indentation

-   Tabs are 4 spaces long.

##### Naming Conventions

-   Use descriptive variable names that convey the purpose of the variable.
-   Use CamelCase for variable names, starting with a lowercase letter.

```bash
thisIsAVariable="random variable"
```

-   Use PascalCase for function and class names, starting with an uppercase letter.

```bash
ThisIsAFunction() {}
```

-   Loops and conditionals should use the `(( ))` and `[[ ]]` syntax (where possible).

```bash
if [[ -z "${var}" ]]; then
    prinf 'Empty variable'
fi

for ((i=0; i -lt 5; i++)); do
    printf '%s' "${i}"
done
```

##### Comments

-   Write comments to explain the purpose and functionality of the code, particularly for complex or non-obvious sections.
-   Use inline comments sparingly, and only when necessary to clarify the code.

##### Formatting

-   Use consistent formatting throughout the codebase.
-   Use a linter, such as `shellcheck`, to automatically detect and fix formatting issues.

### Documentation Changes

We welcome all types of documentation changes, including updates to the Wiki and Man Pages.
Our wiki are located under the `.github/WIKI/` directory, for man pages checkout `docs/raw/`.
To submit a documentation change, follow these steps:

1. Fork the Project
2. Create your Documentation Branch (`git checkout -b documentation/AmazingChange`)
3. Commit your Changes (`git commit -m 'Add some AmazingChange'`)
4. Push to the Branch (`git push origin documentation/AmazingChange`)
5. Open a Pull Request.

#### Writing clear and consistent documentation

To make sure that the documentation is useful and consistent, please follow these guidelines when writing and updating documentation:

-   Use clear and concise language.
-   Write in a style that is easy for non-technical users to understand.
-   Use proper grammar and spelling.
-   Provide examples wherever possible.

### Creating a Pull Request

When creating a pull request, please ensure that your changes are well-documented and that they are thoroughly tested.
We've provided a template you can fill out, and you'll be good to go.

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](./LICENSE.md).
