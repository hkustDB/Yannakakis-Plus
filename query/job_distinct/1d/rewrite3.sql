create or replace view semiJoinView554422474782410520 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view mcAux86 as select v15, v9 from semiJoinView554422474782410520;
create or replace view semiJoinView9099117815056320633 as select movie_id as v15, info_type_id as v3 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'bottom 10 rank');
create or replace view semiJoinView931399412088162845 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select (v15) from semiJoinView9099117815056320633);
create or replace view tAux64 as select v15, v16, v19 from semiJoinView931399412088162845;
create or replace view semiJoinView2215159339963771666 as select distinct v15, v9 from mcAux86 where (v15) in (select (v15) from tAux64);
create or replace view semiEnum7357761900824716758 as select v9, v19, v16 from semiJoinView2215159339963771666 join tAux64 using(v15);
select distinct v9, v16, v19 from semiEnum7357761900824716758;
