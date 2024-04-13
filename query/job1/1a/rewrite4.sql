create or replace view aggView4943106372201560723 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2998246536826396744 as select movie_id as v15, note as v9 from movie_companies as mc, aggView4943106372201560723 where mc.company_type_id=aggView4943106372201560723.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView3175477799867533901 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin6467446151946282406 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3175477799867533901 where mi_idx.info_type_id=aggView3175477799867533901.v3;
create or replace view aggView5409842522680333516 as select v15 from aggJoin6467446151946282406 group by v15;
create or replace view aggJoin1819890930258950004 as select id as v15, title as v16, production_year as v19 from title as t, aggView5409842522680333516 where t.id=aggView5409842522680333516.v15;
create or replace view aggView7196820257588859143 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin1819890930258950004 group by v15;
create or replace view aggJoin3500466826115778021 as select v9, v28, v29 from aggJoin2998246536826396744 join aggView7196820257588859143 using(v15);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3500466826115778021;
