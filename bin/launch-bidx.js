#!/usr/bin/env node

import '@jxa/global-type'
import { run } from '@jxa/run'
process.cwd = () => __dirname

const tuplefy = (promise) => promise
  .then(data => [ null, data ])
  .catch(error => [ error, null ])

const init = async () => {
  const state = {}

  const [ error, result ] = await tuplefy(run((state) => {
    ObjC.import('stdlib')

    // include the iTerm application to your JXA script
    const iTerm = Application('iTerm2')

    // OSX has a set of standard scripting additions available to use, // these should be included
    iTerm.includeStandardAdditions = true

    const run = (argv) => {
      const window = iTerm.currentWindow()

      const projects = [
        [ 'cd ~/repos/bidx', 'docker-compose up' ],
        [ 'cd ~/repos/bidx-graphql', 'docker-compose up' ],
        [ 'cd ~/repos/bidx-ui', 'npm run serve' ],
      ]

      const projectSession = window.currentSession()
      const terminalSession = projectSession.splitHorizontallyWithSameProfile()
      const sendText = (session) => (text) => session.write({ text, newline: true })

      projects.reduce((session, commands, index, projects) => {
        commands.forEach(sendText(session))

        return index < projects.length - 1 ? session.splitVerticallyWithSameProfile()
          : session
      }, projectSession)

      terminalSession.select()
    }

    return run()
  }, state))


  if (error) {
    console.error(error)
    return process.exit(error)
  }

  process.exit()
}

init()
