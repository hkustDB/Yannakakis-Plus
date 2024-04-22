create or replace view aggView6862924889942652443 as select title as v30, id as v29 from title as t where production_year<=2008 and production_year>=2005;
create or replace view aggView8541447937657350627 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin7890227510623828725 as (
with aggView5155675546998069821 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView5155675546998069821 where mi_idx.info_type_id=aggView5155675546998069821.v26);
create or replace view aggJoin4808317781514923513 as (
with aggView2784490967618032617 as (select v27, v29 from aggJoin7890227510623828725 group by v27,v29)
select v29, v27 from aggView2784490967618032617 where v27>'8.0');
create or replace view aggJoin8860680270671632108 as (
with aggView3069431679714596422 as (select v1, MIN(v2) as v41 from aggView8541447937657350627 group by v1)
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView3069431679714596422 where mc.company_id=aggView3069431679714596422.v1);
create or replace view aggJoin2215528355849751692 as (
with aggView7064640813089349349 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView7064640813089349349 where mi.info_type_id=aggView7064640813089349349.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin7523250410932362431 as (
with aggView1002693241609446624 as (select v29 from aggJoin2215528355849751692 group by v29)
select v29, v8, v41 as v41 from aggJoin8860680270671632108 join aggView1002693241609446624 using(v29));
create or replace view aggJoin1239488290437896443 as (
with aggView5952698495834839743 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin7523250410932362431 join aggView5952698495834839743 using(v8));
create or replace view aggJoin7114286497983895766 as (
with aggView9141091138561825493 as (select v29, MIN(v41) as v41 from aggJoin1239488290437896443 group by v29,v41)
select v29, v27, v41 from aggJoin4808317781514923513 join aggView9141091138561825493 using(v29));
create or replace view aggJoin6360860284221747840 as (
with aggView4454521583713260575 as (select v29, MIN(v41) as v41, MIN(v27) as v42 from aggJoin7114286497983895766 group by v29,v41)
select v30, v41, v42 from aggView6862924889942652443 join aggView4454521583713260575 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v30) as v43 from aggJoin6360860284221747840;
