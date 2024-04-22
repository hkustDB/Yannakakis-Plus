create or replace view aggView7765170842146583590 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin5511672705550884496 as (
with aggView2888547480889528454 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView2888547480889528454 where mi.info_type_id=aggView2888547480889528454.v12);
create or replace view aggJoin2561101428843161000 as (
with aggView7269551872530436529 as (select v22 from aggJoin5511672705550884496 group by v22)
select movie_id as v22, info_type_id as v10, info as v29 from movie_info_idx as miidx, aggView7269551872530436529 where miidx.movie_id=aggView7269551872530436529.v22);
create or replace view aggJoin7031136521513474599 as (
with aggView8635250690373593792 as (select id as v10 from info_type as it where info= 'rating')
select v22, v29 from aggJoin2561101428843161000 join aggView8635250690373593792 using(v10));
create or replace view aggView7010309101234246896 as select v22, v29 from aggJoin7031136521513474599 group by v22,v29;
create or replace view aggJoin545740503486710675 as (
with aggView1271693522182793911 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView1271693522182793911 where t.kind_id=aggView1271693522182793911.v14 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggView1719629289947511170 as select v22, v32 from aggJoin545740503486710675 group by v22,v32;
create or replace view aggJoin4904080746560529059 as (
with aggView7579551613337396747 as (select v1, MIN(v2) as v43 from aggView7765170842146583590 group by v1)
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView7579551613337396747 where mc.company_id=aggView7579551613337396747.v1);
create or replace view aggJoin559747927659439280 as (
with aggView4757186906476241935 as (select v22, MIN(v29) as v44 from aggView7010309101234246896 group by v22)
select v22, v8, v43 as v43, v44 from aggJoin4904080746560529059 join aggView4757186906476241935 using(v22));
create or replace view aggJoin5312511720032064526 as (
with aggView2373378564622919859 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43, v44 from aggJoin559747927659439280 join aggView2373378564622919859 using(v8));
create or replace view aggJoin4977036805545445943 as (
with aggView8542642958073447580 as (select v22, MIN(v43) as v43, MIN(v44) as v44 from aggJoin5312511720032064526 group by v22,v43,v44)
select v32, v43, v44 from aggView1719629289947511170 join aggView8542642958073447580 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin4977036805545445943;
