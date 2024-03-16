create or replace view aggView7498880783900177101 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin770547742366181287 as select movie_id as v15 from movie_info_idx as mi_idx, aggView7498880783900177101 where mi_idx.info_type_id=aggView7498880783900177101.v3;
create or replace view aggView2196664888163869703 as select v15 from aggJoin770547742366181287 group by v15;
create or replace view aggJoin6680252859754248325 as select id as v15, title as v16, production_year as v19 from title as t, aggView2196664888163869703 where t.id=aggView2196664888163869703.v15;
create or replace view aggView83300207195921835 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin6680252859754248325 group by v15;
create or replace view aggJoin8560232012893655972 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView83300207195921835 where mc.movie_id=aggView83300207195921835.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView4490392208228208417 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7137720157259473142 as select v9, v28, v29 from aggJoin8560232012893655972 join aggView4490392208228208417 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin7137720157259473142;
