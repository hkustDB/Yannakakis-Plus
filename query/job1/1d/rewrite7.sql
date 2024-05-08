create or replace view aggView3463935730607714504 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin6216284879833515650 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView3463935730607714504 where mi_idx.movie_id=aggView3463935730607714504.v15;
create or replace view aggView3872978226571835 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin6479408531280320542 as select v15, v28, v29 from aggJoin6216284879833515650 join aggView3872978226571835 using(v3);
create or replace view aggView8501889500844827222 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin6479408531280320542 group by v15;
create or replace view aggJoin5002955798458805987 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView8501889500844827222 where mc.movie_id=aggView8501889500844827222.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView4626732840618442004 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3989800751649237664 as select v9, v28, v29 from aggJoin5002955798458805987 join aggView4626732840618442004 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3989800751649237664;
