create or replace view aggJoin9052196525546381213 as (
with aggView3264399558709951658 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView3264399558709951658 where mi.info_type_id=aggView3264399558709951658.v21);
create or replace view aggJoin3429850158587999181 as (
with aggView4697611358204603884 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView4697611358204603884 where mc.company_id=aggView4697611358204603884.v1);
create or replace view aggJoin5095147765706123657 as (
with aggView6657651051858919726 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin3429850158587999181 join aggView6657651051858919726 using(v8));
create or replace view aggJoin1834619611896494329 as (
with aggView834615199394860461 as (select v29 from aggJoin5095147765706123657 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView834615199394860461 where t.id=aggView834615199394860461.v29 and production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')));
create or replace view aggJoin5940959876933938092 as (
with aggView2965886532635348454 as (select v29, MIN(v30) as v42 from aggJoin1834619611896494329 group by v29)
select v29, v22, v42 from aggJoin9052196525546381213 join aggView2965886532635348454 using(v29));
create or replace view aggJoin6314470630646385979 as (
with aggView6974103675930931954 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select movie_id as v29 from movie_info_idx as mi_idx, aggView6974103675930931954 where mi_idx.info_type_id=aggView6974103675930931954.v26);
create or replace view aggJoin4809429574025294856 as (
with aggView375616380330925894 as (select v29 from aggJoin6314470630646385979 group by v29)
select v22, v42 as v42 from aggJoin5940959876933938092 join aggView375616380330925894 using(v29));
select MIN(v22) as v41,MIN(v42) as v42 from aggJoin4809429574025294856;
