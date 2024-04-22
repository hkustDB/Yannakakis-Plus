create or replace view aggJoin4212218055039726932 as (
with aggView2088129611163444194 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView2088129611163444194 where mi.info_type_id=aggView2088129611163444194.v21);
create or replace view aggJoin3348340682362961623 as (
with aggView2276459070785214222 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView2276459070785214222 where mc.company_id=aggView2276459070785214222.v1);
create or replace view aggJoin5928504531442023716 as (
with aggView736491329721478699 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin3348340682362961623 join aggView736491329721478699 using(v8));
create or replace view aggJoin1810807863171034147 as (
with aggView2870108803183123040 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select movie_id as v29 from movie_info_idx as mi_idx, aggView2870108803183123040 where mi_idx.info_type_id=aggView2870108803183123040.v26);
create or replace view aggJoin2504528882800696942 as (
with aggView1192177278869162368 as (select v29 from aggJoin5928504531442023716 group by v29)
select v29, v22 from aggJoin4212218055039726932 join aggView1192177278869162368 using(v29));
create or replace view aggJoin8486879422996023236 as (
with aggView5440350958498494737 as (select v29 from aggJoin1810807863171034147 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView5440350958498494737 where t.id=aggView5440350958498494737.v29 and production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')));
create or replace view aggJoin3607771944075482911 as (
with aggView6222430962046097068 as (select v29, MIN(v30) as v42 from aggJoin8486879422996023236 group by v29)
select v22, v42 from aggJoin2504528882800696942 join aggView6222430962046097068 using(v29));
select MIN(v22) as v41,MIN(v42) as v42 from aggJoin3607771944075482911;
