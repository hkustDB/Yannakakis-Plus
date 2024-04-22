create or replace view aggJoin4455932446751132233 as (
with aggView8784553941971568040 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView8784553941971568040 where mc.company_type_id=aggView8784553941971568040.v8);
create or replace view aggJoin5214460110272588399 as (
with aggView2574075439824735423 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView2574075439824735423 where miidx.info_type_id=aggView2574075439824735423.v10);
create or replace view aggView5553824632119710632 as select v22, v29 from aggJoin5214460110272588399 group by v22,v29;
create or replace view aggJoin8910472308197685823 as (
with aggView483408532626004133 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView483408532626004133 where mi.info_type_id=aggView483408532626004133.v12);
create or replace view aggJoin925125482545998406 as (
with aggView6540480339654475178 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin4455932446751132233 join aggView6540480339654475178 using(v1));
create or replace view aggJoin5779558489637907946 as (
with aggView4641918638307458154 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView4641918638307458154 where t.kind_id=aggView4641918638307458154.v14);
create or replace view aggView6211073158718472477 as select v22, v32 from aggJoin5779558489637907946 group by v22,v32;
create or replace view aggJoin8824001512282438013 as (
with aggView2630324663167251934 as (select v22 from aggJoin925125482545998406 group by v22)
select v22, v24 from aggJoin8910472308197685823 join aggView2630324663167251934 using(v22));
create or replace view aggView6577207149176479127 as select v24, v22 from aggJoin8824001512282438013 group by v24,v22;
create or replace view aggJoin2958971056699436550 as (
with aggView3324248674980335898 as (select v22, MIN(v32) as v45 from aggView6211073158718472477 group by v22)
select v22, v29, v45 from aggView5553824632119710632 join aggView3324248674980335898 using(v22));
create or replace view aggJoin8765097044547677665 as (
with aggView3430769892014802410 as (select v22, MIN(v45) as v45, MIN(v29) as v44 from aggJoin2958971056699436550 group by v22,v45)
select v24, v45, v44 from aggView6577207149176479127 join aggView3430769892014802410 using(v22));
select MIN(v24) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin8765097044547677665;
