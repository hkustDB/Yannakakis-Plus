create or replace view aggJoin1499904525494504947 as (
with aggView3724906700365838610 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView3724906700365838610 where mc.company_id=aggView3724906700365838610.v17);
create or replace view aggJoin6479252747933045687 as (
with aggView4890335903677201918 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView4890335903677201918 where ml.link_type_id=aggView4890335903677201918.v13);
create or replace view aggJoin7923101313615943960 as (
with aggView6187602962878188032 as (select id as v29, title as v46 from title as t where production_year<=2010 and production_year>=1950)
select movie_id as v29, keyword_id as v27, v46 from movie_keyword as mk, aggView6187602962878188032 where mk.movie_id=aggView6187602962878188032.v29);
create or replace view aggJoin2496686416364192523 as (
with aggView1295887294883150427 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin1499904525494504947 join aggView1295887294883150427 using(v18));
create or replace view aggJoin3586495297007392018 as (
with aggView5076616503140074098 as (select id as v27 from keyword as k where keyword= 'sequel')
select v29, v46 from aggJoin7923101313615943960 join aggView5076616503140074098 using(v27));
create or replace view aggJoin8754910899490052602 as (
with aggView3427873524316107087 as (select v29, MIN(v45) as v45 from aggJoin6479252747933045687 group by v29,v45)
select movie_id as v29, info as v23, v45 from movie_info as mi, aggView3427873524316107087 where mi.movie_id=aggView3427873524316107087.v29 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English'));
create or replace view aggJoin2374554868424199006 as (
with aggView6134143997623126661 as (select v29, MIN(v45) as v45 from aggJoin8754910899490052602 group by v29,v45)
select v29, v44 as v44, v45 from aggJoin2496686416364192523 join aggView6134143997623126661 using(v29));
create or replace view aggJoin5961832047695621074 as (
with aggView7214983292293144752 as (select v29, MIN(v44) as v44, MIN(v45) as v45 from aggJoin2374554868424199006 group by v29,v44,v45)
select v46 as v46, v44, v45 from aggJoin3586495297007392018 join aggView7214983292293144752 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin5961832047695621074;
