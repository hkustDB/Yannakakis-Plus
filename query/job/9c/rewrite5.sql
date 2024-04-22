create or replace view aggJoin1827259811930753751 as (
with aggView8353800961600552435 as (select person_id as v35, MIN(name) as v58 from aka_name as an group by person_id)
select id as v35, name as v36, gender as v39, v58 from name as n, aggView8353800961600552435 where n.id=aggView8353800961600552435.v35 and name LIKE '%An%' and gender= 'f');
create or replace view aggJoin6314565901657382033 as (
with aggView1815312578644902820 as (select v35, MIN(v58) as v58, MIN(v36) as v60 from aggJoin1827259811930753751 group by v35,v58)
select movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v58, v60 from cast_info as ci, aggView1815312578644902820 where ci.person_id=aggView1815312578644902820.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin7769896464099451220 as (
with aggView9027746884212893258 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v9, v20, v58, v60 from aggJoin6314565901657382033 join aggView9027746884212893258 using(v22));
create or replace view aggJoin7246873455836494443 as (
with aggView1175363883758152998 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView1175363883758152998 where mc.company_id=aggView1175363883758152998.v32);
create or replace view aggJoin595909374888970222 as (
with aggView8009677476622170768 as (select v18 from aggJoin7246873455836494443 group by v18)
select id as v18, title as v47 from title as t, aggView8009677476622170768 where t.id=aggView8009677476622170768.v18);
create or replace view aggJoin1045914036862371442 as (
with aggView8967746249413866217 as (select v18, MIN(v47) as v61 from aggJoin595909374888970222 group by v18)
select v9, v20, v58 as v58, v60 as v60, v61 from aggJoin7769896464099451220 join aggView8967746249413866217 using(v18));
create or replace view aggJoin4034868735255315514 as (
with aggView3208473298090553274 as (select v9, MIN(v58) as v58, MIN(v60) as v60, MIN(v61) as v61 from aggJoin1045914036862371442 group by v9,v61,v60,v58)
select name as v10, v58, v60, v61 from char_name as chn, aggView3208473298090553274 where chn.id=aggView3208473298090553274.v9);
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin4034868735255315514;
