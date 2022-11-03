SELECT
CASE 
    WHEN contract = 'F87E31492FAF9A91B02EE0DEAAD50D51D56D5D4D' THEN 'Decentraland LAND'
    WHEN contract = '50F5474724E0EE42D9A4E711CCFB275809FD6D4A' THEN 'Sandboxs LANDs'
    WHEN contract = '9D305A42A3975EE4C1C57555BED5919889DCE63F' THEN 'Sandboxs LANDs'
    WHEN contract = '5CC5B05A8A13E3FBDB0BB9FCCD98D38E50F90C38' THEN 'Sandboxs LANDs'
    WHEN contract = 'E09B54F242D41018CBC456050867292BE9295C28' THEN 'Sandboxs LANDs'
    WHEN contract = '34D85C9CDEB23FA97CB08333B511AC86E1C4E258' THEN 'Otherdeed'
END AS contract, date, transactions
FROM (SELECT [signed_at:aggregation] AS date, uniq(tx_hash) AS transactions, hex(tx_recipient) AS contract
FROM blockchains.all_chains
WHERE [chain_name:chainname]
AND (tx_recipient = unhex('F87E31492Faf9A91B02Ee0dEAAd50d51d56D5d4d') -- decentraland
  OR tx_recipient = unhex('50F5474724E0EE42D9A4E711CCFB275809FD6D4A') -- sandbox
  OR tx_recipient = unhex('9D305A42A3975EE4C1C57555BED5919889DCE63F') -- sandbox
  OR tx_recipient = unhex('5CC5B05a8A13E3fBDB0BB9FcCd98D38e50F90c38') -- sandbox
  OR tx_recipient = unhex('E09B54F242D41018CBC456050867292BE9295C28') -- sandbox
  OR tx_recipient = unhex('34d85c9CDeB23FA97cb08333b511ac86E1C4E258')) -- otherdeep
AND [signed_at:daterange]
AND successful = 1
GROUP BY date, contract)