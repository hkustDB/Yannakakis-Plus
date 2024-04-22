create or replace view aggJoin5082893293686231373 as (
with aggView7217032899984955778 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView7217032899984955778 where mc.company_id=aggView7217032899984955778.v1);
create or replace view aggJoin203001484659570054 as (
with aggView5765565938490452956 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin5082893293686231373 join aggView5765565938490452956 using(v8));
create or replace view aggJoin896339407988157605 as (
with aggView831889991046336163 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView831889991046336163 where miidx.info_type_id=aggView831889991046336163.v10);
create or replace view aggJoin5810658768418378308 as (
with aggView5898400617429427010 as (select v22, MIN(v29) as v44 from aggJoin896339407988157605 group by v22)
select v22, v43 as v43, v44 from aggJoin203001484659570054 join aggView5898400617429427010 using(v22));
create or replace view aggJoin2740433179169455526 as (
with aggView1076905781297883683 as (select v22, MIN(v43) as v43, MIN(v44) as v44 from aggJoin5810658768418378308 group by v22,v44,v43)
select id as v22, title as v32, kind_id as v14, v43, v44 from title as t, aggView1076905781297883683 where t.id=aggView1076905781297883683.v22 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggJoin7676441696781895453 as (
with aggView7620656750997796924 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView7620656750997796924 where mi.info_type_id=aggView7620656750997796924.v12);
create or replace view aggJoin6920931814026459139 as (
with aggView867433714018366621 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32, v43, v44 from aggJoin2740433179169455526 join aggView867433714018366621 using(v14));
create or replace view aggJoin1602310959725642626 as (
with aggView4662587257344502982 as (select v22, MIN(v43) as v43, MIN(v44) as v44, MIN(v32) as v45 from aggJoin6920931814026459139 group by v22,v44,v43)
select v43, v44, v45 from aggJoin7676441696781895453 join aggView4662587257344502982 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1602310959725642626;
