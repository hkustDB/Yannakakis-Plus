create or replace view semiJoinView77445890417639559 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view semiJoinView8853450133095577893 as select movie_id as v15, info_type_id as v3 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'top 250 rank');
create or replace view tAux37 as select id as v15, title as v16, production_year as v19 from title;
create or replace view semiJoinView1201324189333098319 as select v15, v1, v9 from semiJoinView77445890417639559 where (v15) in (select (v15) from semiJoinView8853450133095577893);
create or replace view mcAux48 as select v15, v9 from semiJoinView1201324189333098319;
create or replace view semiJoinView4985452453905697887 as select distinct v15, v16, v19 from tAux37 where (v15) in (select (v15) from mcAux48);
create or replace view semiEnum6936301275624279041 as select v9, v16, v19 from semiJoinView4985452453905697887 join mcAux48 using(v15);
select distinct v9, v16, v19 from semiEnum6936301275624279041;
