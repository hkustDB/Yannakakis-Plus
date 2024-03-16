create or replace view aggView6411237505741316764 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin1004934985520101695 as select movie_id as v15 from movie_info_idx as mi_idx, aggView6411237505741316764 where mi_idx.info_type_id=aggView6411237505741316764.v3;
create or replace view aggView7035436891319765743 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin901075020700665744 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7035436891319765743 where mc.company_type_id=aggView7035436891319765743.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView4248664017951390891 as select v15, MIN(v9) as v27 from aggJoin901075020700665744 group by v15;
create or replace view aggJoin6482916411268232575 as select v15, v27 from aggJoin1004934985520101695 join aggView4248664017951390891 using(v15);
create or replace view aggView2986465277999214019 as select v15, MIN(v27) as v27 from aggJoin6482916411268232575 group by v15;
create or replace view aggJoin5706821715770331135 as select title as v16, production_year as v19, v27 from title as t, aggView2986465277999214019 where t.id=aggView2986465277999214019.v15;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin5706821715770331135;
