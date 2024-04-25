create or replace view semiJoinView4632898879920244477 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView4955506300214017578 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (movie_id) in (select (v3) from semiJoinView4632898879920244477);
create or replace view semiJoinView3089889680747959492 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (id) from title AS t);
create or replace view semiJoinView8900919868389180718 as select v3, v25 from semiJoinView4955506300214017578 where (v25) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView7232070307366294821 as select v26, v3 from semiJoinView3089889680747959492 where (v3) in (select (v3) from semiJoinView8900919868389180718);
create or replace view semiJoinView9165833620283140896 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView7232070307366294821);
create or replace view nAux55 as select v27 from semiJoinView9165833620283140896;
select distinct v27 from nAux55;
