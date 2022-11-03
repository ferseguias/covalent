WITH active_addresses AS (
SELECT signed_at, tx_sender AS address, tx_recipient
FROM blockchains.all_chains 
WHERE [chain_name:chainname]
AND (tx_recipient = unhex('F87E31492Faf9A91B02Ee0dEAAd50d51d56D5d4d') -- decentraland
  OR tx_recipient = unhex('5CC5B05a8A13E3fBDB0BB9FcCd98D38e50F90c38') -- sandbox
  OR tx_recipient = unhex('34d85c9CDeB23FA97cb08333b511ac86E1C4E258')) -- otherdeep
UNION ALL 
SELECT signed_at, tx_recipient AS address, tx_recipient
FROM blockchains.all_chains 
WHERE [chain_name:chainname]
AND (tx_recipient = unhex('F87E31492Faf9A91B02Ee0dEAAd50d51d56D5d4d') -- decentraland
  OR tx_recipient = unhex('5CC5B05a8A13E3fBDB0BB9FcCd98D38e50F90c38') -- sandbox
  OR tx_recipient = unhex('34d85c9CDeB23FA97cb08333b511ac86E1C4E258')) -- otherdeep
)
  
SELECT CASE 
    WHEN contract = 'F87E31492FAF9A91B02EE0DEAAD50D51D56D5D4D' THEN 'Decentraland LAND'
    WHEN contract = '5CC5B05A8A13E3FBDB0BB9FCCD98D38E50F90C38' THEN 'Sandboxs LANDs'
    WHEN contract = '34D85C9CDEB23FA97CB08333B511AC86E1C4E258' THEN 'Otherdeed'
END AS contract, date, uniq(address)
FROM (
    SELECT min([signed_at:aggregation]) AS date, address, hex(tx_recipient) AS contract
    FROM active_addresses 
    GROUP BY address, contract
)   
WHERE [date:daterange]
GROUP BY date, contract
ORDER BY date desc
