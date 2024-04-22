create or replace view aggJoin7715446848620601948 as (
with aggView2530424413302566763 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v12 from movie_keyword as mk, aggView2530424413302566763 where mk.keyword_id=aggView2530424413302566763.v18);
create or replace view aggJoin7835003637018050403 as (
with aggView4955999643238207434 as (select id as v1 from company_name as cn where country_code= '[sm]')
select movie_id as v12 from movie_companies as mc, aggView4955999643238207434 where mc.company_id=aggView4955999643238207434.v1);
create or replace view aggJoin7637972341548001911 as (
with aggView134036151456345418 as (select v12 from aggJoin7835003637018050403 group by v12)
select v12 from aggJoin7715446848620601948 join aggView134036151456345418 using(v12));
create or replace view aggJoin2982369900936385735 as (
with aggView8164451179689382569 as (select v12 from aggJoin7637972341548001911 group by v12)
select title as v20 from title as t, aggView8164451179689382569 where t.id=aggView8164451179689382569.v12);
create or replace view aggView1847496310651806361 as select v20 from aggJoin2982369900936385735 group by v20;
select MIN(v20) as v31 from aggView1847496310651806361;
