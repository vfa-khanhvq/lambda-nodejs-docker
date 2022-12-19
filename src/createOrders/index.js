"use strict";
var axios = require("axios");

exports.handler = async (event, context, callback) => {
  context.callbackWaitsForEmptyEventLoop = false;
  // WARNING: For POST requests, body is set to null by browsers.
  var data = JSON.stringify({
    query: `query { createCreditReserve }`,
    variables: {},
  });

  var config = {
    method: "post",
    url: process.env.HOST_CREKA,
    headers: {
      "Content-Type": "application/json",
    },
    data: data,
  };

  await axios(config)
    .then(function (response) {
      console.log(response);
      return {
        statusCode: 200,
        body: response,
      };
    })
    .catch(function (error) {
      console.log(error);
    });
};
