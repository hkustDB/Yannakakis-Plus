create or replace view aggView5595651657673796904 as select name as v2, id as v1 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin7668955916443013776 as (
with aggView1548304371129630317 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView1548304371129630317 where mi.info_type_id=aggView1548304371129630317.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin3504593942249153649 as (
with aggView2276498810765552819 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView2276498810765552819 where mk.keyword_id=aggView2276498810765552819.v14);
create or replace view aggJoin6774407321264913381 as (
with aggView2348251564437159492 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView2348251564437159492 where mi_idx.info_type_id=aggView2348251564437159492.v12 and info<'8.5');
create or replace view aggJoin8588101135781757792 as (
with aggView1157520087167456545 as (select v37 from aggJoin3504593942249153649 group by v37)
select v37, v27 from aggJoin7668955916443013776 join aggView1157520087167456545 using(v37));
create or replace view aggJoin3902513102806969273 as (
with aggView971084872604498291 as (select v37 from aggJoin8588101135781757792 group by v37)
select v37, v32 from aggJoin6774407321264913381 join aggView971084872604498291 using(v37));
create or replace view aggView3141441424157559491 as select v32, v37 from aggJoin3902513102806969273 group by v32,v37;
create or replace view aggJoin3359504319974679348 as (
with aggView9021173666203651394 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView9021173666203651394 where t.kind_id=aggView9021173666203651394.v17 and production_year>2005);
create or replace view aggView3201227123835170082 as select v37, v38 from aggJoin3359504319974679348 group by v37,v38;
create or replace view aggJoin7145812599059570964 as (
with aggView5242824729166694881 as (select v37, MIN(v38) as v51 from aggView3201227123835170082 group by v37)
select movie_id as v37, company_id as v1, company_type_id as v8, v51 from movie_companies as mc, aggView5242824729166694881 where mc.movie_id=aggView5242824729166694881.v37);
create or replace view aggJoin6609624326389173541 as (
with aggView4709348562680203967 as (select v1, MIN(v2) as v49 from aggView5595651657673796904 group by v1)
select v37, v8, v51 as v51, v49 from aggJoin7145812599059570964 join aggView4709348562680203967 using(v1));
create or replace view aggJoin2859071600169009039 as (
with aggView7979365963016333780 as (select id as v8 from company_type as ct)
select v37, v51, v49 from aggJoin6609624326389173541 join aggView7979365963016333780 using(v8));
create or replace view aggJoin1594514968677340572 as (
with aggView8250432577546701781 as (select v37, MIN(v51) as v51, MIN(v49) as v49 from aggJoin2859071600169009039 group by v37,v51,v49)
select v32, v51, v49 from aggView3141441424157559491 join aggView8250432577546701781 using(v37));
select MIN(v49) as v49,MIN(v32) as v50,MIN(v51) as v51 from aggJoin1594514968677340572;
