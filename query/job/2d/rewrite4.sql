create or replace view aggView5841313408241590594 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin5184789776008110132 as select movie_id as v12 from movie_companies as mc, aggView5841313408241590594 where mc.company_id=aggView5841313408241590594.v1;
create or replace view aggView8701104827801600002 as select v12 from aggJoin5184789776008110132 group by v12;
create or replace view aggJoin8199486744566791188 as select id as v12, title as v20 from title as t, aggView8701104827801600002 where t.id=aggView8701104827801600002.v12;
create or replace view aggView7405353210948928598 as select v12, MIN(v20) as v31 from aggJoin8199486744566791188 group by v12;
create or replace view aggJoin3810621897333590175 as select keyword_id as v18, v31 from movie_keyword as mk, aggView7405353210948928598 where mk.movie_id=aggView7405353210948928598.v12;
create or replace view aggView2614953502253104520 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6986942111512203690 as select v31 from aggJoin3810621897333590175 join aggView2614953502253104520 using(v18);
select MIN(v31) as v31 from aggJoin6986942111512203690;
