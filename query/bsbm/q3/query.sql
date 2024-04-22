SELECT p.nr, p.label
FROM product p, producttypeproduct ptp, productfeatureproduct pfp
WHERE p.nr=ptp.product AND pfp.product=p.nr