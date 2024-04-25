create or replace view semiJoinView7685104062911545037 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView8496142035159109041 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView5758211275450006947 as select v3, v25 from semiJoinView8496142035159109041 where (v3) in (select (v3) from semiJoinView7685104062911545037);
create or replace view semiJoinView3456850731463076490 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView5758211275450006947);
create or replace view semiJoinView8265915411742456872 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView3456850731463076490);
create or replace view semiJoinView1861334818927783228 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView8265915411742456872) and name LIKE '%B%';
create or replace view nAux98 as select v27 from semiJoinView1861334818927783228;
select distinct v27 from nAux98;
