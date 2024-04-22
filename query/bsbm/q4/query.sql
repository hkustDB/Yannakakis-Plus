SELECT p.nr, p.label, p.propertyTex1
FROM product p, producttypeproduct ptp, productfeatureproduct pfp1, productfeatureproduct pfp2, productfeatureproduct pfp3
WHERE p.nr=ptp.product
	AND p.nr = pfp1.product
	AND p.nr = pfp2.product
	AND p.nr = pfp3.product