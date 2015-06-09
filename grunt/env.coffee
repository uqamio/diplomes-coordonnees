###**
 * Permets d'enregistrer des variables d'environnement utilisées lors de l'exécution.
 * Voir [grunt-env]{@link https://www.npmjs.com/package/grunt-env}
 * @module grunt/env
###
module.exports =
  dev:
    NODE_ENV: 'development',
    PORT: 2015,
    REPERTOIRE_PUBLIC: './public',
    PROJET_USAGER_CALLBACK_URL: 'http://fondation-uqam.dahriel.io/authentification',
    SAMLISE: false,
    EMETTEUR: 'http://fondation-uqam.dahriel.io',
    NLS_LANG: '.UTF8',
    DB_USER_NAME: 'WWW_FOND_MAJ_COORD',
    DB_PASSWORD: 'WWW_FMC'
