bsesh
#save bash session history

Inspired by https://eli.thegreenplace.net/2013/06/11/keeping-persistent-history-in-bash

## Features
- Name a session to start recording history in a special file for that shell session. 
- Each new command is written to file immediately. 
- Records date and command. 
- Can also record git branch and venv when explicitly set. 
- Add visually distinctive notes. 

To check session name:
```
$ sesh 
no session
```

To view help menu:
```
$ sesh -h
no session
start a session for recording history
seshh:                    view session history using less
namesesh <name>:          start a new session, in ~/.hist/<date>-<name>
sn <notes>:               add a note with special eye grabbing lines
setgitsesh <git branch>:  add a branch name to future lines
setvenvsesh <venv>:       add venv name to future lines
newseshdate:              start a new file, diff date same session name
endsesh:                  stop recording the session
```

Example history:
```
$ seshh
17-12-04 11:02:52 ||  ||  || namesesh mysesh
17-12-04 11:02:57 ||  ||  || sesh -h
<<#>><<#>><<#>><<#>><<#>><<#>><<#>>
<<#>><<#>><<#>><<#>><<#>><<#>><<#>> working on issue XX-1234
<<#>><<#>><<#>><<#>><<#>><<#>><<#>>
17-12-04 11:04:03 || TASK/XX-1234 ||  || setgitsesh TASK/XX-1234
17-12-04 11:04:24 || TASK/XX-1234 ||  || workon
17-12-04 11:04:38 || TASK/XX-1234 || myvenv || setvenvsesh myvenv
17-12-04 11:04:44 || TASK/XX-1234 || myvenv || which python
<<#>><<#>><<#>><<#>><<#>><<#>><<#>>
<<#>><<#>><<#>><<#>><<#>><<#>><<#>> Found issue, fixing and commiting
<<#>><<#>><<#>><<#>><<#>><<#>><<#>>
17-12-04 11:05:38 || TASK/XX-1234 || myvenv || vi ~/code/foo
17-12-04 11:06:22 || TASK/XX-1234 || myvenv || cd code
17-12-04 11:07:40 || TASK/XX-1234 || myvenv || git add foo
17-12-04 11:07:53 || TASK/XX-1234 || myvenv || git commit -m "fixed typo"
17-12-04 11:07:55 || TASK/XX-1234 || myvenv || git push
```
