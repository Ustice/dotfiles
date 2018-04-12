const {
  email,
  citrixUser,
  password,
  citrixUrl,
  emailUrl,
} = require('./.otsuka-credentials.json');

const Nightmare = require('nightmare');

const createConnection = (options) => {
  const defaultConfig = {
    show: process.argv.includes('--debug'),
  };

  const config = Object.assign({}, defaultConfig, options);

  return Nightmare(config);
};

const emailLogin = () => {
  return createConnection({
    waitTimeout: 180000,
  })
    .goto(emailUrl)
    .type('input[type="email"]', email)
    .click('input[type="submit"]')
    .wait('#header')
    .type('input#passwordInput', password)
    .click('span#submitButton')
    .wait('#idSIButton9')
    .click('#idSIButton9')
    .wait('#O365_NavHeader')
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

