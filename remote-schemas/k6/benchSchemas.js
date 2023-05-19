import http from 'k6/http'
import { check } from 'k6'

export default function () {
  let url = 'http://localhost:3003/v1/graphql',
      headers = {
        'X-Hasura-Admin-Secret': '1q2a3z4w5s6x',
        'Content-Type': 'application/json',
      },
      query = `
        query TokenWithMetadata {
          token(limit: 10000) {
            address
            decimals
            id
            name
            standard
            symbol
            thumbnail_uri
            token_id
            token_metadata {
              contract
              error
              id
              image_processed
              link
              metadata
              network
              retry_count
              status
              token_id
            }
          }
        }`;

  const res = http.post(
    url,
    JSON.stringify({ query: query }),
    {
      headers: headers,
    }
  );

  // Run assertions on status, errors in body
  let check_cxt = { 'is status 200': (r) => r.status === 200, }
  if (res.body) { // unavailable if discardResponseBodies: true
    check_cxt['no error in body'] = (r) => Boolean(r.json('errors')) == false
  }

  console.log(res)
  check(res, check_cxt)
}
