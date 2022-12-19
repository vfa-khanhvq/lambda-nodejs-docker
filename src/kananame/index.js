"use strict";
const fs = require("fs");

exports.handler = async (event, context, callback) => {
  context.callbackWaitsForEmptyEventLoop = false;
  const obj = JSON.parse(fs.readFileSync("./data.json", "utf8"));
  const header = event?.headers?.Authorization;
  if (!header) {
    return {
      statusCode: 401,
      headers: {
        "Access-Control-Allow-Origin": "*",
      },
      body: JSON.stringify({
        message: "Token Invalid",
      })
    };
  }

  let token = header.split(" ")[1]
  token = token.slice(4, token.length - 1);

  if (!obj[token]) {
    return {
      statusCode: 400,
      headers: {
        "Access-Control-Allow-Origin": "*",
      },
      body: JSON.stringify({
        message: "No matching kaname",
      })
    };
  }

  return {
    statusCode: 200,
    headers: {
      "Access-Control-Allow-Origin": "*",
    },
    body: JSON.stringify(obj[token]),
  };
};
