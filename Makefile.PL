use ExtUtils::MakeMaker '6.31';
use File::Copy;

if ( $^O =~ /cygwin|MSWin32/ ) {
    copy 'xs/VersionInfo.xs' => 'VersionInfo.xs';
}

WriteMakefile(
    'NAME'         => 'Win32::File::VersionInfo',
    'VERSION_FROM' => 'VersionInfo.pm',
    'PREREQ_PM'    => {
        strict   => 0,
        warnings => 0,
        Carp     => 0,
        perl     => 5.6.0,
    },
    'BUILD_REQUIRES' => { 'ExtUtils::MakeMaker' => 6.31, },
    'ABSTRACT_FROM'  => 'VersionInfo.pm',
    'AUTHOR'         => 'Alexey Toptygin <alexeyt@cpan.org>',
    (   $^O eq 'cygwin'
        ? ( 'MYEXTLIB' => "/usr/lib/w32api/libversion.a" )
        : ()
    ),
    'DEFINE' => '',
    'INC'    => '',
);
