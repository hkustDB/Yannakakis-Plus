create or replace view aggJoin2414517300903724960 as (
with aggView8592741770307527548 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView8592741770307527548 where mc.company_type_id=aggView8592741770307527548.v8);
create or replace view aggJoin921030384490292399 as (
with aggView1436671751403685778 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView1436671751403685778 where miidx.info_type_id=aggView1436671751403685778.v10);
create or replace view aggJoin9206124661901279814 as (
with aggView1607592723817104537 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView1607592723817104537 where mi.info_type_id=aggView1607592723817104537.v12);
create or replace view aggView2051403694795819806 as select v24, v22 from aggJoin9206124661901279814 group by v24,v22;
create or replace view aggJoin3789804156580522181 as (
with aggView7852065066353045237 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin2414517300903724960 join aggView7852065066353045237 using(v1));
create or replace view aggJoin7194028764912454526 as (
with aggView1872080262176854913 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView1872080262176854913 where t.kind_id=aggView1872080262176854913.v14);
create or replace view aggView4744509991611180148 as select v22, v32 from aggJoin7194028764912454526 group by v22,v32;
create or replace view aggJoin8784415986603471712 as (
with aggView8995749347820668135 as (select v22 from aggJoin3789804156580522181 group by v22)
select v22, v29 from aggJoin921030384490292399 join aggView8995749347820668135 using(v22));
create or replace view aggView4685922628960754713 as select v22, v29 from aggJoin8784415986603471712 group by v22,v29;
create or replace view aggJoin2254871152263623514 as (
with aggView1500354364534716204 as (select v22, MIN(v32) as v45 from aggView4744509991611180148 group by v22)
select v24, v22, v45 from aggView2051403694795819806 join aggView1500354364534716204 using(v22));
create or replace view aggJoin7468521650190784654 as (
with aggView2431114406743585027 as (select v22, MIN(v29) as v44 from aggView4685922628960754713 group by v22)
select v24, v45 as v45, v44 from aggJoin2254871152263623514 join aggView2431114406743585027 using(v22));
select MIN(v24) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin7468521650190784654;
