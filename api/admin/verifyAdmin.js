const Sentry = require('@sentry/node');

function isAdmin(req, res) {
    if(req.token.user.is_admin == 'true') {
        res.send(200);
    } else {
        Sentry.captureException(new Error('Not authorized'));
        res.status(403).json({ success: false, message: 'Not authorized' });
    }
}

module.exports = {
    isAdmin,
}
