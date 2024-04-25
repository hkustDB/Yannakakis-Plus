create or replace view semiJoinView8803448964030197108 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView991308128456104059 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView4260588709398174444 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView8803448964030197108);
create or replace view semiJoinView7440598091763430293 as select v3, v25 from semiJoinView991308128456104059 where (v3) in (select (v3) from semiJoinView4260588709398174444);
create or replace view semiJoinView1380798384210095576 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView7440598091763430293);
create or replace view semiJoinView4848249040623734490 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView1380798384210095576) and name LIKE 'X%';
create or replace view nAux50 as select v27 from semiJoinView4848249040623734490;
select distinct v27 from nAux50;
