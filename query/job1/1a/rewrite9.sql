create or replace view aggView8001420126760712183 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin6990415047355365246 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView8001420126760712183 where mc.movie_id=aggView8001420126760712183.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView8843787118673004219 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin6501857928644377138 as select movie_id as v15 from movie_info_idx as mi_idx, aggView8843787118673004219 where mi_idx.info_type_id=aggView8843787118673004219.v3;
create or replace view aggView4401809562787224604 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2016963671199726472 as select v15, v9, v28, v29 from aggJoin6990415047355365246 join aggView4401809562787224604 using(v1);
create or replace view aggView3216066085673485616 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin2016963671199726472 group by v15;
create or replace view aggJoin8586169572495028273 as select v28, v29, v27 from aggJoin6501857928644377138 join aggView3216066085673485616 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin8586169572495028273;
