'use strict';

exports.handler = async (event, context, callback) => {
  context.callbackWaitsForEmptyEventLoop = false;
  const req = JSON.parse(event.body);

  if (!req?.refresh_token) {
    return {
      statusCode: 401,
      headers: {
        'Access-Control-Allow-Origin': '*',
      },
      body: JSON.stringify({
        message: 'Token Invalid',
      }),
    };
  }

  return {
    statusCode: 200,
    headers: {
      'Access-Control-Allow-Origin': '*',
    },
    body: JSON.stringify({
      access_token: req.refresh_token,
      refresh_token: req.refresh_token,
      // Return now timestamp
      expires_in: +new Date(),
    }),
  };
};
