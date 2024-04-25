create or replace view tAux78 as select id as v15, title as v16, production_year as v19 from title;
create or replace view semiJoinView8168850635886164044 as select movie_id as v15, info_type_id as v3 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'top 250 rank');
create or replace view semiJoinView727007835035565702 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (movie_id) in (select (v15) from semiJoinView8168850635886164044) and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view semiJoinView6753999554231885856 as select v15, v1, v9 from semiJoinView727007835035565702 where (v1) in (select (id) from company_type AS ct where kind= 'production companies');
create or replace view mcAux8 as select v15, v9 from semiJoinView6753999554231885856;
create or replace view semiJoinView969029906119698773 as select distinct v15, v9 from mcAux8 where (v15) in (select (v15) from tAux78);
create or replace view semiEnum5519300344585908530 as select v9, v19, v16 from semiJoinView969029906119698773 join tAux78 using(v15);
select distinct v9, v16, v19 from semiEnum5519300344585908530;
