create or replace view semiJoinView3695166183264395376 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView7470876879779124511 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView3695166183264395376);
create or replace view semiJoinView2508058252042813264 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView2771938783425565252 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView2508058252042813264);
create or replace view semiJoinView3088311165821536074 as select v26, v3 from semiJoinView7470876879779124511 where (v3) in (select (v3) from semiJoinView2771938783425565252);
create or replace view semiJoinView4881965673355370641 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView3088311165821536074);
create or replace view nAux9 as select v27 from semiJoinView4881965673355370641;
select distinct v27 from nAux9;
