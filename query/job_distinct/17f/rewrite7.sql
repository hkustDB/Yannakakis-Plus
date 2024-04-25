create or replace view semiJoinView4021138124022365067 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView2975616859008171926 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView352249798124421357 as select v3, v20 from semiJoinView4021138124022365067 where (v3) in (select (id) from title AS t);
create or replace view semiJoinView3182477884918977097 as select v3, v25 from semiJoinView2975616859008171926 where (v3) in (select (v3) from semiJoinView352249798124421357);
create or replace view semiJoinView6927708089836032518 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView3182477884918977097);
create or replace view semiJoinView1730491344797492717 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView6927708089836032518);
create or replace view nAux92 as select v27 from semiJoinView1730491344797492717;
select distinct v27 from nAux92;
