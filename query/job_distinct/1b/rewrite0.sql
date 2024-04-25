create or replace view tAux72 as select id as v15, title as v16, production_year as v19 from title where production_year<=2010 and production_year>=2005;
create or replace view semiJoinView4195866270750769141 as select movie_id as v15, info_type_id as v3 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'bottom 10 rank');
create or replace view semiJoinView6566844901577564433 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (movie_id) in (select (v15) from semiJoinView4195866270750769141);
create or replace view semiJoinView8779198308686934440 as select v15, v1, v9 from semiJoinView6566844901577564433 where (v1) in (select (id) from company_type AS ct where kind= 'production companies');
create or replace view mcAux18 as select v15, v9 from semiJoinView8779198308686934440;
create or replace view semiJoinView7957481130050590302 as select distinct v15, v16, v19 from tAux72 where (v15) in (select (v15) from mcAux18);
create or replace view semiEnum988128627120528581 as select v19, v16, v9 from semiJoinView7957481130050590302 join mcAux18 using(v15);
select distinct v9, v16, v19 from semiEnum988128627120528581;
