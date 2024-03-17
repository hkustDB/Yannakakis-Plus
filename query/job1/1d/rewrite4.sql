create or replace view aggView2736270146715525112 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin9097563479628039490 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView2736270146715525112 where mc.movie_id=aggView2736270146715525112.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3498127465050635627 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin220491732907947536 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3498127465050635627 where mi_idx.info_type_id=aggView3498127465050635627.v3;
create or replace view aggView224698861391337090 as select v15 from aggJoin220491732907947536 group by v15;
create or replace view aggJoin702860969856620271 as select v1, v9, v28 as v28, v29 as v29 from aggJoin9097563479628039490 join aggView224698861391337090 using(v15);
create or replace view aggView4463364730190329352 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin702860969856620271 group by v1;
create or replace view aggJoin1954943205756770269 as select kind as v2, v28, v29, v27 from company_type as ct, aggView4463364730190329352 where ct.id=aggView4463364730190329352.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin1954943205756770269;
