create or replace view aggJoin5816017612310407810 as (
with aggView2492657418205256223 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView2492657418205256223 where mc.company_type_id=aggView2492657418205256223.v8);
create or replace view aggJoin1421929340742299237 as (
with aggView3948963454660928110 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView3948963454660928110 where miidx.info_type_id=aggView3948963454660928110.v10);
create or replace view aggView3226695626629824309 as select v22, v29 from aggJoin1421929340742299237 group by v22,v29;
create or replace view aggJoin8999533026193437020 as (
with aggView4810787478202761661 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView4810787478202761661 where mi.info_type_id=aggView4810787478202761661.v12);
create or replace view aggJoin2959272272334838156 as (
with aggView8109131033833532543 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin5816017612310407810 join aggView8109131033833532543 using(v1));
create or replace view aggJoin4190532628056197528 as (
with aggView1604746090322920142 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView1604746090322920142 where t.kind_id=aggView1604746090322920142.v14);
create or replace view aggView1919949683341576123 as select v22, v32 from aggJoin4190532628056197528 group by v22,v32;
create or replace view aggJoin7615771903594892798 as (
with aggView3988696790160324709 as (select v22 from aggJoin2959272272334838156 group by v22)
select v22, v24 from aggJoin8999533026193437020 join aggView3988696790160324709 using(v22));
create or replace view aggView8954404128929708207 as select v24, v22 from aggJoin7615771903594892798 group by v24,v22;
create or replace view aggJoin4331665887747138221 as (
with aggView7266770427103929614 as (select v22, MIN(v29) as v44 from aggView3226695626629824309 group by v22)
select v24, v22, v44 from aggView8954404128929708207 join aggView7266770427103929614 using(v22));
create or replace view aggJoin5168625886385003868 as (
with aggView8966574360558110742 as (select v22, MIN(v44) as v44, MIN(v24) as v43 from aggJoin4331665887747138221 group by v22,v44)
select v32, v44, v43 from aggView1919949683341576123 join aggView8966574360558110742 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin5168625886385003868;
