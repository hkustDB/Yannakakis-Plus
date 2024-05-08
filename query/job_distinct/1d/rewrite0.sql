create or replace view semiJoinView1678574986191248960 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view semiJoinView6154865999824659371 as select movie_id as v15, info_type_id as v3 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'bottom 10 rank');
create or replace view semiJoinView2172049929127682830 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select (v15) from semiJoinView6154865999824659371);
create or replace view mcAux86 as select v15, v9 from semiJoinView1678574986191248960;
create or replace view tAux64 as select v15, v16, v19 from semiJoinView2172049929127682830;
create or replace view semiJoinView1203118490101146587 as select distinct v15, v16, v19 from tAux64 where (v15) in (select (v15) from mcAux86);
create or replace view semiEnum4971197510334144372 as select v9, v19, v16 from semiJoinView1203118490101146587 join mcAux86 using(v15);
select distinct v9, v16, v19 from semiEnum4971197510334144372;
