create or replace view aggJoin103828280132177456 as (
with aggView1167106475808038848 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView1167106475808038848 where mc.company_id=aggView1167106475808038848.v1);
create or replace view aggJoin7411580849268655791 as (
with aggView4679565558222739227 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin103828280132177456 join aggView4679565558222739227 using(v8));
create or replace view aggJoin2987369586446674648 as (
with aggView7218032993204040290 as (select v22, MIN(v43) as v43 from aggJoin7411580849268655791 group by v22,v43)
select movie_id as v22, info_type_id as v10, info as v29, v43 from movie_info_idx as miidx, aggView7218032993204040290 where miidx.movie_id=aggView7218032993204040290.v22);
create or replace view aggJoin8747662000765938278 as (
with aggView7038472425007195962 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView7038472425007195962 where mi.info_type_id=aggView7038472425007195962.v12);
create or replace view aggJoin166669249748286789 as (
with aggView4500957447405260768 as (select id as v10 from info_type as it where info= 'rating')
select v22, v29, v43 from aggJoin2987369586446674648 join aggView4500957447405260768 using(v10));
create or replace view aggJoin7517724168142960947 as (
with aggView3276389393448074592 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView3276389393448074592 where t.kind_id=aggView3276389393448074592.v14 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggJoin1598576095138413623 as (
with aggView5565447631915503048 as (select v22, MIN(v32) as v45 from aggJoin7517724168142960947 group by v22)
select v22, v29, v43 as v43, v45 from aggJoin166669249748286789 join aggView5565447631915503048 using(v22));
create or replace view aggJoin1448410763173139244 as (
with aggView700328755419697651 as (select v22, MIN(v43) as v43, MIN(v45) as v45, MIN(v29) as v44 from aggJoin1598576095138413623 group by v22,v43,v45)
select v43, v45, v44 from aggJoin8747662000765938278 join aggView700328755419697651 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1448410763173139244;
