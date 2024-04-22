SELECT r.title, r.text, r.reviewDate, p.nr, p.name, r.rating1, r.rating2, r.rating3, r.rating4
FROM review r, person p
WHERE r.person=p.nr