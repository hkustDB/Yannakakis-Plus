create or replace view aggView7120095538137089730 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin6089492346445667966 as select movie_id as v15 from movie_info_idx as mi_idx, aggView7120095538137089730 where mi_idx.info_type_id=aggView7120095538137089730.v3;
create or replace view aggView2688720427011178172 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin321736481620165551 as select movie_id as v15, note as v9 from movie_companies as mc, aggView2688720427011178172 where mc.company_type_id=aggView2688720427011178172.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView8601831260103479498 as select v15, COUNT(*) as annot from aggJoin6089492346445667966 group by v15;
create or replace view aggJoin8078311807416488721 as select v15, v9, annot from aggJoin321736481620165551 join aggView8601831260103479498 using(v15);
create or replace view aggView6001301174347795236 as select v15, SUM(annot) as annot from aggJoin8078311807416488721 group by v15;
create or replace view aggJoin371688940658896633 as select annot from title as t, aggView6001301174347795236 where t.id=aggView6001301174347795236.v15;
select SUM(annot) as v27 from aggJoin371688940658896633;
