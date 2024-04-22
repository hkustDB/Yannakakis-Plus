create or replace view aggView6657203368346836795 as select title as v26, id as v11 from title as t2;
create or replace view aggJoin1352161996311386167 as (
with aggView3175802583710019618 as (select id as v8 from keyword as k where keyword= '10,000-mile-club')
select movie_id as v13 from movie_keyword as mk, aggView3175802583710019618 where mk.keyword_id=aggView3175802583710019618.v8);
create or replace view aggJoin4021721050492193273 as (
with aggView2020904636998655527 as (select v13 from aggJoin1352161996311386167 group by v13)
select id as v13, title as v14 from title as t1, aggView2020904636998655527 where t1.id=aggView2020904636998655527.v13);
create or replace view aggView5274044256754271260 as select v13, v14 from aggJoin4021721050492193273 group by v13,v14;
create or replace view aggJoin1462646209772870018 as (
with aggView2879039069712933998 as (select v13, MIN(v14) as v38 from aggView5274044256754271260 group by v13)
select linked_movie_id as v11, link_type_id as v4, v38 from movie_link as ml, aggView2879039069712933998 where ml.movie_id=aggView2879039069712933998.v13);
create or replace view aggJoin835405385282225662 as (
with aggView6367244363451738038 as (select id as v4, link as v37 from link_type as lt)
select v11, v38, v37 from aggJoin1462646209772870018 join aggView6367244363451738038 using(v4));
create or replace view aggJoin5731568630611845847 as (
with aggView7824470593322776799 as (select v11, MIN(v38) as v38, MIN(v37) as v37 from aggJoin835405385282225662 group by v11,v38,v37)
select v26, v38, v37 from aggView6657203368346836795 join aggView7824470593322776799 using(v11));
select MIN(v37) as v37,MIN(v38) as v38,MIN(v26) as v39 from aggJoin5731568630611845847;
