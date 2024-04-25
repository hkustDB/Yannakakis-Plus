create or replace view semiJoinView2513143504872359057 as select movie_id as v15, info_type_id as v3 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'top 250 rank');
create or replace view semiJoinView7748553152644773002 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view semiJoinView4938865988950278035 as select v15, v1, v9 from semiJoinView7748553152644773002 where (v15) in (select (v15) from semiJoinView2513143504872359057);
create or replace view mcAux8 as select v15, v9 from semiJoinView4938865988950278035;
create or replace view tAux78 as select id as v15, title as v16, production_year as v19 from title;
create or replace view semiJoinView3296035877257429420 as select distinct v15, v16, v19 from tAux78 where (v15) in (select (v15) from mcAux8);
create or replace view semiEnum8103415983616961240 as select v9, v19, v16 from semiJoinView3296035877257429420 join mcAux8 using(v15);
select distinct v9, v16, v19 from semiEnum8103415983616961240;
