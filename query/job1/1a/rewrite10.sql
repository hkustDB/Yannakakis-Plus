create or replace view aggView8995753670348996649 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin8160395398829218777 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView8995753670348996649 where mi_idx.movie_id=aggView8995753670348996649.v15;
create or replace view aggView8840190298388753463 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin9073593561100803593 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8840190298388753463 where mc.company_type_id=aggView8840190298388753463.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView102425831099096845 as select v15, MIN(v9) as v27 from aggJoin9073593561100803593 group by v15;
create or replace view aggJoin5465826439544154253 as select v3, v28 as v28, v29 as v29, v27 from aggJoin8160395398829218777 join aggView102425831099096845 using(v15);
create or replace view aggView7052815260809040989 as select v3, MIN(v28) as v28, MIN(v29) as v29, MIN(v27) as v27 from aggJoin5465826439544154253 group by v3;
create or replace view aggJoin1758849067639602084 as select info as v4, v28, v29, v27 from info_type as it, aggView7052815260809040989 where it.id=aggView7052815260809040989.v3 and info= 'top 250 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin1758849067639602084;
