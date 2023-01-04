# paris_passport_check

Script that will open a browser, connect to Paris website through France Connect, and check the availabilities for passport or CNI renewal.

# prerequisites

*Ruby 3.2.0*
prefered method: rbenv

# Installation
```
git clone https://github.com/joel1di1/paris_passport_check.git
cd paris_passport_check
bundle 
```

# usage
```
$ ./check_paris.rb -i <IDENTIFIER> -p <PASSWORD> [options]
    -i, --identifier IDENTIFIER      [MANDATORY] Login Identifier (impots.gouv)
    -p, --password PASSWORD          [MANDATORY] Login password (impots.gouv)
    -h, --headless                   Run in headless mode
```
