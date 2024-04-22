create or replace view aggJoin3176145654680887575 as (
with aggView2291497309367310724 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView2291497309367310724 where mc.company_id=aggView2291497309367310724.v1);
create or replace view aggJoin6740638500102220261 as (
with aggView5458128264565645387 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin3176145654680887575 join aggView5458128264565645387 using(v8));
create or replace view aggJoin3112636433814415180 as (
with aggView1119592289878463968 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView1119592289878463968 where mi.info_type_id=aggView1119592289878463968.v12);
create or replace view aggJoin7161923901469385012 as (
with aggView3611863683881373642 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView3611863683881373642 where miidx.info_type_id=aggView3611863683881373642.v10);
create or replace view aggJoin422634265599856457 as (
with aggView1264781886394136742 as (select v22, MIN(v29) as v44 from aggJoin7161923901469385012 group by v22)
select id as v22, title as v32, kind_id as v14, v44 from title as t, aggView1264781886394136742 where t.id=aggView1264781886394136742.v22 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggJoin8577111075884275748 as (
with aggView137455677419751972 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32, v44 from aggJoin422634265599856457 join aggView137455677419751972 using(v14));
create or replace view aggJoin7683163369083995318 as (
with aggView3906610720987918285 as (select v22, MIN(v44) as v44, MIN(v32) as v45 from aggJoin8577111075884275748 group by v22,v44)
select v22, v44, v45 from aggJoin3112636433814415180 join aggView3906610720987918285 using(v22));
create or replace view aggJoin1935178978031037495 as (
with aggView4148919978986557632 as (select v22, MIN(v43) as v43 from aggJoin6740638500102220261 group by v22,v43)
select v44 as v44, v45 as v45, v43 from aggJoin7683163369083995318 join aggView4148919978986557632 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1935178978031037495;
