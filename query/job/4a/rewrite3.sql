create or replace view aggView3207706509042429036 as select id as v14, title as v15 from title as t where production_year>2005;
create or replace view aggJoin8076726341357017610 as (
with aggView2647113998678028999 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v14 from movie_keyword as mk, aggView2647113998678028999 where mk.keyword_id=aggView2647113998678028999.v3);
create or replace view aggJoin8931637338017212635 as (
with aggView643075272915519385 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView643075272915519385 where mi_idx.info_type_id=aggView643075272915519385.v1 and info>'5.0');
create or replace view aggJoin1801483287458208818 as (
with aggView7520239667232945156 as (select v14 from aggJoin8076726341357017610 group by v14)
select v14, v9 from aggJoin8931637338017212635 join aggView7520239667232945156 using(v14));
create or replace view aggView2813900877379000729 as select v9, v14 from aggJoin1801483287458208818 group by v9,v14;
create or replace view aggJoin6130277726328553396 as (
with aggView5566347196402594307 as (select v14, MIN(v15) as v27 from aggView3207706509042429036 group by v14)
select v9, v27 from aggView2813900877379000729 join aggView5566347196402594307 using(v14));
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin6130277726328553396;
