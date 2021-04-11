#!/usr/bin/env node

import Jimp from 'jimp'
import robot from 'robotjs'
import { resolve } from 'path'

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
      return cancel(error)
    }
    
    return trigger(data)
  }

  return [ promise, callback ]
}

function logErrorAndExit (error) {
  console.error(error)
  process.exit()
}

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
  
  const filePath = resolve(`./Screenshot-${ Date.now() }.png`)
  await jimpImage.write(filePath, futureFileWrittenCallback)
  await futureFileWritten
}

lab().catch(logErrorAndExit)
