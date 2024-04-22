SELECT nr, label
FROM product p, producttypeproduct ptp, productfeatureproduct pfp1, productfeatureproduct pfp2
WHERE p.nr = ptp.product
	AND p.nr = pfp1.product
	AND p.nr = pfp2.product