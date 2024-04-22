create or replace view aggJoin769330155970675509 as (
with aggView2150731010448979417 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView2150731010448979417 where mc.company_id=aggView2150731010448979417.v1);
create or replace view aggJoin3539369329706523377 as (
with aggView5333210827246749004 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin769330155970675509 join aggView5333210827246749004 using(v8));
create or replace view aggJoin6369628595501425821 as (
with aggView3801797557622160156 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView3801797557622160156 where mi_idx.info_type_id=aggView3801797557622160156.v26 and info>'7.0');
create or replace view aggJoin9552915194358165 as (
with aggView2383341643773353992 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView2383341643773353992 where mi.info_type_id=aggView2383341643773353992.v21 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin7691162375355567662 as (
with aggView68935930856230668 as (select v29 from aggJoin9552915194358165 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView68935930856230668 where t.id=aggView68935930856230668.v29 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin7856266003208657197 as (
with aggView235695576615182826 as (select v29, MIN(v30) as v43 from aggJoin7691162375355567662 group by v29)
select v29, v27, v43 from aggJoin6369628595501425821 join aggView235695576615182826 using(v29));
create or replace view aggJoin3343728293232704813 as (
with aggView1388235136424207336 as (select v29, MIN(v43) as v43, MIN(v27) as v42 from aggJoin7856266003208657197 group by v29,v43)
select v41 as v41, v43, v42 from aggJoin3539369329706523377 join aggView1388235136424207336 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin3343728293232704813;
