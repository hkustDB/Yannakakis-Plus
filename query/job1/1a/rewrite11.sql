create or replace view aggView6832216022637398347 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin8922793106948905600 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView6832216022637398347 where mi_idx.movie_id=aggView6832216022637398347.v15;
create or replace view aggView2762060504288123201 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin182230156667363858 as select v15, v28, v29 from aggJoin8922793106948905600 join aggView2762060504288123201 using(v3);
create or replace view aggView32059268298133089 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin182230156667363858 group by v15;
create or replace view aggJoin19148831251536580 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView32059268298133089 where mc.movie_id=aggView32059268298133089.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView2396480923785218462 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin19148831251536580 group by v1;
create or replace view aggJoin6813759470487726166 as select kind as v2, v28, v29, v27 from company_type as ct, aggView2396480923785218462 where ct.id=aggView2396480923785218462.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin6813759470487726166;
