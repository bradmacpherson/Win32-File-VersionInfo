use Test::More;

if ( $^O =~ /cygwin|MSWin32/ ) {
    plan tests => 2;
    require_ok('Win32::File::VersionInfo');
    Win32::File::VersionInfo->import(qw/GetFileVersionInfo/);

    subtest 'Check function against well-known Windows files' => sub {
        my $windir = $ENV{WINDIR};
        my @foo    = (
            grep { -e $_ } "${windir}\\system32\\notepad.exe",
            "${windir}\\system32\\kernel32.dll",
            "${windir}\\system32\\msxbde40.dll",
            "${windir}\\system\\KEYBOARD.DRV",
            "${windir}\\system32\\winspool.drv",
            "${windir}\\system32\\vga.drv",
            "${windir}\\system32\\mouse.drv",
            "${windir}\\system32\\lanman.drv",
            "${windir}\\system32\\sound.drv",
            "${windir}\\system32\\comm.drv",
            "${windir}\\Fonts\\COURE.FON",
        );
        plan tests => scalar @foo;

        my @attrs = qw[ FileVersion ProductVersion Flags OS Type ];

        for my $file (@foo) {
            subtest "Check $file" => sub {
                plan tests => scalar @attrs + 1;
                my $bar = GetFileVersionInfo($file);
                ok( ( ref $bar ), 'Returned a data structure' );
                for my $attr (@attrs) {
                    ok( ( exists $bar->{$attr} and defined $bar->{$attr} ),
                        "$attr defined" );
                }
            };
        }
    };
}
else {
    plan tests => 1;
    my $test_name
        = 'Check Win32::File::VersionInfo throws an exception on a non-Win32 system';
    eval { require Win32::File::VersionInfo; };
    if ($@) {
        pass $test_name;
    }
    else {
        fail $test_name;
    }
}
