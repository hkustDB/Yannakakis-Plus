create or replace view semiJoinView7097502154181011676 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info AS mi where (info_type_id) in (select (id) from info_type AS it) and info IN ('USA','America');
create or replace view semiJoinView8150478851955852762 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select (v15) from semiJoinView7097502154181011676) and production_year>2010;
create or replace view semiJoinView3046317020834428056 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view semiJoinView5154205484157971298 as select v15, v16, v19 from semiJoinView8150478851955852762 where (v15) in (select (v15) from semiJoinView3046317020834428056);
create or replace view tAux68 as select v16 from semiJoinView5154205484157971298;
select distinct v16 from tAux68;
