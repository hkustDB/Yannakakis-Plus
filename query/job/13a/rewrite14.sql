create or replace view aggJoin3545621248489060012 as (
with aggView2892550628846961748 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView2892550628846961748 where mc.company_type_id=aggView2892550628846961748.v8);
create or replace view aggJoin2761454749721857537 as (
with aggView3884438560875051344 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView3884438560875051344 where miidx.info_type_id=aggView3884438560875051344.v10);
create or replace view aggJoin419357544263183466 as (
with aggView2867026659487177812 as (select v22, MIN(v29) as v44 from aggJoin2761454749721857537 group by v22)
select movie_id as v22, info_type_id as v12, info as v24, v44 from movie_info as mi, aggView2867026659487177812 where mi.movie_id=aggView2867026659487177812.v22);
create or replace view aggJoin1116765778083932197 as (
with aggView2362219392459787936 as (select id as v12 from info_type as it2 where info= 'release dates')
select v22, v24, v44 from aggJoin419357544263183466 join aggView2362219392459787936 using(v12));
create or replace view aggJoin3326859970814641999 as (
with aggView3127344306660535834 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin3545621248489060012 join aggView3127344306660535834 using(v1));
create or replace view aggJoin2724431703474845075 as (
with aggView757130456898504209 as (select v22 from aggJoin3326859970814641999 group by v22)
select id as v22, title as v32, kind_id as v14 from title as t, aggView757130456898504209 where t.id=aggView757130456898504209.v22);
create or replace view aggJoin6902635451909300255 as (
with aggView3691500318915624642 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32 from aggJoin2724431703474845075 join aggView3691500318915624642 using(v14));
create or replace view aggJoin4466618432033384948 as (
with aggView2096347916370636594 as (select v22, MIN(v32) as v45 from aggJoin6902635451909300255 group by v22)
select v24, v44 as v44, v45 from aggJoin1116765778083932197 join aggView2096347916370636594 using(v22));
select MIN(v24) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin4466618432033384948;
