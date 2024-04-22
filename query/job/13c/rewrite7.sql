create or replace view aggView2372478705883523270 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin3311163954194446982 as (
with aggView4438848584880787533 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView4438848584880787533 where miidx.info_type_id=aggView4438848584880787533.v10);
create or replace view aggView9207103319499556382 as select v22, v29 from aggJoin3311163954194446982 group by v22,v29;
create or replace view aggJoin6019587249992872455 as (
with aggView4822122846133225157 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView4822122846133225157 where t.kind_id=aggView4822122846133225157.v14 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggView3274206963185631413 as select v32, v22 from aggJoin6019587249992872455 group by v32,v22;
create or replace view aggJoin2486663453282075050 as (
with aggView2670841465746935362 as (select v1, MIN(v2) as v43 from aggView2372478705883523270 group by v1)
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView2670841465746935362 where mc.company_id=aggView2670841465746935362.v1);
create or replace view aggJoin7930564347340533651 as (
with aggView3082576166420982964 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin2486663453282075050 join aggView3082576166420982964 using(v8));
create or replace view aggJoin2300349722655445627 as (
with aggView1594530633728685351 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView1594530633728685351 where mi.info_type_id=aggView1594530633728685351.v12);
create or replace view aggJoin4621466843540430088 as (
with aggView2794276306476874635 as (select v22 from aggJoin2300349722655445627 group by v22)
select v22, v43 as v43 from aggJoin7930564347340533651 join aggView2794276306476874635 using(v22));
create or replace view aggJoin6004937221840621208 as (
with aggView3386464304865942729 as (select v22, MIN(v43) as v43 from aggJoin4621466843540430088 group by v22,v43)
select v32, v22, v43 from aggView3274206963185631413 join aggView3386464304865942729 using(v22));
create or replace view aggJoin6342325737078829084 as (
with aggView260879805307142468 as (select v22, MIN(v43) as v43, MIN(v32) as v45 from aggJoin6004937221840621208 group by v22,v43)
select v29, v43, v45 from aggView9207103319499556382 join aggView260879805307142468 using(v22));
select MIN(v43) as v43,MIN(v29) as v44,MIN(v45) as v45 from aggJoin6342325737078829084;
