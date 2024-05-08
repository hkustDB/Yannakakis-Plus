create or replace view aggView6435267215266588667 as select id as v12, title as v31 from title as t;
create or replace view aggJoin2953167856776021323 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView6435267215266588667 where mk.movie_id=aggView6435267215266588667.v12;
create or replace view aggView6541521111933611446 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin8359558479703395808 as select movie_id as v12 from movie_companies as mc, aggView6541521111933611446 where mc.company_id=aggView6541521111933611446.v1;
create or replace view aggView6211707390793007001 as select v12 from aggJoin8359558479703395808 group by v12;
create or replace view aggJoin545473730798996412 as select v18, v31 as v31 from aggJoin2953167856776021323 join aggView6211707390793007001 using(v12);
create or replace view aggView3086200899140637367 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5236306578998869690 as select v31 from aggJoin545473730798996412 join aggView3086200899140637367 using(v18);
select MIN(v31) as v31 from aggJoin5236306578998869690;
