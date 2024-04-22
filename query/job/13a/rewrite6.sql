create or replace view aggJoin2324700261332374288 as (
with aggView2374682906353811015 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView2374682906353811015 where mc.company_type_id=aggView2374682906353811015.v8);
create or replace view aggJoin4798011847677584847 as (
with aggView5618848616184755693 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView5618848616184755693 where miidx.info_type_id=aggView5618848616184755693.v10);
create or replace view aggJoin5778849862828660093 as (
with aggView7235576574723215363 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView7235576574723215363 where mi.info_type_id=aggView7235576574723215363.v12);
create or replace view aggView8101457726141653516 as select v24, v22 from aggJoin5778849862828660093 group by v24,v22;
create or replace view aggJoin8198424858125847253 as (
with aggView8090758034079193235 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin2324700261332374288 join aggView8090758034079193235 using(v1));
create or replace view aggJoin653999432031959376 as (
with aggView5900275381375642018 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView5900275381375642018 where t.kind_id=aggView5900275381375642018.v14);
create or replace view aggView3993256049270751767 as select v22, v32 from aggJoin653999432031959376 group by v22,v32;
create or replace view aggJoin2630083832923951722 as (
with aggView2994482364121356071 as (select v22 from aggJoin8198424858125847253 group by v22)
select v22, v29 from aggJoin4798011847677584847 join aggView2994482364121356071 using(v22));
create or replace view aggView7137021310718904181 as select v22, v29 from aggJoin2630083832923951722 group by v22,v29;
create or replace view aggJoin5819185975140217659 as (
with aggView6603159064091124425 as (select v22, MIN(v29) as v44 from aggView7137021310718904181 group by v22)
select v22, v32, v44 from aggView3993256049270751767 join aggView6603159064091124425 using(v22));
create or replace view aggJoin3006660770913192672 as (
with aggView7950027929719713944 as (select v22, MIN(v44) as v44, MIN(v32) as v45 from aggJoin5819185975140217659 group by v22,v44)
select v24, v44, v45 from aggView8101457726141653516 join aggView7950027929719713944 using(v22));
select MIN(v24) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3006660770913192672;
