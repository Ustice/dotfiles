const {
  email,
  citrixUser,
  password,
  citrixUrl,
  emailUrl,
} = require('./.otsuka-credentials.json');

const Nightmare = require('nightmare');

const createConnection = () => Nightmare({
  show: process.argv.includes('--debug'),
});

const emailLogin = () => {
  return createConnection()
    .goto(emailUrl)
    .type('input[type="email"]', email)
    .click('input[type="submit"]')
    .wait('#header')
    .type('input#passwordInput', password)
    .click('span#submitButton')
    .wait('#displayName')
    .click('input#KmsiCheckboxField')
    .click('input[type="submit"]')
    .end()
    .then(result => console.log('Successfully logged into Otsuka email.'))
    .catch(error => console.error('Error logging into Otsuka email.', error))
  ;
}

const citrixLogin = () => {
  return createConnection()
    .goto(citrixUrl)
    .type('input[name="login"]', citrixUser)
    .type('input#passwd', password)
    .click('input#Log_On')
    .end()
    .then(result => console.log('Successfully logged into Otsuka Citrix system.'))
    .catch(error => console.error('Error logging into Otsuka Citrix.', error))
  ;
}

Promise.all([emailLogin(), citrixLogin()])
  .then(function (result) {
    console.log('Otsuka logins complete.');
  })
  .catch(function (error) {
    console.error('Error - ', error);
  })
;

