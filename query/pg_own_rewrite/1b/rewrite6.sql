create or replace view aggView9081078368298409819 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7169010789275261004 as select movie_id as v15, note as v9 from movie_companies as mc, aggView9081078368298409819 where mc.company_type_id=aggView9081078368298409819.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView2088738246554609327 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin8593726612864972394 as select v15, v9, v28, v29 from aggJoin7169010789275261004 join aggView2088738246554609327 using(v15);
create or replace view aggView1482215114990804194 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin7523825913869563686 as select movie_id as v15 from movie_info_idx as mi_idx, aggView1482215114990804194 where mi_idx.info_type_id=aggView1482215114990804194.v3;
create or replace view aggView2391915701824057112 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin8593726612864972394 group by v15,v29,v28;
create or replace view aggJoin3128589550313357748 as select v28, v29, v27 from aggJoin7523825913869563686 join aggView2391915701824057112 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3128589550313357748;
