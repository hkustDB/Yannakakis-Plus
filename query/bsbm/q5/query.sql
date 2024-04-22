SELECT p.nr, p.label
FROM product p, productfeatureproduct pfp1, productfeatureproduct pfp2
WHERE pfp2.productFeature=pfp1.productFeature AND p.nr=pfp1.product