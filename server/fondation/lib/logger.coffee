path = require('path')
winston = require('winston')

module.exports = new (winston.Logger)({
    transports: [
        new (winston.transports.Console)(),
        new (winston.transports.File)({
            name:'erreurs-log',
            filename: path.resolve(process.cwd(), './dist/logs/error.log'),
            json: true,
            level: 'error'
        }),
        new (winston.transports.File)({
            name:'avertissements-log',
            filename: path.resolve(process.cwd(), './dist/logs/warn.log'),
            json: true,
            level: 'warn'
        }),
        new (winston.transports.File)({
            name:'infos-log',
            filename: path.resolve(process.cwd(), './dist/logs/info.log'),
            json: true,
            level: 'info'
        })
    ]
});