create or replace view aggView8495217630857973755 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin5657323437627977003 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView8495217630857973755 where mc.movie_id=aggView8495217630857973755.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView4461465530365856363 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6593435303056989718 as select v15, v9, v28, v29 from aggJoin5657323437627977003 join aggView4461465530365856363 using(v1);
create or replace view aggView9023444241556938166 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin6593435303056989718 group by v15;
create or replace view aggJoin6744045754424395293 as select info_type_id as v3, v28, v29, v27 from movie_info_idx as mi_idx, aggView9023444241556938166 where mi_idx.movie_id=aggView9023444241556938166.v15;
create or replace view aggView5370061956251668873 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin4980758003135115150 as select v28, v29, v27 from aggJoin6744045754424395293 join aggView5370061956251668873 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4980758003135115150;
