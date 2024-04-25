create or replace view semiJoinView960196780896763289 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view semiJoinView3984106179912705878 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info AS mi where (movie_id) in (select (v15) from semiJoinView960196780896763289) and info IN ('USA','America');
create or replace view semiJoinView9185876108605267830 as select v15, v3, v13 from semiJoinView3984106179912705878 where (v3) in (select (id) from info_type AS it);
create or replace view semiJoinView8244495540606202561 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select (v15) from semiJoinView9185876108605267830) and production_year>2010;
create or replace view tAux15 as select v16 from semiJoinView8244495540606202561;
select distinct v16 from tAux15;
