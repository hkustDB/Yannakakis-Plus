create or replace view semiJoinView1618839821540856076 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view mcAux72 as select v15, v9 from semiJoinView1618839821540856076;
create or replace view semiJoinView4174293508591382835 as select movie_id as v15, info_type_id as v3 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'bottom 10 rank');
create or replace view semiJoinView2171594180786425529 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select (v15) from semiJoinView4174293508591382835);
create or replace view tAux82 as select v15, v16, v19 from semiJoinView2171594180786425529;
create or replace view semiJoinView4929380535401603733 as select distinct v15, v9 from mcAux72 where (v15) in (select (v15) from tAux82);
create or replace view semiEnum4495811566925532774 as select v19, v16, v9 from semiJoinView4929380535401603733 join tAux82 using(v15);
select distinct v9, v16, v19 from semiEnum4495811566925532774;
