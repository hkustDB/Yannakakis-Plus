create or replace view aggView7533144911154906352 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin9033275634507354020 as select movie_id as v15 from movie_info_idx as mi_idx, aggView7533144911154906352 where mi_idx.info_type_id=aggView7533144911154906352.v3;
create or replace view aggView2344123008600326382 as select v15 from aggJoin9033275634507354020 group by v15;
create or replace view aggJoin2655236985545230209 as select id as v15, title as v16, production_year as v19 from title as t, aggView2344123008600326382 where t.id=aggView2344123008600326382.v15;
create or replace view aggView8209976880528716572 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8848084592114811935 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8209976880528716572 where mc.company_type_id=aggView8209976880528716572.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView4529358943191706119 as select v15, MIN(v9) as v27 from aggJoin8848084592114811935 group by v15;
create or replace view aggJoin8985361320681318858 as select v16, v19, v27 from aggJoin2655236985545230209 join aggView4529358943191706119 using(v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin8985361320681318858;
