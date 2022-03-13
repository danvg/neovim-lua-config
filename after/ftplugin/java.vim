if filereadable("build.xml")
  setl makeprg=ant
  setl path=.,src/**,**/src/**
elseif filereadable("./gradlew")
  setl makeprg=./gradlew\ --no-daemon
  setl path=.,src/main/java/**,src/test/java/**,**/src/main/java/**,**/src/test/java/**
endif

setl include=^\s*import
setl includeexpr=substitute(v:fname,'\\.','/',g)
