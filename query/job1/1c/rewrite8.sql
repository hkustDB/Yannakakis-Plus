create or replace view aggView2085869617331656915 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin5717060107190889769 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView2085869617331656915 where mc.movie_id=aggView2085869617331656915.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3662222088182164716 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin1603504929674343042 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3662222088182164716 where mi_idx.info_type_id=aggView3662222088182164716.v3;
create or replace view aggView7540999341623821003 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6839395204374855628 as select v15, v9, v28, v29 from aggJoin5717060107190889769 join aggView7540999341623821003 using(v1);
create or replace view aggView7196223765033689239 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin6839395204374855628 group by v15;
create or replace view aggJoin7239368602747836280 as select v28, v29, v27 from aggJoin1603504929674343042 join aggView7196223765033689239 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin7239368602747836280;
