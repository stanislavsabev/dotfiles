# CMD / BATCH SCRIPT

## Script file variables

Place between the `%~` and the `0`. Take your pick from

    d - drive
    p - path
    n - file name
    x - extension
    f - full path

E.g., from inside c:\tmp\foo.bat, `%~nx0` gives you `"foo.bat"`,whilst `%~dpnx0` gives `"c:\tmp\foo.bat"`.

## Accessing arguments without shift

```cmd
setlocal enableDelayedExpansion
set /a counter=0
for /l %%x in (1, 1, 9) do (
 set /a counter=!counter!+1
 call echo %%!counter!
)
endlocal
```

## Make a file hidden

```cmd
attrib +h <filename>
```

## Show files starting with "`.`"

```cmd
dir .*.* /s /a-D
```

## ls command

? `l` -> files

`ls` -> files and dirs
`la` = `ls -a` -> as `ls` + .files and .dirs
`lla` = `ls -l -a`

? `l.` -> only .files

`ls.` -> only .files and .dirs
