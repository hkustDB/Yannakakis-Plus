create or replace view aggJoin4827323316821652141 as (
with aggView2223221988754317499 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView2223221988754317499 where mc.company_id=aggView2223221988754317499.v1);
create or replace view aggJoin4743886514111652595 as (
with aggView4698137528267395932 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin4827323316821652141 join aggView4698137528267395932 using(v8));
create or replace view aggJoin7656595625920610973 as (
with aggView7235701896731347697 as (select v22, MIN(v43) as v43 from aggJoin4743886514111652595 group by v22,v43)
select movie_id as v22, info_type_id as v12, v43 from movie_info as mi, aggView7235701896731347697 where mi.movie_id=aggView7235701896731347697.v22);
create or replace view aggJoin7355131994160028446 as (
with aggView494347101574002232 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView494347101574002232 where t.kind_id=aggView494347101574002232.v14);
create or replace view aggJoin1199819032989450533 as (
with aggView706071148631368358 as (select v22, MIN(v32) as v45 from aggJoin7355131994160028446 group by v22)
select movie_id as v22, info_type_id as v10, info as v29, v45 from movie_info_idx as miidx, aggView706071148631368358 where miidx.movie_id=aggView706071148631368358.v22);
create or replace view aggJoin4833766731211425256 as (
with aggView7441158546001507799 as (select id as v10 from info_type as it where info= 'rating')
select v22, v29, v45 from aggJoin1199819032989450533 join aggView7441158546001507799 using(v10));
create or replace view aggJoin3413091243609540067 as (
with aggView7046467819782929924 as (select v22, MIN(v45) as v45, MIN(v29) as v44 from aggJoin4833766731211425256 group by v22,v45)
select v12, v43 as v43, v45, v44 from aggJoin7656595625920610973 join aggView7046467819782929924 using(v22));
create or replace view aggJoin1317779494815447369 as (
with aggView5979790575432310446 as (select id as v12 from info_type as it2 where info= 'release dates')
select v43, v45, v44 from aggJoin3413091243609540067 join aggView5979790575432310446 using(v12));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1317779494815447369;
