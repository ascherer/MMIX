%bcond_without tex
%bcond_without patches
%bcond_without changes
%bcond_with debuginfo

# Plain vanilla MMIX
%{!?with_changes:%global with_patches 0}

Name: mmix
Summary: The MMIX system
License: Copyright 1999 Donald E. Knuth
URL: http://mmix.cs.hm.edu/

Version: 20231125
Release: 1
Packager: Andreas Scherer <https://ascherer.github.io/>

%if "%{_vendor}" == "debbuild"
Group: science
Distribution: Kubuntu 22.04 (x86_64)
%if %{with tex}
BuildRequires: texlive
%endif
%else
Group: Productivity/Scientific/Electronics
Distribution: openSUSE 42 (x86_64)
%global __echo %(which echo)
%global __ps2pdf %(which ps2pdf)
%endif
%global __sed_i %{__sed} -i
BuildRoot: %{_tmppath}/%{name}-%{version}-root

Source0: https://www-cs-faculty.stanford.edu/~knuth/programs/%{name}-%{version}.tar.gz
%if %{with changes}
Source1: mmix-arith.ch
Source2: mmix-config.ch
Source3: mmix-io.ch
Source4: mmix-pipe.ch
Source5: mmix-sim.ch
Source6: mmixal.ch
Source7: mmmix.ch
Source8: mmotype.ch
%endif

%if %{with patches}
Patch0029: 0029-DRY-up-the-Makefile.patch
Patch0101: 0101-Adjust-Makefile-to-new-header-files.patch
Patch0109: 0109-Avoid-redundant-date-values.patch
Patch0199: 0199-Link-mmotype-with-mmix-arith-in-Makefile.patch
Patch0204: 0204-Clean-up-Makefile.patch
Patch0272: 0272-Resurrect-the-shared-object-idea.patch
Patch0396: 0396-Directly-compile-from-C-main-module-to-executable.patch
%endif

%description
Here is MMIX, a 64-bit computer that will totally replace MIX in the
'ultimate' editions of 'The Art of Computer Programming' by Don Knuth.

%prep
%autosetup -c
%if %{with changes}
for f in %sources; do
  case $f in *.ch) %{__cp} $f . ;; esac
done
%if %{with patches}
%{__sed_i} -e "s/CFLAGS = -g/& -Wall -Wextra -Wno-implicit-fallthrough/" Makefile
%else
%{__sed_i} -e "s/@d ABSTIME/& 123456789/" mmix-pipe.ch mmix-sim.ch
%endif
%endif
%if ! %{with debuginfo}
%{__sed_i} -e "/CFLAGS = /s/-g/-O/" Makefile
%{?with_patches:%{__sed_i} -e "s/LDFLAGS =/& -s/" Makefile}
%endif

%build
%{__make} all
%if %{with tex}
%{__make} doc
for i in al-intro -doc -sim-intro; do %{__ps2pdf} mmix$i.ps; done
%endif

%check
PATH=.:$PATH %{__make} copy.mmo
./mmix copy copy.mms > copy.out
diff -u copy.mms copy.out

for f in hello silly; do
  PATH=.:$PATH %{__make} $f.mmo $f.mmb
  printf "10000\nq" | ./mmmix plain.mmconfig $f.mmb
done

grep "Warning" silly.out > silly.err
%{__sed_i} -e "/Warning/d" silly.out

echo "i silly.run" | ./mmix -i silly > silly.out.new 2>silly.err.new
for f in out err; do diff -u silly.$f silly.$f.new ||:; done

%install
%{__rm} -rf %{buildroot}
%{__install} -d %{buildroot}%{_bindir} \
	%{buildroot}%{_datadir}/%{name}
%{?with_tex:%{__install} -d %{buildroot}%{_docdir}/%{name}}
%{__install} mmix mmixal mmotype mmmix %{buildroot}%{_bindir}
%{__install} -m 644 *.mms *.mmconfig *.mmix %{buildroot}%{_datadir}/%{name}
%{?with_tex:%{__install} -m 644 *.pdf %{buildroot}%{_docdir}/%{name}}

%files
%defattr(-,root,root,-)
%{_bindir}/mmix
%{_bindir}/mmixal
%{_bindir}/mmotype
%{_bindir}/mmmix
%{_datadir}/%{name}
%{?with_tex:%doc %{_docdir}/%{name}}

%changelog
* Thu Nov 30 2023 Andreas Scherer <andreas_tex@freenet.de>
- Fourth patch for Makefile

* Wed Nov 29 2023 Andreas Scherer <andreas_tex@freenet.de>
- Update from DEK

* Sat Apr 15 2023 Andreas Scherer <andreas_tex@freenet.de>
- Second patch for Makefile

* Wed Feb 14 2023 Andreas Scherer <andreas_tex@freenet.de>
- Update from DEK

* Mon Apr 05 2021 Andreas Scherer <andreas_tex@freenet.de>
- Adapt to main sources from MMIX Home

* Thu Jan 11 2018 Andreas Scherer <andreas_tex@freenet.de>
- Un-build shared library

* Sat Jan 07 2017 Andreas Scherer <andreas_tex@freenet.de>
- Build shared library from common modules

* Sat Dec 31 2016 Andreas Scherer <andreas_tex@freenet.de>
- Use C99 standard types

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
