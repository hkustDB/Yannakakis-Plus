create or replace view semiJoinView1301743756918401045 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (id) from title AS t);
create or replace view semiJoinView1950283455907508697 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView1131272171201795334 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView2320333837441155627 as select v3, v25 from semiJoinView1131272171201795334 where (v3) in (select (v3) from semiJoinView1950283455907508697);
create or replace view semiJoinView5933384400794724339 as select v26, v3 from semiJoinView1301743756918401045 where (v3) in (select (v3) from semiJoinView2320333837441155627);
create or replace view semiJoinView2239629157349849717 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView5933384400794724339) and name LIKE 'Z%';
create or replace view nAux12 as select v27 from semiJoinView2239629157349849717;
select distinct v27 from nAux12;
