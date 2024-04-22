Name:           bashpass
Version:        RELEASE_VERSION
Release:        1
BuildArch:      noarch
Summary:        A command-line based password manager written in Bash.

License:        MIT
URL:            https://github.com/AntonVanAssche/BashPass
Source0:        https://github.com/AntonVanAssche/BashPass/archive/refs/tags/%{name}-%{version}.tar.gz

Requires:       bash gnupg2

%description
BashPass is a command-line based password manager written in Bash.
It uses GPG to encrypt/decrypt the files where the passwords are stored .
This means the passwords are 100% stored locally, so you don't have to trust a third party to store your passwords.

%prep
%autosetup

%install
rm -rf %{buildroot}

%{__mkdir_p} %{buildroot}%{_bindir}
%{__mkdir_p} %{buildroot}%{_mandir}/man1
%{__mkdir_p} %{buildroot}%{_datadir}/bash-completion/completions
%{__install} -m 0755 %{name} %{buildroot}%{_bindir}/%{name}
%{__install} -m 0644 docs/man/%{name}.1.gz %{buildroot}%{_mandir}/man1/%{name}.1.gz
%{__install} -m 0644 docs/man/%{name}.conf.1.gz %{buildroot}%{_mandir}/man1/%{name}.conf.1.gz
%{__install} -m 0644 scripts/%{name}-completion.sh %{buildroot}%{_datadir}/bash-completion/completions/%{name}

%clean
rm -rf %{buildroot}

%files
%{_bindir}/%{name}
%{_datadir}/bash-completion/completions/%{name}

%doc
%{_mandir}/man1/%{name}.1.gz
%{_mandir}/man1/%{name}.conf.1.gz

%license LICENSE.md

%changelog
%autochangelog
