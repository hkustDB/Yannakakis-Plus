create or replace view aggJoin5553367203496901974 as (
with aggView8278895970175776116 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView8278895970175776116 where mc.company_id=aggView8278895970175776116.v1);
create or replace view aggJoin5570392281265831056 as (
with aggView1837391879716017064 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin5553367203496901974 join aggView1837391879716017064 using(v8));
create or replace view aggJoin9093594560768088785 as (
with aggView3944914129892648743 as (select v22, MIN(v43) as v43 from aggJoin5570392281265831056 group by v22,v43)
select id as v22, title as v32, kind_id as v14, v43 from title as t, aggView3944914129892648743 where t.id=aggView3944914129892648743.v22 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggJoin7213599219611346721 as (
with aggView1510932033021820827 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView1510932033021820827 where miidx.info_type_id=aggView1510932033021820827.v10);
create or replace view aggJoin5960653764409147242 as (
with aggView8556097833035002077 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView8556097833035002077 where mi.info_type_id=aggView8556097833035002077.v12);
create or replace view aggJoin5281488876217715491 as (
with aggView5711683955693195961 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32, v43 from aggJoin9093594560768088785 join aggView5711683955693195961 using(v14));
create or replace view aggJoin4020119146005995244 as (
with aggView7278605024221320030 as (select v22, MIN(v43) as v43, MIN(v32) as v45 from aggJoin5281488876217715491 group by v22,v43)
select v22, v29, v43, v45 from aggJoin7213599219611346721 join aggView7278605024221320030 using(v22));
create or replace view aggJoin3293560573497657537 as (
with aggView1282688801541455876 as (select v22, MIN(v43) as v43, MIN(v45) as v45, MIN(v29) as v44 from aggJoin4020119146005995244 group by v22,v45,v43)
select v43, v45, v44 from aggJoin5960653764409147242 join aggView1282688801541455876 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3293560573497657537;
