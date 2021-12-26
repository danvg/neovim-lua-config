if filereadable("./gradlew")
  if has("win32")
    setlocal makeprg=gradlew\ --no-daemon
  else
    setlocal makeprg=./gradlew\ --no-daemon
  endif

  setlocal path=.,src/main/java/**,src/test/java/**,**/src/main/java/**,**/src/test/java/**
  setlocal include=^\s*import
  setlocal includeexpr=substitute(v:fname,'\\.','/',g)
endif
