create or replace view aggJoin8461989619916840850 as (
with aggView8068684166404196588 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView8068684166404196588 where mc.company_type_id=aggView8068684166404196588.v8);
create or replace view aggJoin6610790720104562950 as (
with aggView2657295539288402388 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView2657295539288402388 where miidx.info_type_id=aggView2657295539288402388.v10);
create or replace view aggView2821227747902007603 as select v22, v29 from aggJoin6610790720104562950 group by v22,v29;
create or replace view aggJoin6994875426409760063 as (
with aggView7769884753582386465 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView7769884753582386465 where mi.info_type_id=aggView7769884753582386465.v12);
create or replace view aggJoin6081077268153220244 as (
with aggView7107500614784993133 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin8461989619916840850 join aggView7107500614784993133 using(v1));
create or replace view aggJoin6640691470029364877 as (
with aggView8155643975721625180 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView8155643975721625180 where t.kind_id=aggView8155643975721625180.v14);
create or replace view aggView4484103763861756707 as select v22, v32 from aggJoin6640691470029364877 group by v22,v32;
create or replace view aggJoin4212253857255642598 as (
with aggView4550533688879573665 as (select v22 from aggJoin6081077268153220244 group by v22)
select v22, v24 from aggJoin6994875426409760063 join aggView4550533688879573665 using(v22));
create or replace view aggView609352511830520317 as select v24, v22 from aggJoin4212253857255642598 group by v24,v22;
create or replace view aggJoin8053533470315992918 as (
with aggView3056594772576426387 as (select v22, MIN(v24) as v43 from aggView609352511830520317 group by v22)
select v22, v29, v43 from aggView2821227747902007603 join aggView3056594772576426387 using(v22));
create or replace view aggJoin3797803089383936797 as (
with aggView1193037672322789725 as (select v22, MIN(v43) as v43, MIN(v29) as v44 from aggJoin8053533470315992918 group by v22,v43)
select v32, v43, v44 from aggView4484103763861756707 join aggView1193037672322789725 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin3797803089383936797;
