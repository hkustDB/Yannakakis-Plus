create or replace view semiUp2510660044036701575 as select person_id as v2, movie_id as v11, role_id as v15 from cast_info AS ci where (person_id) in (select id from name AS n1 where name LIKE '%Yo%' and name NOT LIKE '%Yu%') and note= '(voice: English version)';
create or replace view semiUp8725082114114629566 as select v2, v11, v15 from semiUp2510660044036701575 where (v2) in (select person_id from aka_name AS an1);
create or replace view semiUp640365096744216025 as select movie_id as v11, company_id as v25 from movie_companies AS mc where (company_id) in (select id from company_name AS cn where country_code= '[jp]') and note NOT LIKE '%(USA)%' and note LIKE '%(Japan)%';
create or replace view semiUp7841640908801863557 as select v2, v11, v15 from semiUp8725082114114629566 where (v15) in (select id from role_type AS rt where role= 'actress');
create or replace view semiUp7382773140742414041 as select id as v11, title as v40 from title AS t where (id) in (select v11 from semiUp640365096744216025);
create or replace view semiUp5746120544981880411 as select v11, v40 from semiUp7382773140742414041 where (v11) in (select v11 from semiUp7841640908801863557);
create or replace view semiDown9124509909952516469 as select v11, v25 from semiUp640365096744216025 where (v11) in (select v11 from semiUp5746120544981880411);
create or replace view semiDown6037569400106857279 as select v2, v11, v15 from semiUp7841640908801863557 where (v11) in (select v11 from semiUp5746120544981880411);
create or replace view semiDown7395191205712718329 as select id as v25 from company_name AS cn where (id) in (select v25 from semiDown9124509909952516469) and country_code= '[jp]';
create or replace view semiDown8063561744741385516 as select id as v15 from role_type AS rt where (id) in (select v15 from semiDown6037569400106857279) and role= 'actress';
create or replace view semiDown8634069801871811260 as select id as v2 from name AS n1 where (id) in (select v2 from semiDown6037569400106857279) and name LIKE '%Yo%' and name NOT LIKE '%Yu%';
create or replace view semiDown2343132317509714419 as select person_id as v2, name as v3 from aka_name AS an1 where (person_id) in (select v2 from semiDown6037569400106857279);
create or replace view aggView5799301352775217440 as select v15 from semiDown8063561744741385516;
create or replace view aggJoin6613152947229136684 as select v2, v11 from semiDown6037569400106857279 join aggView5799301352775217440 using(v15);
create or replace view aggView4893015556684630428 as select v2, MIN(v3) as v51 from semiDown2343132317509714419 group by v2;
create or replace view aggJoin8243198699944926735 as select v2, v11, v51 from aggJoin6613152947229136684 join aggView4893015556684630428 using(v2);
create or replace view aggView762022797632797585 as select v2 from semiDown8634069801871811260;
create or replace view aggJoin7684545204712359349 as select v11, v51 from aggJoin8243198699944926735 join aggView762022797632797585 using(v2);
create or replace view aggView8719300952896630004 as select v25 from semiDown7395191205712718329;
create or replace view aggJoin1599978481662197692 as select v11 from semiDown9124509909952516469 join aggView8719300952896630004 using(v25);
create or replace view aggView8185958505010121492 as select v11, MIN(v51) as v51 from aggJoin7684545204712359349 group by v11,v51;
create or replace view aggJoin7531096251361547476 as select v11, v40, v51 from semiUp5746120544981880411 join aggView8185958505010121492 using(v11);
create or replace view aggView6109855541408269195 as select v11 from aggJoin1599978481662197692 group by v11;
create or replace view aggJoin3309297031981449702 as select v40, v51 as v51 from aggJoin7531096251361547476 join aggView6109855541408269195 using(v11);
select MIN(v51) as v51, MIN(v40) as v52 from aggJoin3309297031981449702;

