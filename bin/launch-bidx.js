#!/usr/bin/env node

import '@jxa/global-type'
import { run } from '@jxa/run'
import Jimp from 'jimp'
import robot from 'robotjs'
import { resolve } from 'path'

console.log(`Processing from ${ process.cwd() }`)

const tuplefy = (promise) => promise
  .then(data => [ null, data ])
  .catch(error => [ error, null ])

const makePromise = () => {
  let trigger
  let cancel

  const promise = new Promise((resolve, reject) => {
    [ trigger, cancel ] = [ resolve, reject ]
  })

  return [ promise, trigger, cancel ]
}

const makePromiseCallback = () => {
  const [ promise, trigger, cancel ] = makePromise()

  const callback = (error, data) => {
    if (error) {
      console.error(`Canceling with error: ${ error }`)
      cancel(error)
    }

    console.log(`Resoving with ${ data }`)
    
    trigger(data)
  }

  return [ promise, callback ]
}

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
        [ 'cd ~/repos/bidx-ui', 'docker-compose up' ],
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

function logErrorAndExit (error) {
  console.error(error)
  process.exit()
}

init().catch(logErrorAndExit)



async function processImage ({ height, image: picture, width }) {
  const image = new Jimp(width, height)

  let position = 0 // First byte

  image.scan(0, 0, image.bitmap.width, image.bitmap.height, (x, y, index) => {
    image.bitmap.data[index + 2] = picture.readUInt8(position++)
    image.bitmap.data[index + 1] = picture.readUInt8(position++)
    image.bitmap.data[index + 0] = picture.readUInt8(position++)
    image.bitmap.data[index + 3] = picture.readUInt8(position++)
  })

  return image
}

const lab = async () => {
  const rawImage = robot.screen.capture()
  const jimpImage = await processImage(rawImage)

  const [ futureFileWritten, futureFileWrittenCallback ] = makePromiseCallback()
  
  const filePath = `./Screenshot-${ Date.now() }`
  await jimpImage.write(filePath, futureFileWrittenCallback)
  await futureFileWritten
  console.log(`Screenshot saved to ${ filePath }`)
}

// lab().catch(logErrorAndExit)
