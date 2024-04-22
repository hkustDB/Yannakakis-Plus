create or replace view aggJoin386084790045930685 as (
with aggView4880432584481448321 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView4880432584481448321 where mc.company_type_id=aggView4880432584481448321.v8);
create or replace view aggJoin4186260389278706633 as (
with aggView4647063793438830632 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView4647063793438830632 where miidx.info_type_id=aggView4647063793438830632.v10);
create or replace view aggJoin6439514328640318702 as (
with aggView2264493720355415534 as (select v22, MIN(v29) as v44 from aggJoin4186260389278706633 group by v22)
select id as v22, title as v32, kind_id as v14, v44 from title as t, aggView2264493720355415534 where t.id=aggView2264493720355415534.v22);
create or replace view aggJoin6890130426113795133 as (
with aggView7261754651739816064 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView7261754651739816064 where mi.info_type_id=aggView7261754651739816064.v12);
create or replace view aggJoin3496687542943477882 as (
with aggView3853726716351870632 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin386084790045930685 join aggView3853726716351870632 using(v1));
create or replace view aggJoin4662156867980388768 as (
with aggView2295215491718094910 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32, v44 from aggJoin6439514328640318702 join aggView2295215491718094910 using(v14));
create or replace view aggJoin5567864807106323516 as (
with aggView4380294556497187939 as (select v22, MIN(v44) as v44, MIN(v32) as v45 from aggJoin4662156867980388768 group by v22,v44)
select v22, v44, v45 from aggJoin3496687542943477882 join aggView4380294556497187939 using(v22));
create or replace view aggJoin5068083209189445742 as (
with aggView6600066888205601253 as (select v22, MIN(v44) as v44, MIN(v45) as v45 from aggJoin5567864807106323516 group by v22,v44,v45)
select v24, v44, v45 from aggJoin6890130426113795133 join aggView6600066888205601253 using(v22));
select MIN(v24) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin5068083209189445742;
