create or replace view aggView1900338455490643409 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin4648271471861653503 as (
with aggView1991134022171876982 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView1991134022171876982 where t.kind_id=aggView1991134022171876982.v14);
create or replace view aggView7083425634569958308 as select v32, v22 from aggJoin4648271471861653503 group by v32,v22;
create or replace view aggJoin7617348848071139042 as (
with aggView382567471820263720 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView382567471820263720 where mi.info_type_id=aggView382567471820263720.v12);
create or replace view aggJoin1585493017404002639 as (
with aggView2725080886989438578 as (select v22 from aggJoin7617348848071139042 group by v22)
select movie_id as v22, info_type_id as v10, info as v29 from movie_info_idx as miidx, aggView2725080886989438578 where miidx.movie_id=aggView2725080886989438578.v22);
create or replace view aggJoin1845584192546843867 as (
with aggView5218877530072571831 as (select id as v10 from info_type as it where info= 'rating')
select v22, v29 from aggJoin1585493017404002639 join aggView5218877530072571831 using(v10));
create or replace view aggView6372005854604121645 as select v22, v29 from aggJoin1845584192546843867 group by v22,v29;
create or replace view aggJoin8802888156660716145 as (
with aggView2293966832431873403 as (select v22, MIN(v29) as v44 from aggView6372005854604121645 group by v22)
select v32, v22, v44 from aggView7083425634569958308 join aggView2293966832431873403 using(v22));
create or replace view aggJoin6443923056515335023 as (
with aggView6834944265408596037 as (select v22, MIN(v44) as v44, MIN(v32) as v45 from aggJoin8802888156660716145 group by v22,v44)
select company_id as v1, company_type_id as v8, v44, v45 from movie_companies as mc, aggView6834944265408596037 where mc.movie_id=aggView6834944265408596037.v22);
create or replace view aggJoin6995130740469547481 as (
with aggView522305224947035713 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v44, v45 from aggJoin6443923056515335023 join aggView522305224947035713 using(v8));
create or replace view aggJoin2004229505809837474 as (
with aggView7963575748222286058 as (select v1, MIN(v44) as v44, MIN(v45) as v45 from aggJoin6995130740469547481 group by v1,v44,v45)
select v2, v44, v45 from aggView1900338455490643409 join aggView7963575748222286058 using(v1));
select MIN(v2) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin2004229505809837474;
