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

## `ls` command

`ls` -> files and dirs

Flags:
    - `-a` - all, including .files, .dirs
    - `-l` - list, detailed list view

### `ls` aliases

`lla` -> `ls -la`
`la` -> `ls -a`
`ll` -> `ls -l`

### `ls.` derivatives

`ls.` .files, .dirs
`ll.` -> only .files and .dirs

### file/dir only derivatives

- including all 

`fls` - files only
`dls` - dirs only
