%bcond_without tex
%bcond_without patches

Name: mmix
Version: 20131017
Release: 4
Packager: Andreas Scherer <andreas@komputer.de>
Summary: The MMIX system
License: Copyright 1999 Donald E. Knuth
URL: http://mmix.cs.hm.edu/

Group: Productivity/Development
Distribution: Kubuntu 12.04 (i386)
BuildRoot: %{_tmppath}/%{name}-%{version}-root
BuildArch: i386
#BuildRequires:

Source0: http://mmix.cs.hm.edu/src/%{name}-%{version}.tgz
Source1: mmix-sim.ch
Source2: mmix-pipe.ch
Source3: mmixal.ch
Source4: mmix-arith.ch
Source5: mmix-config.ch
Source6: mmix-io.ch
%if %{with patches}
Patch1: 0001-Fix-intermediate-bugs.patch
Patch4: 0004-Fix-intermediate-bugs.patch
Patch5: 0005-Fix-another-bug.patch
Patch6: 0006-Update-information-about-documentation.patch
Patch10: 0010-Fix-another-compiler-warning.patch
%endif

%description
Here is MMIX, a 64-bit computer that will totally replace MIX in the
'ultimate' editions of 'The Art of Computer Programming' by Don Knuth.

%prep
%autosetup -c %{!?with_patches:-N}
%{perl:for (1..6) { print "%{__cp} -a %{SOURCE$_} .\n" }}
%{?with_patches:%{__sed} "s/CFLAGS = -g/CFLAGS = -g -W -Wall/" -i Makefile}

%build
%{__make} all mmotype mmmix
%if %{with tex}
%{__make} doc
%{perl:for (qw(al-intro -doc -sim-intro)) { print "%{__ps2pdf} mmix$_.ps\n" }}
%endif

%install
%{__rm} -rf %{buildroot}
%{__mkdir_p} %{buildroot}%{_bindir}
%{__cp} mmix mmixal mmotype mmmix %{buildroot}%{_bindir}
%{__mkdir_p} %{buildroot}%{_datadir}/%{name}
%{__cp} *.mms *.mmconfig *.mmix %{buildroot}%{_datadir}/%{name}
%if %{with tex}
%{__mkdir_p} %{buildroot}%{_docdir}/%{name}
%{__cp} *.pdf %{buildroot}%{_docdir}/%{name}
%endif

%clean

%files
%defattr(644,root,root,755)
%{perl:for (qw(mmix mmixal mmotype mmmix)) { print "%attr(755,root,root) %{_bindir}/$_\n" }}
%{_datadir}/%{name}
%{?with_tex:%doc %{_docdir}/%{name}}

%post

%postun

%changelog
* Thu Nov 26 2015 Andreas Scherer <andreas_tex@freenet.de>
- Conditional Build Stuff

* Thu Oct 29 2015 Andreas Scherer <andreas_tex@freenet.de>
- Fully parametrized specfile

* Fri Sep 11 2015 Andreas Scherer <andreas_tex@freenet.de>
- Do not install the utility program 'abstime'

* Wed Sep 02 2015 Andreas Scherer <andreas_tex@freenet.de>
- Build from latest release plus intermediate fixes

* Sat Aug 15 2015 Andreas Scherer <andreas_tex@freenet.de>
- Provide consistent information in URL and Source0

* Mon Jul 06 2015 Andreas Scherer <andreas_tex@freenet.de>
- Update mmix.spec by using %setup more properly

* Mon Oct 07 2013 Andreas Scherer <andreas_tex@freenet.de>
- Update for 10/2013 source drop

* Thu Sep 26 2013 Andreas Scherer <andreas_tex@freenet.de>
- Update for 09/2013 source drop

* Wed Nov 30 2011 Andreas Scherer <andreas_tex@freenet.de>
- Eliminate all GCC warnings

* Tue Sep 13 2011 Andreas Scherer <andreas_tex@freenet.de>
- Correct Copyright line (1993 was CWEB, not MMIX)

* Mon Sep 05 2011 Andreas Scherer <andreas_tex@freenet.de>
- Correct URL for source package

* Thu Sep 01 2011 Andreas Scherer <andreas_tex@freenet.de>
- Update for 08/2011 source drop

* Thu Aug 18 2011 Andreas Scherer <andreas_tex@freenet.de>
- Eliminate some GCC warnings

* Mon Aug 01 2011 Andreas Scherer <andreas_tex@freenet.de>
- dpkg complains about missing maintainer

* Sat Jul 23 2011 Andreas Scherer <andreas_tex@freenet.de>
- Update for 07/2011 source drop

* Wed Jun 08 2011 Andreas Scherer <andreas_tex@freenet.de>
- Update for 06/2011 source drop

* Sat May 28 2011 Andreas Scherer <andreas_tex@freenet.de>
- Update for 04/2011 source drop

* Wed Jan 19 2011 Andreas Scherer <andreas_tex@freenet.de>
- Update for 03/2010 source drop

* Sun Feb 28 2010 Andreas Scherer <andreas_tex@freenet.de>
- Update for 01/2010 source drop

* Tue May 05 2009 Andreas Scherer <andreas_tex@freenet.de>
- Update for 03/2009 source drop

* Fri May 02 2008 Andreas Scherer <andreas_tug@freenet.de>
- Create a Debian-compatible package using 'debbuild'

* Wed Sep 12 2007 Andreas Scherer <andreas_tug@freenet.de>
- Create the meta-mmix simulator

* Wed Sep 12 2007 Andreas Scherer <andreas_tug@freenet.de>
- Rely on teTeX's ctangle processor

* Sat Sep 30 2006 Andreas Scherer <andreas_tug@freenet.de>
- Update for 09/2006 source drop

* Fri Jun 09 2006 Andreas Scherer <andreas_tug@freenet.de>
- Update for 03/2006 source drop

* Fri Nov 04 2005 Andreas Scherer <andreas_tug@freenet.de>
- Initial build
