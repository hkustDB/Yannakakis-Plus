create or replace view aggView4452412725856061938 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin1697425624574837006 as (
with aggView2377609976725871776 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView2377609976725871776 where miidx.info_type_id=aggView2377609976725871776.v10);
create or replace view aggView7230323429988162358 as select v22, v29 from aggJoin1697425624574837006 group by v22,v29;
create or replace view aggJoin5803982508279402991 as (
with aggView6678162320600361146 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView6678162320600361146 where t.kind_id=aggView6678162320600361146.v14 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggView238519303356483067 as select v22, v32 from aggJoin5803982508279402991 group by v22,v32;
create or replace view aggJoin3598669766423022122 as (
with aggView6115632234680708103 as (select v1, MIN(v2) as v43 from aggView4452412725856061938 group by v1)
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView6115632234680708103 where mc.company_id=aggView6115632234680708103.v1);
create or replace view aggJoin102570933234469783 as (
with aggView7620565556823771325 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin3598669766423022122 join aggView7620565556823771325 using(v8));
create or replace view aggJoin5264706825513757150 as (
with aggView5018352251160883099 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView5018352251160883099 where mi.info_type_id=aggView5018352251160883099.v12);
create or replace view aggJoin3472475733057275405 as (
with aggView2774385622731547247 as (select v22 from aggJoin5264706825513757150 group by v22)
select v22, v43 as v43 from aggJoin102570933234469783 join aggView2774385622731547247 using(v22));
create or replace view aggJoin8627207131364352455 as (
with aggView543914378056265687 as (select v22, MIN(v43) as v43 from aggJoin3472475733057275405 group by v22,v43)
select v22, v32, v43 from aggView238519303356483067 join aggView543914378056265687 using(v22));
create or replace view aggJoin2837767656559250831 as (
with aggView7525393784959471624 as (select v22, MIN(v43) as v43, MIN(v32) as v45 from aggJoin8627207131364352455 group by v22,v43)
select v29, v43, v45 from aggView7230323429988162358 join aggView7525393784959471624 using(v22));
select MIN(v43) as v43,MIN(v29) as v44,MIN(v45) as v45 from aggJoin2837767656559250831;
