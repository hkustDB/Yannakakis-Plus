create or replace view aggJoin7571861876332858658 as (
with aggView5719322928413333392 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView5719322928413333392 where mc.company_id=aggView5719322928413333392.v1);
create or replace view aggJoin8475869623225760595 as (
with aggView4077028541996734442 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin7571861876332858658 join aggView4077028541996734442 using(v8));
create or replace view aggJoin7559116066278075680 as (
with aggView2984763997148827441 as (select v22, MIN(v43) as v43 from aggJoin8475869623225760595 group by v22,v43)
select id as v22, title as v32, kind_id as v14, v43 from title as t, aggView2984763997148827441 where t.id=aggView2984763997148827441.v22 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggJoin1535746981377526348 as (
with aggView1563358769559774123 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView1563358769559774123 where mi.info_type_id=aggView1563358769559774123.v12);
create or replace view aggJoin1356442722720077198 as (
with aggView2466967016066141564 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView2466967016066141564 where miidx.info_type_id=aggView2466967016066141564.v10);
create or replace view aggJoin1787206455782226388 as (
with aggView214942674117060850 as (select v22, MIN(v29) as v44 from aggJoin1356442722720077198 group by v22)
select v22, v44 from aggJoin1535746981377526348 join aggView214942674117060850 using(v22));
create or replace view aggJoin594496721963216424 as (
with aggView8524752107003658788 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32, v43 from aggJoin7559116066278075680 join aggView8524752107003658788 using(v14));
create or replace view aggJoin1406409674071004780 as (
with aggView7312984608194477662 as (select v22, MIN(v43) as v43, MIN(v32) as v45 from aggJoin594496721963216424 group by v22,v43)
select v44 as v44, v43, v45 from aggJoin1787206455782226388 join aggView7312984608194477662 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1406409674071004780;
