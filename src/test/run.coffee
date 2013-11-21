fs = require 'fs'
{ join }   = require 'path'

tests = []
failures = []

addTest = (name, func) -> tests.push  { name, func }

stripExt = (name) -> name.split('.')[0]

nameFromFile = (f) -> 
  name = stripExt f
  if name.indexOf('test') is 0
    name.substring 4
  else
    name

loadTests = (path) ->
  files = fs.readdirSync path
  for f in files
    continue if f.indexOf('test') isnt 0
    try
      e = require stripExt join path, f
    catch err
      console.log "Requiring of #{f} failed. Error: #{err}"
      continue

    mainName = nameFromFile f 
    if typeof e is 'function'
      addTest mainName, e
    else if typeof e is 'object'
      for name, func of e
        addTest "#{mainName} - #{nameFromFile(name)}", func
    else
      console.log "Test file #{f} exported invalid value."


failure = (name, err) -> failures.push { name, err }

run = (name, f) ->
  try
    console.log "Running #{name}"
    f()
  catch error
    failure name, error


runTests = () ->
  if tests.length > 0
    for test in tests
      run test.name, test.func
  else
    console.log 'No tests found.'

main = (path) ->
  loadTests path
  runTests()
  if failures.length > 0
    console.log "Failure (#{failures.length} out of #{tests.length})"
    for f in failures
      console.log "#{f.name}: #{f.err}"
  else if tests.length > 0
    console.log 'Success'

main __dirname
