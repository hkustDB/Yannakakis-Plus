create or replace view semiJoinView3224049051104650944 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView529702703864832741 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView7634564136427491085 as select v3, v25 from semiJoinView3224049051104650944 where (v3) in (select (v3) from semiJoinView529702703864832741);
create or replace view semiJoinView3871316753159391208 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView7634564136427491085);
create or replace view semiJoinView1942045191327912828 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView3871316753159391208);
create or replace view semiJoinView4874372109063673196 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView1942045191327912828) and name LIKE '%Bert%';
create or replace view nAux61 as select v27 from semiJoinView4874372109063673196;
select distinct v27 from nAux61;
