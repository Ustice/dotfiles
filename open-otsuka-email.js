const Nightmare = require('nightmare');

const credentials = require('./.otsuka-credentials.json');

const getAccount = (name) => credentials.find((n) => n.name === name);

const createConnection = (options) => {
  const defaultConfig = {
    show: process.argv.includes('--debug'),
  };

  const config = {
    ...defaultConfig,
    ...options
  };

  return Nightmare(config);
};

const emailLogin = ({ url, user, password }) => createConnection({
  waitTimeout: 180000,
})
  .goto(url)
  .type('input[type="email"]', user)
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

const citrixLogin = ({ url, user, password }) => createConnection()
  .goto(url)
  .type('input[name="login"]', user)
  .type('input#passwd', password)
  .click('input#Log_On')
  .end()
  .then(result => console.log('Successfully logged into Otsuka Citrix system.'))
  .catch(error => console.error('Error logging into Otsuka Citrix.', error))
;

const eLearnLogin = ({ url, user, password }) => createConnection()
  .goto(url)
  .type('input#username', user)
  .type('input#password', password)
  .click('.ping-buttons>a.button.allow')
  .wait('#sap-ui-static')
  .evaluate(() => new Promise((resolve, reject) => {
    let noItemsElements = [];

    try {
      noItemsElements = [...document.getElementsByClassName('learnerToDoNoItems')]
        .map(window.getComputedStyle)
        .filter((n) => n.display === 'none' || n.visibility === 'invisible')
      ;
    }
    catch (error) {
      return reject(error.toString());
    }

    return resolve(
      noItemsElements.length === 0 ?
        'No eLearning items exist.' :
        'You have some eLearning to do.'
    );
  }))
  .end()
  .then(console.log)
  .catch((error) => console.error('Error checking eLearnings', error))
;

Promise.all([
  emailLogin(getAccount('email')),
  citrixLogin(getAccount('citrix')),
  eLearnLogin(getAccount('elearn')),
])
  .then((result) => console.log('Otsuka logins complete.'))
  .catch((error) => console.error('Error - ', error))
;

