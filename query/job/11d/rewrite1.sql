create or replace view aggView3776896535944197062 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]';
create or replace view aggJoin4257487000529656061 as (
with aggView7048304799633536547 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView7048304799633536547 where mk.keyword_id=aggView7048304799633536547.v22);
create or replace view aggJoin5611084879784474877 as (
with aggView2133279685768725932 as (select v24 from aggJoin4257487000529656061 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView2133279685768725932 where t.id=aggView2133279685768725932.v24 and production_year>1950);
create or replace view aggView2712944132659311512 as select v24, v28 from aggJoin5611084879784474877 group by v24,v28;
create or replace view aggJoin8826071844811275264 as (
with aggView591533152309033110 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView591533152309033110 where mc.company_type_id=aggView591533152309033110.v18);
create or replace view aggJoin5224202277811492175 as (
with aggView2242629755287406324 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView2242629755287406324 where ml.link_type_id=aggView2242629755287406324.v13);
create or replace view aggJoin2390160176966473149 as (
with aggView5882237300147588360 as (select v24 from aggJoin5224202277811492175 group by v24)
select v24, v17, v19 from aggJoin8826071844811275264 join aggView5882237300147588360 using(v24));
create or replace view aggView419893110053077556 as select v19, v24, v17 from aggJoin2390160176966473149 group by v19,v24,v17;
create or replace view aggJoin7449496087005503530 as (
with aggView7805357287817914160 as (select v24, MIN(v28) as v41 from aggView2712944132659311512 group by v24)
select v19, v17, v41 from aggView419893110053077556 join aggView7805357287817914160 using(v24));
create or replace view aggJoin1042569694972840269 as (
with aggView64081929085802855 as (select v17, MIN(v41) as v41, MIN(v19) as v40 from aggJoin7449496087005503530 group by v17,v41)
select v2, v41, v40 from aggView3776896535944197062 join aggView64081929085802855 using(v17));
select MIN(v2) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin1042569694972840269;
