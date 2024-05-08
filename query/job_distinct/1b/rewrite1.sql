create or replace view semiJoinView1094933646667402023 as select movie_id as v15, info_type_id as v3 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'bottom 10 rank');
create or replace view semiJoinView7415381714246414853 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view semiJoinView3307906138322824609 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select (v15) from semiJoinView1094933646667402023);
create or replace view mcAux72 as select v15, v9 from semiJoinView7415381714246414853;
create or replace view tAux82 as select v15, v16, v19 from semiJoinView3307906138322824609;
create or replace view semiJoinView4973408160955405240 as select distinct v15, v16, v19 from tAux82 where (v15) in (select (v15) from mcAux72);
create or replace view semiEnum1179341596657944980 as select v19, v16, v9 from semiJoinView4973408160955405240 join mcAux72 using(v15);
select distinct v9, v16, v19 from semiEnum1179341596657944980;
